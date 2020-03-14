local Hammer = {}
Hammer.__index = Hammer

local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")

local RegularBan = require(script.RegularBan)
local TimedBan = require(script.TimedBan)
local Webhooks = require(script.Webhooks)

function Hammer.Init(Settings)
    local self = setmetatable({}, Hammer)

    if Settings then
        self.Settings = Settings 
     end

    local function PlayerAdded(Player)
        local IsBanned, Reason = RegularBan:IsBanned(Player)

        if IsBanned then
            Player:Kick(Reason)
            return
        end

        if self.Settings.CmdsEnabled and self.Settings.Admins and table.find(self.Settings.Admins, Player.UserId) then
            Player.Chatted:Connect(function(Message)
                
                local MsgPrefix = string.sub(Message, 1, 1)

                if (MsgPrefix == self.Settings.CmdPrefix or MsgPrefix == "/") then
                    local Arguments = string.split(string.lower(string.sub(Message, 2, -1)), " ")
                    local NonLoweredArguments = string.split(string.sub(Message, 2, -1), " ")
                    print(Arguments[1])
                    if Arguments[1] == "ban" then
 
                        if Players:FindFirstChild(NonLoweredArguments[2]) then

                            self:Ban(Players[NonLoweredArguments[2]])
                        end
                    elseif Arguments[1] == "timedban" then
                        --// TODO
                    end
                end
            end)
        end
    end

    for _, Player in ipairs(Players:GetPlayers()) do
        PlayerAdded(Player)
    end

    self.PlayerAddedConnection = Players.PlayerAdded:Connect(PlayerAdded)

    return self
end

function Hammer:Ban(Player)
    if Player then
        local Reason = self.Settings.BannedMessage or "You have been banned from the game!"
        RegularBan:Ban(Player, Reason)

        if self.Settings.WebhookURL then
            Webhooks:SendGotBanned(self.Settings.WebhookURL, Player)
        end
    end
end   

function Hammer:TimedBan(Player, Seconds)
    if Player then
        local Reason = self.Settings.BannedMessage or "You have been temporarily banned!"
        TimedBan:Ban(Player, Seconds, Reason)

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
    if Player and (select(1, RegularBan:IsBanned(Player)) or select(1, TimedBan:IsBanned(Player))) then
        return true
    else
        return false
    end
end

return Hammer