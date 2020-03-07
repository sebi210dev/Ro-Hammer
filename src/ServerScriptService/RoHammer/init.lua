local Hammer = {}
local ServerScriptService = game:GetService("ServerScriptService")
local DS2 = require(ServerScriptService.DataStore2)
DS2.Combine("MasterKey", "Bans", "TimedBans")

function Hammer:Init(player)
    local BanStore = DS2("Bans", player)

    if BanStore:Get() == true then
        player:Kick("You are banned from the game.")
    end
end



return Hammer