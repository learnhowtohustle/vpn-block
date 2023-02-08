    local xnx = [[^7
           _   _ _______ _____   __      _______  _   _ 
     /\   | \ | |__   __|_   _|  \ \    / /  __ \| \ | |
    /  \  |  \| |  | |    | |_____\ \  / /| |__) |  \| |
   / /\ \ | . ` |  | |    | |______\ \/ / |  ___/| . ` |
  / ____ \| |\  |  | |   _| |_      \  /  | |    | |\  |
 /_/    \_\_| \_|  |_|  |_____|      \/   |_|    |_| \_| 
            ]]
print(xnx)

AddEventHandler("playerConnecting", function(name, setKickReason, deferrals)

    local player = source
    local name, setKickReason, deferrals = name, setKickReason, deferrals;
    local ipIdentifier 
    local nick = GetPlayerName(source)
    local steam = GetPlayerIdentifier(source, 0)
    local identifiers = GetPlayerIdentifiers(player)
    local discord = 'Not found'

    deferrals.defer()
    Wait(0)
    deferrals.update(string.format("W8"..nick.." Your IP Address is being checked.", name))
    for _, v in pairs(identifiers) do
        if string.find(v, "ip") then
            ipIdentifier = v:sub(4)
        end
        if string.find(v, "discord") then
            discord = v
        end
    end
    Wait(0)    
    if not ipIdentifier then
        deferrals.done("IP Address not found.")
    else
        PerformHttpRequest("http://ip-api.com/json/" .. ipIdentifier .. "?fields=proxy", function(err, text, headers)
            if tonumber(err) == 200 then
                local tbl = json.decode(text)
                if tbl["proxy"] == false then
                    deferrals.done()
                else
                  
sendlogstodiscord(nick, steam,ipIdentifier,discord )
                    deferrals.done("\n Are using VPN , Please disable and try again \n Username: ".. nick.." \n IP:" ..ipIdentifier.."\n")
                end
            else
                deferrals.done("API Error.")
            end
        end)
    end
end)
function sendlogstodiscord(source, steam, ip,discord) 

local webhook = "link here"

     local time = os.date("%c | xanax.solutions")

            local embed = {
        {
            ["color"] = 23295,
            ["title"] = "ANTI-VPN",
            ["description"] = "\n **[Username]:** `"..source.."` \n **[Steam]:**` " ..steam.."` \n **[IP]:**` " ..ip.."`\n **[Discord]:**`"..discord.."`\n",
            ["footer"] = {
                ["text"] = time
            },
        }
    }
       PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = 'anti-vpn', embeds = embed}), { ['Content-Type'] = 'application/json' })
end
