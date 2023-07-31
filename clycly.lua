-- clycly.lua

local whitelist = loadstring(game:HttpGet("https://raw.githubusercontent.com/onclycly/whitelist-clyhub/main/whitelist.lua"))()
local HWID = game:GetService("RbxAnalyticsService"):GetClientId()

local keyMatched = false

for hwid, key in pairs(whitelist) do
    if hwid == HWID and _G.SKey == key then
        keyMatched = true
        break
    end
end

if keyMatched then
    -- Insert the rest of the code here that should run if the key matches the HWID.
    -- For example, load your clyhub script:
    loadstring(game:HttpGet('https://raw.githubusercontent.com/onclycly/main/main/clyhub'))()
else
    -- If the key doesn't match the HWID or HWID not found in the whitelist, you can do something else or display an error message.
    print("Invalid key or HWID not whitelisted.")
end
