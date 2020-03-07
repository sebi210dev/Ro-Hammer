local Hammer = {}
local ServerScriptService = game:GetService("ServerScriptService")
local DS2 = require(ServerScriptService.DataStore2)
DS2.Combine("MasterKey", "Bans", "TimedBans")

local RegularBan = require(script.RegularBan)


function Hammer:Init(player)
    local BanStore = DS2("Bans", player)

    if BanStore:Get() == nil then
        BanStore:Set(false)
    end

    if BanStore:Get() == true then
        player:Kick("You are banned from the game.")
    end
end

function Hammer:Ban(player)

    if player then
        RegularBan:Ban(player)
    end
end   

function Hammer:Unban(player)
    if player then
        RegularBan:Unban(player)
    end
end

return Hammer