local Webhooks = {}
local HttpService = game:GetService("HttpService")

function Webhooks:SendGotBanned(URL, Player, PersonWhoBanned)
    local Date = os.date("!*t")
    local Data = {
        ["embeds"] = {
            {
                ["title"] = "Hammer - Ban successful";
                ["color"] = Color3.fromRGB(255, 0, 0);
                ["fields"] = {
                    {
                        ["name"] = "Player banned:";
                        ["value"] = Player.Name
                    };
                    {
                        ["name"] = "Banned at:";
                        ["value"] = string.format("%d:%d:%d %d/%d/%d", Date.hour, Date.min, Date.sec, Date.day, Date.month, Date.year)
                    };
                }
            }
        }  
    }

    local Encoded = HttpService:JSONEncode(Data)
    print(Encoded)
    HttpService:PostAsync(URL, Encoded)
end

return Webhooks

