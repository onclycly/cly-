local HWIDTable = loadstring(game:HttpGet("https://raw.githubusercontent.com/onclycly/whitelist-clyhub/main/whitelist"))()
local HWID = game:GetService("RbxAnalyticsService"):GetClientId()

for i,v in pairs(HWIDTable) do
    if v == HWID then
        loadstring(game:HttpGet('https://raw.githubusercontent.com/onclycly/main/main/clyhub'))()
        loadstring(game:HttpGet('https://pastebin.com/raw/qTtzFdK6'))()
        print("valid")
    end
end
