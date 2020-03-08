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
        end
    end)

    return self
end

function Hammer:Ban(Player)
    if Player then
        RegularBan:Ban(Player, self.Settings.BannedMessage or "You have been banned from the game!")

        if self.Settings.SendWebhook and self.Settings.WebhookURL then
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
        return false
    else
        return true
    end
end

return Hammer