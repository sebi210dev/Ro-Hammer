local RegularBan = {}
local ServerScriptService = game:GetService("ServerScriptService")
local SavingModule = require(script.Parent.SavingModule).new("Regular")

function RegularBan:Ban(Player, Message)
    if not SavingModule:Get(Player.UserId).IsBanned then
        SavingModule:Set(Player.UserId, {
            IsBanned = true;
            Reason = Message or "You have been banned.";
        })

        Player:Kick(Message)
    end
end

function RegularBan:Unban(Player)
    SavingModule:Set(Player.UserId, {
        IsBanned = false;
        Reason = "";
    })
end

function RegularBan:IsBanned(Player)
    local Data = SavingModule:Get(Player.UserId)
    return Data.IsBanned, Data.Reason
end

return RegularBan