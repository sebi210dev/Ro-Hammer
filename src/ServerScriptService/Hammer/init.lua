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

    self.Connection = Players.PlayerAdded:Connect(function(Player)
        local BanStore = DS2("Bans", player)
        local IsBanned = BanStore:Get()

        if IsBanned == nil then
            BanStore:Set(false)
        elseif IsBanned == true then
            Player:Kick(self.Settings.BanMessage or "You are banned from the game.")
        end
    end)

    if Settings then
       self.Settings = Settings 
    end

    return self
end

function Hammer:Ban(Player)
    if Player then
        RegularBan:Ban(Player, self.Settings.BannedMessage or "You have been banned from the game!")

        if self.Settings.SendWebhook then
            
        end
    end
end   

function Hammer:Unban(Player)
    if Player then
        RegularBan:Unban(Player)
    end
end

function Hammer:IsBanned(Player)
    if Player then
        return RegularBan:IsBanned(Player)
    end
end

return Hammer