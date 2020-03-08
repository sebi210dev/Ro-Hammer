local TimedBan = {}
local ServerScriptService = game:GetService("ServerScriptService")
local DS2 = require(ServerScriptService.Hammer.DataStore2)
local RegularBan = require(ServerScriptService.Hammer.RegularBan)

    function TimedBan:Ban(Player, TimeInSeconds, Message)
        if not RegularBan:IsBanned() then
            local UnbanTime = os.time() + TimeInSeconds
            DS2("TimedBans", player):Set(UnbanTime)
            Player:Kick(Message)
        end
    end

return TimedBan