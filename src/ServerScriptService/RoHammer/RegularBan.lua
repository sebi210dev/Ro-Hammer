local RegularBan = {}
local ServerScriptService = game:GetService("ServerScriptService")
local DS2 = require(ServerScriptService.DataStore2)

function RegularBan:Ban(player)
    if DS2("Bans", player):Get() == false then
        DS2("Bans", player):Set(true)
        player:Kick("You have been banned from the game!")
    end
end

function RegularBan:Unban(player)
    DS2("Bans", player):Set(false)
end

return RegularBan