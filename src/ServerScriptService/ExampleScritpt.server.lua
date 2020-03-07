local ServerScriptService = game:GetService("ServerScriptService")

local RoHammer = require(ServerScriptService.RoHammer)

game.Players.PlayerAdded:Connect(function(player)
    RoHammer:Unban(player)
    RoHammer:Init(player)




end)