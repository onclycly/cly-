-- FUNCTIONS

getgenv().SunaActive = false

function sunaStack()
    spawn (function ()
        while getgenv().SunaActive do
            task.wait()
            local args = {
                [1] = "Desert Spada",
                [2] = {
                ["cf"] = CFrame.new(-3694.07275, 15.0927734, 138.661896, 0.999832332, -0.000389953493, 0.0183105897, -0, 0.999773383, 0.0212917831, -0.0183147416, -0.0212882124, 0.999605656)
            }
            }
                
            game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Skill"):InvokeServer(unpack(args))
        end
    end)
end

function releaseStack()
    
    local args = {
        [1] = CFrame.new(-3688.59082, 18.1677742, 423.727539, 0.998908818, -3.40270361e-07, 0.046702411, 2.04845273e-05, 0.999999881, -0.00043085363, -0.0467024073, 0.000431340188, 0.998908758)
     }
        
     game:GetService("ReplicatedStorage"):WaitForChild("PlayerRemotes"):WaitForChild(game.Players.LocalPlayer.Name.."|ServerScriptService.Skills.Skills.SkillContainer.Suna-Suna.Desert Spada"):FireServer(unpack(args))
    
end

function NoClip()
    local Player = game:GetService("Players").LocalPlayer
    while game:GetService("RunService").Stepped:Wait() do
    local Character = Player.Character or Player.CharacterAdded:Wait() 
    Character.UpperTorso.CanCollide = false
    Character.LowerTorso.CanCollide = false
    Character.Head.CanCollide = false
    Character.HumanoidRootPart.CanCollide = false
    end
end

function Clip()
    local Player = game:GetService("Players").LocalPlayer
    while game:GetService("RunService").Stepped:Wait() do
    local Character = Player.Character or Player.CharacterAdded:Wait() 
    Character.UpperTorso.CanCollide = true
    Character.LowerTorso.CanCollide = true
    Character.Head.CanCollide = true
    Character.HumanoidRootPart.CanCollide = true
    end
end

function NormalServerHop()
    local Player = game.Players.LocalPlayer    
	local Http = game:GetService("HttpService")
	local TPS = game:GetService("TeleportService")
	local Api = "https://games.roblox.com/v1/games/"

	local _place,_id = game.PlaceId, game.JobId
	local _servers = Api.._place.."/servers/Public?sortOrder=Desc&limit=100"
	function ListServers(cursor)
	local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
	return Http:JSONDecode(Raw)
	end

	local Next; repeat
	local Servers = ListServers(Next)
	for i,v in next, Servers.data do
		if v.playing < v.maxPlayers and v.id ~= _id then
			local s,r = pcall(TPS.TeleportToPlaceInstance,TPS,_place,v.id,Player)
			if s then break end
		end
	end
	
	Next = Servers.nextPageCursor
	until not Next
end

function LowServerHop()
    local Http = game:GetService("HttpService")
	local TPS = game:GetService("TeleportService")
	local Api = "https://games.roblox.com/v1/games/"

	local _place = game.PlaceId
	local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=100"
	function ListServers(cursor)
	local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
	return Http:JSONDecode(Raw)
	end

	local Server, Next; repeat
	local Servers = ListServers(Next)
	Server = Servers.data[1]
	Next = Servers.nextPageCursor
	until Server

	TPS:TeleportToPlaceInstance(_place,Server.id,game.Players.LocalPlayer)
end

-- GUI

local library = loadstring(game:GetObjects("rbxassetid://7657867786")[1].Source)()
local Wait = library.subs.Wait -- Only returns if the GUI has not been terminated. For 'while Wait() do' loops

local GPO = library:CreateWindow({
Name = "Grand Piece Online",
Themeable = {
    Credit = false,
    Background = "7042826011",
}
})

local GeneralTab = GPO:CreateTab({
Name = "Main"
})

local LocalPlayerSection = GeneralTab:AddSection({
Name = "Local Player"
})

LocalPlayerSection:AddButton({
Name = "Enable No-Clip",
Callback = function ()
    NoClip()
end
})

LocalPlayerSection:AddButton({
Name = "Disable No-Clip",
Callback = function ()
    Clip()
end
})

local StackSection = GeneralTab:AddSection({
Name = "Movestacks"
})

StackSection:AddToggle({
Name = "Suna X Stack",
Flag = "StackSection_SunaXStack",
Keybind = 1,
Callback = function (state)
    getgenv().SunaActive = state
     if state then
        sunaStack()
    end
end
})

StackSection:AddButton({
Name = "Suna X Release",
Keybind = 1,
Callback = function ()
    releaseStack()
end
})

StackSection:AddKeybind({
Name = "Release Keybind",
Value = Enum.KeyCode.G,
Callback = function ()
    releaseStack()
end
})

local ServerSection = GeneralTab:AddSection({
Name = "Servers"
})

ServerSection:AddButton({
Name = "Server Hop",
Callback = function ()
    NormalServerHop()
end
})

ServerSection:AddButton({
Name = "Server Hop (Lowest Player)",
Callback = function ()
    LowServerHop()
end
})
