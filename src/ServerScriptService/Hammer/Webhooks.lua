local Webhooks = {}
local HttpService = game:GetService("HttpService")

function Webhooks:SendGotBanned(URL, Player, PersonWhoBanned)
    local Date = os.date("!*t")
    local Content = {
        embeds = {
            {
                title = "Hammer - Ban successful";
                color = Color3.fromRGB(255, 0, 0);
                fields = {
                    {
                        name = "Player banned:";
                        value = Player
                    };
                    {
                        name = "Banned at:";
                        value = string.format("%d:%d:%d %d/%d/%d", Date.sec, Date.min, Date.hour, Date.day, Date.month, Date.year)
                    };
                }
            }
        }
    }

    local Encoded = HttpService:JSONEncode(Content)
    print(Encoded)
    HttpService:PostAsync(URL, Encoded)
end

return Webhooks

