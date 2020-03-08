local Webhooks = {}
local HttpService = game:GetService("HttpService")

function Webhooks:SendGotBanned(URL, Player, PersonWhoBanned)
    local Content = {
        embeds = {
            {
                title = "Hammer - Ban successful";
                color = Color3.fromRGB(255, 0, 0);
                fields = {
                    {
                        name = "Player banned";
                        value = Player
                    };
                }
            }
        }
    }

    local Encoded = HttpService:JSONEncode(Content)
    HttpService:PostAsync(URL, Encoded)
end

return Webhooks

