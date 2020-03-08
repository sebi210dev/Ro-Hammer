local Hammer = {}
Hammer.__index = Hammer

local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")
local DS2 = require(ServerScriptService.Hammer.DataStore2)
DS2.Combine("MasterKey", "Bans", "TimedBans")

local RegularBan = require(script.RegularBan)
local Webhooks = require(script.Webhooks)

function Hammer.Init(Settings)
    local self = setmetatable({}, Hammer)

    if Settings then
        self.Settings = Settings 
     end

    self.PlayerAddedConnection = Players.PlayerAdded:Connect(function(Player)
        local BanStore = DS2("Bans", Player)
        local IsBanned = BanStore:Get()

        if IsBanned then
            Player:Kick(self.Settings.BanMessage or "You are banned from the game.")
            return
        end

        if self.Settings.CmdsEnabled and self.Settings.Admins and table.find(self.Settings.Admins, Player.UserId) then
            Player.Chatted:Connect(function(Message)
                local MsgPrefix = string.sub(Message, 1, 1)

                if MsgPrefix == (self.Settings.CmdPrefix or "/") then
                    local Arguments = string.split(string.lower(string.sub(Message, 2, -1), " "))
                    local NonLoweredArguments = string.split(string.sub(Message, 2, -1), " ")

                    if Arguments[1] == "ban" then
                        if Players:FindFirstChild(NonLoweredArguments[2]) then
                            self:Ban(Players[NonLoweredArguments[2]])
                        end
                    end
                end
            end)
        end
    end)

    return self
end

function Hammer:Ban(Player)
    if Player then
        RegularBan:Ban(Player, self.Settings.BannedMessage or "You have been banned from the game!")

        if self.Settings.WebhookURL then
            Webhooks:SendGotBanned(self.Settings.WebhookURL, Player)
        end
    end
end   

function Hammer:Unban(Player)
    if Player then
        RegularBan:Unban(Player)
    end
end

function Hammer:IsBanned(Player)
    if Player and DS2("Bans", Player):Get() and os.time() > DS2("TimedBans", Player):Get() then
        print("Returned false")
        return false
    else
        print("Returned true")
        return true
    end
end

return Hammer