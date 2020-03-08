local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")

local SebiId = Players:GetUserIdFromNameAsync("sebi210")

local Options = {
    SendWebhook = true;
    WebhookURL = "https://discordapp.com/api/webhooks/685936389153488953/YRCBeJ_B71EKO_t9Pk0A5dK0pb-hRjqXv15XIiHi-M2bzo0KtIVfI8tCAC-tAGGK-CwI";
    BanMessage = "Get beaned!";
    BannedMessage = "You are beaned!";
}

local Hammer = require(ServerScriptService.Hammer)
Hammer.Init(Options)

--// Ban sebi for not using OOP
Players.PlayerAdded:Connect(function(Player)
    print(Hammer:IsBanned(Player))
    if (Player.UserId == SebiId and not Hammer:IsBanned(Player)) then
        Hammer:Ban(Player)
        prtin("Banned")
    end
end)