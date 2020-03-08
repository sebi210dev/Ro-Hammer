local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")

local SebiId = Players:GetUserIdFromNameAsync("sebi210")
local ReturnId = Players:GetUserIdFromNameAsync("ReturnedTrue")

local Options = {
    CmdsEnabled = true;
    CmdPrefix = ":";
    Admins = {ReturnId, SebiId};
    WebhookURL = "https://discordapp.com/api/webhooks/685936389153488953/YRCBeJ_B71EKO_t9Pk0A5dK0pb-hRjqXv15XIiHi-M2bzo0KtIVfI8tCAC-tAGGK-CwI";
    BanMessage = "Get beaned!";
    BannedMessage = "You are beaned!";
}

local Module = require(ServerScriptService.Hammer)
local Hammer = Module.Init(Options)

--// Ban sebi for not using OOP
local function PlayerAdded(Player)
    local IsBanned = Hammer:IsBanned(Player)
    --if (Player.UserId == SebiId and not IsBanned) then
      --  Hammer:Ban(Player)
    --end
end

for _, Player in ipairs(Players:GetPlayers()) do
    PlayerAdded(Player)
end

Players.PlayerAdded:Connect(PlayerAdded)