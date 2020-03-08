local RegularBan = {}
local ServerScriptService = game:GetService("ServerScriptService")
local DS2 = require(ServerScriptService.Hammer.DataStore2)

function RegularBan:Ban(Player, Message)
    local Store = DS2("Bans", Player)
    if not Store:Get() then
        Store:Set(true)
        player:Kick(Message))
    end
end

function RegularBan:Unban(Player)
    DS2("Bans", Player):Set(false)
end

function RegularBan:IsBanned(Player)
    return DS2("Bans", Player):Get()
end

return RegularBan