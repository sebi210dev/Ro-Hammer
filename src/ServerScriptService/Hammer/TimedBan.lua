local TimedBan = {}
local ServerScriptService = game:GetService("ServerScriptService")
local SavingModule = require(script.Parent.SavingModule).new("Timed")
local RegularBan = require(ServerScriptService.Hammer.RegularBan)

function TimedBan:Ban(Player, TimeInSeconds, Message)
    if not RegularBan:IsBanned(Player) then
        local UnbanTime = os.time() + TimeInSeconds
        SavingModule:Set(Player.UserId, {
            Time = UnbanTime;
            Reason = Message;
        })
        Player:Kick(Message)
    end
end

function TimedBan:IsBanned(Player)
    local Data = SavingModule:Get(Player.UserId)
    return (os.time() - Data.Time) > 0, Data.Reason
end

return TimedBan