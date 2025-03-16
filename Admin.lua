--// Settings
local Settings = {
	Prefix = "-";

	Whitelist = {
		"Di33le3", -- Add usernames here
		"neve11591",
		"SirKhalidBlox",
		"rosepookie1",
		"RUBYMEEEEMEEE",
		"t_echr"
	};

	DeadMansSwitch = false; -- If u get kicked or banned the server gets killed.
}

--// Internals
local Internals = {
	-- Commands / Toggles
	autore = {};
	Banned = {"D_ionte"};
	Chats = {};
	Commands = {};
	Countries = {};
	FpsLooped = {};
	Muted = {};
	Serverlock = false;
	Trolling = {
		CamTroll = {}
	};
	Warned = {};

	-- Ui Elements
	Icons = {
		["Error"] = "rbxassetid://94362538974098",
		["Info"] = "rbxassetid://103455396505678",
		["Success"] = "rbxassetid://72024654106640",
		["Warn"] = "rbxassetid://108125574645285"
	};

	-- Scripts
	Scripts = {
		Exser = {ID = "10868847330", Module = ":pls"},
		KasperUTG = {ID = "7993536803", Module = ".KasperUTGeditedByDog"}
	};
	
	Secrets = {
		AssetPassword = "DIZZYAccess112"
	}
}

--[[
	Many commands were taken from https://raw.githubusercontent.com/pcxo/cxos-admin/refs/heads/main/admin 
]]--


local Players = game.Players
local UserInputService = game:GetService("UserInputService")


local DIZZYFOLDER = Instance.new("Folder", game.ReplicatedStorage)
DIZZYFOLDER.Name = "DIZZYs Folder"

local BuildFolder = Instance.new("Folder", DIZZYFOLDER)
BuildFolder.Name = "DIZZYs Stored Builds Folder"


-- Preload ASSETS

require(123764473198037).DizzySSBuildLoad() -- Roblox Ball Gyro
require(74730262689062).DizzySSBuildLoad() -- Mclaren Sienna
require(91324836980339).DizzySSBuildLoad() -- Rimac Nevera
require(72122600693653).DizzySSBuildLoad() -- Bugatti Bolide
require(110485306545671).DizzySSBuildLoad() -- Koenigsegg Agera

require(128010285971411).DizzySSBuildLoad() -- Treehouse



--// Get Whitelist
function GetWhitelist()
	return Settings.Whitelist
end

--// Player Finder
function p(a, me)
	local ps = game.Players:GetPlayers()
	local found = {}

	if a:lower() == "me" then
		found = {me}
	elseif a:lower() == "others" then
		for i, player in ipairs(ps) do
			if player ~= me then
				table.insert(found, player)
			end
		end
	elseif a:lower() == "all" then
		found = ps
	elseif a:lower() == "random" then
		if #ps > 0 then
			found = {ps[math.random(1, #ps)]}
		end
	else
		for i, player in ipairs(ps) do
			if player.Name:lower():sub(1, #a) == a:lower() or player.DisplayName:lower():sub(1, #a) == a:lower() then
				table.insert(found, player)
			end
		end
	end

	return found
end

--// Add Command
local function addcmd(data)
	if Internals.Commands[data.Name] then return end
	if not data.Aliases then data.Aliases = {} end
	Internals.Commands[data.Name] = { Data = data }
end

--// Notification Function
function notif(plr, title, message, icon)
	coroutine.wrap(function()
		if not plr or not plr:FindFirstChild("PlayerGui") then
			return
		end
		require(105306341303469).DizzySSAsset_2(plr, title, message, icon, Internals.Secrets.AssetPassword)
	end)()
end

local function announce(sender, player, message)
	local G2L = {}

	G2L["1"] = Instance.new("ScreenGui")
	G2L["1"].Name = "Announcement"
	G2L["1"].ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	G2L["1"].ResetOnSpawn = true
	G2L["1"].Parent = player:WaitForChild("PlayerGui")

	G2L["2"] = Instance.new("Frame", G2L["1"])
	G2L["2"].BorderSizePixel = 0
	G2L["2"].BackgroundColor3 = Color3.fromRGB(26, 26, 26)
	G2L["2"].AnchorPoint = Vector2.new(0.5, 0.5)
	G2L["2"].Size = UDim2.new(0, 0, 0.025, 0)
	G2L["2"].Position = UDim2.new(0.5, 0, 0.29772, 0)
	G2L["2"].BorderColor3 = Color3.fromRGB(0, 0, 0)
	G2L["2"].Name = "TopBar"

	G2L["3"] = Instance.new("Frame", G2L["2"])
	G2L["3"].BorderSizePixel = 0
	G2L["3"].BackgroundColor3 = Color3.fromRGB(41, 41, 41)
	G2L["3"].Size = UDim2.new(1, 0, 0, 0)
	G2L["3"].Position = UDim2.new(0, 0, 1, 0)
	G2L["3"].BorderColor3 = Color3.fromRGB(0, 0, 0)
	G2L["3"].Name = "MFrame"
	G2L["3"].BackgroundTransparency = 0.1

	G2L["4"] = Instance.new("TextLabel", G2L["3"])
	G2L["4"].TextWrapped = true
	G2L["4"].BorderSizePixel = 0
	G2L["4"].TextXAlignment = Enum.TextXAlignment.Center
	G2L["4"].TextYAlignment = Enum.TextYAlignment.Center
	G2L["4"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	G2L["4"].TextSize = 14
	G2L["4"].Font = Enum.Font.Arial
	G2L["4"].TextColor3 = Color3.fromRGB(255, 255, 255)
	G2L["4"].BackgroundTransparency = 1
	G2L["4"].Size = UDim2.new(0, 313, 0, 158)
	G2L["4"].Text = message
	G2L["4"].Visible = false
	G2L["4"].BorderColor3 = Color3.fromRGB(0, 0, 0)
	G2L["4"].Position = UDim2.new(0.5, 0, 0.5, 0)
	G2L["4"].AnchorPoint = Vector2.new(0.5, 0.5)

	if #message > 40 then
		G2L["4"].TextSize = 12
	elseif #message > 35 then
		G2L["4"].TextSize = 14
	elseif #message > 30 then
		G2L["4"].TextSize = 16
	elseif #message > 20 then
		G2L["4"].TextSize = 17
	elseif #message > 12 then
		G2L["4"].TextSize = 20
	else
		G2L["4"].TextSize = 22
	end

	G2L["5"] = Instance.new("TextButton", G2L["2"])
	G2L["5"].BorderSizePixel = 0
	G2L["5"].TextSize = 14
	G2L["5"].TextColor3 = Color3.fromRGB(68, 0, 0)
	G2L["5"].BackgroundColor3 = Color3.fromRGB(68, 0, 0)
	G2L["5"].Font = Enum.Font.SourceSans
	G2L["5"].AnchorPoint = Vector2.new(0.5, 0.5)
	G2L["5"].Size = UDim2.new(0.03, 0, 0.9, 0)
	G2L["5"].Name = "Close"
	G2L["5"].BorderColor3 = Color3.fromRGB(0, 0, 0)
	G2L["5"].Text = ""
	G2L["5"].Position = UDim2.new(0.982, 0, 0.5, 0)

	G2L["6"] = Instance.new("TextButton", G2L["2"])
	G2L["6"].TextWrapped = true
	G2L["6"].BorderSizePixel = 0
	G2L["6"].TextSize = 14
	G2L["6"].TextColor3 = Color3.fromRGB(255, 255, 255)
	G2L["6"].TextScaled = true
	G2L["6"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	G2L["6"].Font = Enum.Font.SourceSansBold
	G2L["6"].RichText = true
	G2L["6"].AnchorPoint = Vector2.new(0.5, 0.5)
	G2L["6"].Size = UDim2.new(0.47236, 0, 0.8745, 0)
	G2L["6"].BackgroundTransparency = 1
	G2L["6"].Name = "Uame"
	G2L["6"].BorderColor3 = Color3.fromRGB(0, 0, 0)
	G2L["6"].Text = "Message From: " .. sender.Name
	G2L["6"].Visible = false
	G2L["6"].Position = UDim2.new(0.5, 0, 0.5, 0)

	G2L["7"] = Instance.new("LocalScript", G2L["1"])
	G2L["7"].Name = "Handler"

	local function C_7()
		local script = G2L["7"]
		local TopBar = script.Parent.TopBar
		local MainFrame = TopBar.MFrame
		local AnnouncementText = MainFrame.TextLabel
		local Close = TopBar.Close
		local UserName = TopBar.Uame

		Close.MouseButton1Click:Connect(function()	
			Close.Visible = false
			TopBar.Uame.Visible = false
			AnnouncementText.Visible = false
			MainFrame:TweenSize(UDim2.new(1, 0, 0, 0), "InOut", "Quart", 0.5, true, nil)
			task.wait(.5)
			TopBar:TweenSize(UDim2.new(0, 0, 0.02, 0), "InOut", "Quart", 0.5, true, nil)
			task.wait(.5)
			script.Parent:Destroy()
		end)

		TopBar:TweenSize(UDim2.new(0.352, 0, 0.025, 0), "InOut", "Quart", 0.5, true, nil)
		task.wait(0.5)
		UserName.Visible = true
		MainFrame:TweenSize(UDim2.new(1, 0, 15.753, 0), "InOut", "Quart", 0.5, true, nil)
		task.wait(0.5)
		AnnouncementText.Visible = true

		task.wait(6.5)

		UserName.Visible = false
		AnnouncementText.Visible = false
		MainFrame:TweenSize(UDim2.new(1, 0, 0, 0), "InOut", "Quart", 0.5, true, nil)
		task.wait(.5)
		TopBar:TweenSize(UDim2.new(0, 0, 0.02, 0), "InOut", "Quart", 0.5, true, nil)
		task.wait(.5)
		script.Parent:Destroy()

	end;
	task.spawn(C_7);

	return G2L["1"], require;
end


-------------------------------

--// Commands
addcmd({
	Name = "kick",
	Aliases = {"k"},
	Function = function(sender, targets, arguments)
		for i, plr in ipairs(targets) do
			if plr ~= sender then -- Prevent kicking yourself
				plr:Kick(arguments and "You have been kicked for: " .. table.concat(arguments, " ") or "You have been kicked.")
			else
				notif(sender, "Error", "You cannot kick yourself.", Internals.Icons.Error)
			end
		end
	end
})

addcmd({
	Name = "shutdown",
	Aliases = {"shutd"},
	Function = function(sender, targets, arguments)
		for i, plr in ipairs(game.Players:GetChildren()) do
			plr:Kick(arguments and "Server has been Shutdown: " .. table.concat(arguments, " ") or "Server has been Shutdown.")
		end
	end
})

game.Players.PlayerAdded:Connect(function(plr)
	if table.find(Internals.Banned, plr.UserId) then
		plr:Kick("You are permanently banned.")
	end
end)

addcmd({
	Name = "ban",
	Aliases = {"b"},
	Function = function(sender, targets, arguments)
		for i, plr in ipairs(targets) do
			if plr ~= sender then
				if not table.find(Internals.Banned, plr.UserId) then
					table.insert(Internals.Banned, plr.UserId)
				end
				plr:Kick(arguments and "You have been banned for: " .. table.concat(arguments, " ") or "You have been banned.")
			else
				announce(sender, sender, "You cannot ban yourself.")
			end
		end
	end
})

addcmd({
	Name = "unban",
	Aliases = {"ub"},
	Function = function(sender, targets, arguments)
		for _, plr in ipairs(targets) do
			local banIndex = table.find(Internals.Banned, plr.UserId)
			if banIndex then
				table.remove(Internals.Banned, banIndex)
				announce(sender, sender, plr.Name .. " has been unbanned.")
			else
				announce(sender, sender, plr.Name .. " is not banned.")
			end
		end
	end
})

addcmd({
	Name = "delete",
	Aliases = {"d"},
	Function = function(sender, targets, arguments)
		for _, plr in ipairs(targets) do
			plr:Destroy()
		end
	end
})

addcmd({
	Name = "punish",
	Aliases = {},
	Function = function(sender, targets, arguments)
		for _, plr in ipairs(targets) do
			plr.Character:Destroy()
		end
	end
})

addcmd({
	Name = "explode",
	Aliases = {},
	Function = function(sender, targets, arguments)
		for _, plr in ipairs(targets) do
			local explosion = Instance.new("Explosion", workspace)
			explosion.Position = plr.Character.PrimaryPart.Position
		end
	end
})

addcmd({
	Name = "locate", -- Stolen from CXO Admin
	Aliases = {},
	Function = function(sender, targets, arguments)
		for i, plr in ipairs(targets) do
			local success, code = pcall(game:GetService("LocalizationService").GetCountryRegionForPlayerAsync, game:GetService("LocalizationService"), plr)
			if success and code then
				notif(sender, "Success", plr.Name .." is from: ".. Internals.Countries[code])
			end
		end
	end
})

-------------------------------------- ALL STOLEN :) FROM CXO

addcmd({
	Name = "removeobby",
	Aliases = {"hideobby"},
	Player = false,
	Function = function(sender, targets, arguments)
		for i, v in pairs(game:GetService("Workspace"):FindFirstChild("Tabby"):FindFirstChild("Admin_House"):GetChildren()) do
			if v.Name == "Snow" or v.Name == "Jumps" then
				v.Parent = game:GetService("ReplicatedStorage"):FindFirstChild("cxo's folder")
			end
		end
	end
})

addcmd({
	Name = "obby",
	Aliases = {"unhideobby"},
	Player = false,
	Function = function(sender, targets, arguments)
		for i, v in pairs(game:GetService("ReplicatedStorage"):FindFirstChild("cxo's folder"):GetChildren()) do
			if v.Name == "Snow" or v.Name == "Jumps" then
				v.Parent = game:GetService("Workspace"):FindFirstChild("Tabby"):FindFirstChild("Admin_House")
			end
		end
	end
})

addcmd({
	Name = "nok",
	Aliases = {},
	Player = false,
	Function = function(sender, targets, arguments)
		game:GetService("ServerScriptService"):FindFirstChild("Killer").Enabled = false
	end
})

addcmd({
	Name = "ok",
	Aliases = {"obbykill"},
	Player = false,
	Function = function(sender, targets, arguments)
		game:GetService("ServerScriptService"):FindFirstChild("Killer").Enabled = true
	end
})

--------------------------------------------------------------------------------------------------


-- Stole the idea but not the code

addcmd({
	Name = "fps",
	Aliases = {"setfps"},
	Function = function(sender, targets, arguments)
		local value = table.concat(arguments, " ", 1)
		for i, plr in ipairs(targets) do
			if not table.find(Internals.FpsLooped, plr.Name) then
				local looped = coroutine.create(function()
					repeat
						local osclock = os.clock()
						while osclock + 1 / value > os.clock() do end
						task.wait()
						osclock = os.clock()
					until not table.find(Internals.FpsLooped, plr.Name) or not game.Players:FindFirstChild(plr.Name)
				end)
				coroutine.resume(looped)
			end
		end
	end
})

addcmd({
	Name = "restorefps",
	Aliases = {"fixfps", "ffps"},
	Function = function(sender, targets, arguments)
		for i, plr in ipairs(targets) do
			if table.find(Internals.FpsLooped, plr.Name) then
				table.remove(Internals.FpsLooped, table.find(Internals.FpsLooped, plr.Name))
			end
		end
	end
})

addcmd({
	Name = "bring",
	Aliases = {"tome"},
	Function = function(sender, targets, arguments)
		for i, plr in ipairs(targets) do
			if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and sender.Character and sender.Character:FindFirstChild("HumanoidRootPart") then
				plr.Character.HumanoidRootPart.CFrame = sender.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -4.5)
			end
		end
	end
})

addcmd({
	Name = "goto",
	Aliases = {"to"},
	Function = function(sender, targets, arguments)
		for i, plr in ipairs(targets) do
			if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and sender.Character and sender.Character:FindFirstChild("HumanoidRootPart") then
				sender.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 4.5)
			end
		end
	end
})

addcmd({ -- Stolen from CXO
	Name = "whitelist",
	Aliases = {"wl"},
	Function = function(sender, targets, arguments)
		for i, plr in ipairs(targets) do
			if not table.find(Settings.Whitelist, plr.Name) then
				table.insert(Settings.Whitelist, plr.Name)
				notif(plr, "Admin", "You have been granted admin privileges.", Internals.Icons.Info)
			end
		end
	end
})

addcmd({ -- Stolen from CXO
	Name = "unwhitelist",
	Aliases = {"unwl"},
	Function = function(sender, targets, arguments)
		for i, plr in ipairs(targets) do
			if table.find(Settings.Whitelist, plr.Name) then
				table.remove(Settings.Whitelist, table.find(Settings.Whitelist, plr.Name))
				notif(plr, "Admin", "Your admin privileges have been revoked.", Internals.Icons.Warn)
			end
		end
	end
})

addcmd({
	Name = "serverlock",
	Aliases = {"slock"},
	Function = function(sender, _, arguments)
		local args = table.concat(arguments, " ")
		Internals.Serverlock = not Internals.Serverlock

		notif(sender, "DIZZY's Admin", "Server locked = "..tostring(Internals.Serverlock), Internals.Icons.Warn)

		if args == "public" or args == "pub" or args == "p" then
			for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
				coroutine.wrap(function()
					announce(sender, player, "Server Locked = "..tostring(Internals.Serverlock))
				end)()
			end
		end
	end
})

addcmd({
	Name = "mute",
	Aliases = {"mu"},
	Function = function(sender, targets, arguments)
		for i, plr in ipairs(targets) do
			if table.find(Settings.Whitelist, tostring(plr.Name)) then
				announce(sender, sender, "You can not mute the head admins of this script!")
			else
				if not table.find(Internals.Muted, tostring(plr.Name)) then
					table.insert(Internals.Muted, tostring(plr.Name))
				end

				local scr = game:GetService("ServerScriptService").goog.Utilities.Client:Clone()
				local utilities = game:GetService("ServerScriptService").goog.Utilities
				local loa = utilities:FindFirstChild("loadstring")

				if loa then
					loa = loa:Clone()
				else
					loa = utilities:FindFirstChild("Loadstring")
					if loa then
						loa = loa:Clone()
					end
				end
--// Settings
local Settings = {
	Prefix = "-";

	Whitelist = {
		"Di33le3", -- Add usernames here
		"neve11591",
		"SirKhalidBlox",
		"ripcxo",
		"RUBYMEEEEMEEE",
		"t_echr"
	};

	DeadMansSwitch = false; -- If u get kicked or banned the server gets killed.
}

--// Internals
local Internals = {
	-- Commands / Toggles
	autore = {};
	Banned = {"D_ionte"};
	Chats = {};
	Commands = {};
	Countries = {};
	FpsLooped = {};
	Muted = {};
	Serverlock = false;
	Trolling = {
		CamTroll = {}
	};
	Warned = {};

	-- Ui Elements
	Icons = {
		["Error"] = "rbxassetid://94362538974098",
		["Info"] = "rbxassetid://103455396505678",
		["Success"] = "rbxassetid://72024654106640",
		["Warn"] = "rbxassetid://108125574645285"
	};

	-- Scripts
	Scripts = {
		Exser = {ID = "10868847330", Module = ":pls"},
		KasperUTG = {ID = "7993536803", Module = ".KasperUTGeditedByDog"}
	};
	
	Secrets = {
		AssetPassword = "DIZZYAccess112"
	}
}

--[[
	Many commands were taken from https://raw.githubusercontent.com/pcxo/cxos-admin/refs/heads/main/admin 
]]--


local Players = game.Players
local UserInputService = game:GetService("UserInputService")


local DIZZYFOLDER = Instance.new("Folder", game.ReplicatedStorage)
DIZZYFOLDER.Name = "DIZZYs Folder"

local BuildFolder = Instance.new("Folder", DIZZYFOLDER)
BuildFolder.Name = "DIZZYs Stored Builds Folder"


-- Preload ASSETS

require(123764473198037).DizzySSBuildLoad() -- Roblox Ball Gyro
require(74730262689062).DizzySSBuildLoad() -- Mclaren Sienna
require(91324836980339).DizzySSBuildLoad() -- Rimac Nevera
require(72122600693653).DizzySSBuildLoad() -- Bugatti Bolide
require(110485306545671).DizzySSBuildLoad() -- Koenigsegg Agera

require(128010285971411).DizzySSBuildLoad() -- Treehouse



--// Get Whitelist
function GetWhitelist()
	return Settings.Whitelist
end

--// Player Finder
function p(a, me)
	local ps = game.Players:GetPlayers()
	local found = {}

	if a:lower() == "me" then
		found = {me}
	elseif a:lower() == "others" then
		for i, player in ipairs(ps) do
			if player ~= me then
				table.insert(found, player)
			end
		end
	elseif a:lower() == "all" then
		found = ps
	elseif a:lower() == "random" then
		if #ps > 0 then
			found = {ps[math.random(1, #ps)]}
		end
	else
		for i, player in ipairs(ps) do
			if player.Name:lower():sub(1, #a) == a:lower() or player.DisplayName:lower():sub(1, #a) == a:lower() then
				table.insert(found, player)
			end
		end
	end

	return found
end

--// Add Command
local function addcmd(data)
	if Internals.Commands[data.Name] then return end
	if not data.Aliases then data.Aliases = {} end
	Internals.Commands[data.Name] = { Data = data }
end

--// Notification Function
function notif(plr, title, message, icon)
	coroutine.wrap(function()
		if not plr or not plr:FindFirstChild("PlayerGui") then
			return
		end
		require(105306341303469).DizzySSAsset_2(plr, title, message, icon, Internals.Secrets.AssetPassword)
	end)()
end

local function announce(sender, player, message)
	local G2L = {}

	G2L["1"] = Instance.new("ScreenGui")
	G2L["1"].Name = "Announcement"
	G2L["1"].ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	G2L["1"].ResetOnSpawn = true
	G2L["1"].Parent = player:WaitForChild("PlayerGui")

	G2L["2"] = Instance.new("Frame", G2L["1"])
	G2L["2"].BorderSizePixel = 0
	G2L["2"].BackgroundColor3 = Color3.fromRGB(26, 26, 26)
	G2L["2"].AnchorPoint = Vector2.new(0.5, 0.5)
	G2L["2"].Size = UDim2.new(0, 0, 0.025, 0)
	G2L["2"].Position = UDim2.new(0.5, 0, 0.29772, 0)
	G2L["2"].BorderColor3 = Color3.fromRGB(0, 0, 0)
	G2L["2"].Name = "TopBar"

	G2L["3"] = Instance.new("Frame", G2L["2"])
	G2L["3"].BorderSizePixel = 0
	G2L["3"].BackgroundColor3 = Color3.fromRGB(41, 41, 41)
	G2L["3"].Size = UDim2.new(1, 0, 0, 0)
	G2L["3"].Position = UDim2.new(0, 0, 1, 0)
	G2L["3"].BorderColor3 = Color3.fromRGB(0, 0, 0)
	G2L["3"].Name = "MFrame"
	G2L["3"].BackgroundTransparency = 0.1

	G2L["4"] = Instance.new("TextLabel", G2L["3"])
	G2L["4"].TextWrapped = true
	G2L["4"].BorderSizePixel = 0
	G2L["4"].TextXAlignment = Enum.TextXAlignment.Center
	G2L["4"].TextYAlignment = Enum.TextYAlignment.Center
	G2L["4"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	G2L["4"].TextSize = 14
	G2L["4"].Font = Enum.Font.Arial
	G2L["4"].TextColor3 = Color3.fromRGB(255, 255, 255)
	G2L["4"].BackgroundTransparency = 1
	G2L["4"].Size = UDim2.new(0, 313, 0, 158)
	G2L["4"].Text = message
	G2L["4"].Visible = false
	G2L["4"].BorderColor3 = Color3.fromRGB(0, 0, 0)
	G2L["4"].Position = UDim2.new(0.5, 0, 0.5, 0)
	G2L["4"].AnchorPoint = Vector2.new(0.5, 0.5)

	if #message > 40 then
		G2L["4"].TextSize = 12
	elseif #message > 35 then
		G2L["4"].TextSize = 14
	elseif #message > 30 then
		G2L["4"].TextSize = 16
	elseif #message > 20 then
		G2L["4"].TextSize = 17
	elseif #message > 12 then
		G2L["4"].TextSize = 20
	else
		G2L["4"].TextSize = 22
	end

	G2L["5"] = Instance.new("TextButton", G2L["2"])
	G2L["5"].BorderSizePixel = 0
	G2L["5"].TextSize = 14
	G2L["5"].TextColor3 = Color3.fromRGB(68, 0, 0)
	G2L["5"].BackgroundColor3 = Color3.fromRGB(68, 0, 0)
	G2L["5"].Font = Enum.Font.SourceSans
	G2L["5"].AnchorPoint = Vector2.new(0.5, 0.5)
	G2L["5"].Size = UDim2.new(0.03, 0, 0.9, 0)
	G2L["5"].Name = "Close"
	G2L["5"].BorderColor3 = Color3.fromRGB(0, 0, 0)
	G2L["5"].Text = ""
	G2L["5"].Position = UDim2.new(0.982, 0, 0.5, 0)

	G2L["6"] = Instance.new("TextButton", G2L["2"])
	G2L["6"].TextWrapped = true
	G2L["6"].BorderSizePixel = 0
	G2L["6"].TextSize = 14
	G2L["6"].TextColor3 = Color3.fromRGB(255, 255, 255)
	G2L["6"].TextScaled = true
	G2L["6"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	G2L["6"].Font = Enum.Font.SourceSansBold
	G2L["6"].RichText = true
	G2L["6"].AnchorPoint = Vector2.new(0.5, 0.5)
	G2L["6"].Size = UDim2.new(0.47236, 0, 0.8745, 0)
	G2L["6"].BackgroundTransparency = 1
	G2L["6"].Name = "Uame"
	G2L["6"].BorderColor3 = Color3.fromRGB(0, 0, 0)
	G2L["6"].Text = "Message From: " .. sender.Name
	G2L["6"].Visible = false
	G2L["6"].Position = UDim2.new(0.5, 0, 0.5, 0)

	G2L["7"] = Instance.new("LocalScript", G2L["1"])
	G2L["7"].Name = "Handler"

	local function C_7()
		local script = G2L["7"]
		local TopBar = script.Parent.TopBar
		local MainFrame = TopBar.MFrame
		local AnnouncementText = MainFrame.TextLabel
		local Close = TopBar.Close
		local UserName = TopBar.Uame

		Close.MouseButton1Click:Connect(function()	
			Close.Visible = false
			TopBar.Uame.Visible = false
			AnnouncementText.Visible = false
			MainFrame:TweenSize(UDim2.new(1, 0, 0, 0), "InOut", "Quart", 0.5, true, nil)
			task.wait(.5)
			TopBar:TweenSize(UDim2.new(0, 0, 0.02, 0), "InOut", "Quart", 0.5, true, nil)
			task.wait(.5)
			script.Parent:Destroy()
		end)

		TopBar:TweenSize(UDim2.new(0.352, 0, 0.025, 0), "InOut", "Quart", 0.5, true, nil)
		task.wait(0.5)
		UserName.Visible = true
		MainFrame:TweenSize(UDim2.new(1, 0, 15.753, 0), "InOut", "Quart", 0.5, true, nil)
		task.wait(0.5)
		AnnouncementText.Visible = true

		task.wait(6.5)

		UserName.Visible = false
		AnnouncementText.Visible = false
		MainFrame:TweenSize(UDim2.new(1, 0, 0, 0), "InOut", "Quart", 0.5, true, nil)
		task.wait(.5)
		TopBar:TweenSize(UDim2.new(0, 0, 0.02, 0), "InOut", "Quart", 0.5, true, nil)
		task.wait(.5)
		script.Parent:Destroy()

	end;
	task.spawn(C_7);

	return G2L["1"], require;
end


-------------------------------

--// Commands
addcmd({
	Name = "kick",
	Aliases = {"k"},
	Function = function(sender, targets, arguments)
		for i, plr in ipairs(targets) do
			if plr ~= sender then -- Prevent kicking yourself
				plr:Kick(arguments and "You have been kicked for: " .. table.concat(arguments, " ") or "You have been kicked.")
			else
				notif(sender, "Error", "You cannot kick yourself.", Internals.Icons.Error)
			end
		end
	end
})

addcmd({
	Name = "shutdown",
	Aliases = {"shutd"},
	Function = function(sender, targets, arguments)
		for i, plr in ipairs(game.Players:GetChildren()) do
			plr:Kick(arguments and "Server has been Shutdown: " .. table.concat(arguments, " ") or "Server has been Shutdown.")
		end
	end
})

game.Players.PlayerAdded:Connect(function(plr)
	if table.find(Internals.Banned, plr.UserId) then
		plr:Kick("You are permanently banned.")
	end
end)

addcmd({
	Name = "ban",
	Aliases = {"b"},
	Function = function(sender, targets, arguments)
		for i, plr in ipairs(targets) do
			if plr ~= sender then
				if not table.find(Internals.Banned, plr.UserId) then
					table.insert(Internals.Banned, plr.UserId)
				end
				plr:Kick(arguments and "You have been banned for: " .. table.concat(arguments, " ") or "You have been banned.")
			else
				announce(sender, sender, "You cannot ban yourself.")
			end
		end
	end
})

addcmd({
	Name = "unban",
	Aliases = {"ub"},
	Function = function(sender, targets, arguments)
		for _, plr in ipairs(targets) do
			local banIndex = table.find(Internals.Banned, plr.UserId)
			if banIndex then
				table.remove(Internals.Banned, banIndex)
				announce(sender, sender, plr.Name .. " has been unbanned.")
			else
				announce(sender, sender, plr.Name .. " is not banned.")
			end
		end
	end
})

addcmd({
	Name = "delete",
	Aliases = {"d"},
	Function = function(sender, targets, arguments)
		for _, plr in ipairs(targets) do
			plr:Destroy()
		end
	end
})

addcmd({
	Name = "punish",
	Aliases = {},
	Function = function(sender, targets, arguments)
		for _, plr in ipairs(targets) do
			plr.Character:Destroy()
		end
	end
})

addcmd({
	Name = "explode",
	Aliases = {},
	Function = function(sender, targets, arguments)
		for _, plr in ipairs(targets) do
			local explosion = Instance.new("Explosion", workspace)
			explosion.Position = plr.Character.PrimaryPart.Position
		end
	end
})

addcmd({
	Name = "locate", -- Stolen from CXO Admin
	Aliases = {},
	Function = function(sender, targets, arguments)
		for i, plr in ipairs(targets) do
			local success, code = pcall(game:GetService("LocalizationService").GetCountryRegionForPlayerAsync, game:GetService("LocalizationService"), plr)
			if success and code then
				notif(sender, "Success", plr.Name .." is from: ".. Internals.Countries[code])
			end
		end
	end
})

-------------------------------------- ALL STOLEN :) FROM CXO

addcmd({
	Name = "removeobby",
	Aliases = {"hideobby"},
	Player = false,
	Function = function(sender, targets, arguments)
		for i, v in pairs(game:GetService("Workspace"):FindFirstChild("Tabby"):FindFirstChild("Admin_House"):GetChildren()) do
			if v.Name == "Snow" or v.Name == "Jumps" then
				v.Parent = game:GetService("ReplicatedStorage"):FindFirstChild("cxo's folder")
			end
		end
	end
})

addcmd({
	Name = "obby",
	Aliases = {"unhideobby"},
	Player = false,
	Function = function(sender, targets, arguments)
		for i, v in pairs(game:GetService("ReplicatedStorage"):FindFirstChild("cxo's folder"):GetChildren()) do
			if v.Name == "Snow" or v.Name == "Jumps" then
				v.Parent = game:GetService("Workspace"):FindFirstChild("Tabby"):FindFirstChild("Admin_House")
			end
		end
	end
})

addcmd({
	Name = "nok",
	Aliases = {},
	Player = false,
	Function = function(sender, targets, arguments)
		game:GetService("ServerScriptService"):FindFirstChild("Killer").Enabled = false
	end
})

addcmd({
	Name = "ok",
	Aliases = {"obbykill"},
	Player = false,
	Function = function(sender, targets, arguments)
		game:GetService("ServerScriptService"):FindFirstChild("Killer").Enabled = true
	end
})

--------------------------------------------------------------------------------------------------


-- Stole the idea but not the code

addcmd({
	Name = "fps",
	Aliases = {"setfps"},
	Function = function(sender, targets, arguments)
		local value = table.concat(arguments, " ", 1)
		for i, plr in ipairs(targets) do
			if not table.find(Internals.FpsLooped, plr.Name) then
				local looped = coroutine.create(function()
					repeat
						local osclock = os.clock()
						while osclock + 1 / value > os.clock() do end
						task.wait()
						osclock = os.clock()
					until not table.find(Internals.FpsLooped, plr.Name) or not game.Players:FindFirstChild(plr.Name)
				end)
				coroutine.resume(looped)
			end
		end
	end
})

addcmd({
	Name = "restorefps",
	Aliases = {"fixfps", "ffps"},
	Function = function(sender, targets, arguments)
		for i, plr in ipairs(targets) do
			if table.find(Internals.FpsLooped, plr.Name) then
				table.remove(Internals.FpsLooped, table.find(Internals.FpsLooped, plr.Name))
			end
		end
	end
})

addcmd({
	Name = "bring",
	Aliases = {"tome"},
	Function = function(sender, targets, arguments)
		for i, plr in ipairs(targets) do
			if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and sender.Character and sender.Character:FindFirstChild("HumanoidRootPart") then
				plr.Character.HumanoidRootPart.CFrame = sender.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -4.5)
			end
		end
	end
})

addcmd({
	Name = "goto",
	Aliases = {"to"},
	Function = function(sender, targets, arguments)
		for i, plr in ipairs(targets) do
			if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and sender.Character and sender.Character:FindFirstChild("HumanoidRootPart") then
				sender.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 4.5)
			end
		end
	end
})

addcmd({ -- Stolen from CXO
	Name = "whitelist",
	Aliases = {"wl"},
	Function = function(sender, targets, arguments)
		for i, plr in ipairs(targets) do
			if not table.find(Settings.Whitelist, plr.Name) then
				table.insert(Settings.Whitelist, plr.Name)
				notif(plr, "Admin", "You have been granted admin privileges.", Internals.Icons.Info)
			end
		end
	end
})

addcmd({ -- Stolen from CXO
	Name = "unwhitelist",
	Aliases = {"unwl"},
	Function = function(sender, targets, arguments)
		for i, plr in ipairs(targets) do
			if table.find(Settings.Whitelist, plr.Name) then
				table.remove(Settings.Whitelist, table.find(Settings.Whitelist, plr.Name))
				notif(plr, "Admin", "Your admin privileges have been revoked.", Internals.Icons.Warn)
			end
		end
	end
})

addcmd({
	Name = "serverlock",
	Aliases = {"slock"},
	Function = function(sender, _, arguments)
		local args = table.concat(arguments, " ")
		Internals.Serverlock = not Internals.Serverlock

		notif(sender, "DIZZY's Admin", "Server locked = "..tostring(Internals.Serverlock), Internals.Icons.Warn)

		if args == "public" or args == "pub" or args == "p" then
			for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
				coroutine.wrap(function()
					announce(sender, player, "Server Locked = "..tostring(Internals.Serverlock))
				end)()
			end
		end
	end
})

addcmd({
	Name = "mute",
	Aliases = {"mu"},
	Function = function(sender, targets, arguments)
		for i, plr in ipairs(targets) do
			if table.find(Settings.Whitelist, tostring(plr.Name)) then
				announce(sender, sender, "You can not mute the head admins of this script!")
			else
				if not table.find(Internals.Muted, tostring(plr.Name)) then
					table.insert(Internals.Muted, tostring(plr.Name))
				end

				local scr = game:GetService("ServerScriptService").goog.Utilities.Client:Clone()
				local utilities = game:GetService("ServerScriptService").goog.Utilities
				local loa = utilities:FindFirstChild("loadstring")

				if loa then
					loa = loa:Clone()
				else
					loa = utilities:FindFirstChild("Loadstring")
					if loa then
						loa = loa:Clone()
					end
				end

				if not loa then
					warn("Could not find 'loadstring' or 'Loadstring' in goog.Utilities")
				end

				loa.Parent = scr
				scr:WaitForChild("Exec").Value = [[
                    game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
                ]]
				if plr.Character then
					scr.Parent = plr.Character
				else
					scr.Parent = plr:WaitForChild("PlayerGui")
				end
				scr.Enabled = true
			end
		end
	end
})

addcmd({
	Name = "unmute",
	Aliases = {"unm"},
	Function = function(sender, targets, arguments)
		for i, plr in ipairs(targets) do
			local index = table.find(Internals.Muted, tostring(plr.Name))
			if index then
				table.remove(Internals.Muted, index)
			end

			local scr = game:GetService("ServerScriptService").goog.Utilities.Client:Clone()
			local utilities = game:GetService("ServerScriptService").goog.Utilities
			local loa = utilities:FindFirstChild("loadstring")

			if loa then
				loa = loa:Clone()
			else
				loa = utilities:FindFirstChild("Loadstring")
				if loa then
					loa = loa:Clone()
				end
			end

			if not loa then
				warn("Could not find 'loadstring' or 'Loadstring' in goog.Utilities")
			end

			loa.Parent = scr
			scr:WaitForChild("Exec").Value = [[
                game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
            ]]
			if plr.Character then
				scr.Parent = plr.Character
			else
				scr.Parent = plr:WaitForChild("PlayerGui")
			end
			scr.Enabled = true
		end
	end
})

addcmd({
	Name = "camtroll",
	Aliases = {"cameratroll"},
	Function = function(sender, targets, arguments)
		for _, plr in ipairs(targets) do
			Internals.Trolling.CamTroll[plr.Name] = true

			coroutine.wrap(function()
				while Internals.Trolling.CamTroll[plr.Name] do
					plr.CameraMode = Enum.CameraMode.LockFirstPerson
					plr.CameraMinZoomDistance = 0.5

					task.wait(0.05)
					plr.CameraMode = Enum.CameraMode.Classic
					plr.CameraMinZoomDistance = 400

					task.wait(0.05)
				end
			end)()
		end
	end
})

addcmd({
	Name = "uncamtroll",
	Aliases = {},
	Function = function(sender, targets, arguments)
		for _, plr in ipairs(targets) do
			Internals.Trolling.CamTroll[plr.Name] = false
			task.wait(1)
			plr.CameraMode = Enum.CameraMode.Classic
			plr.CameraMinZoomDistance = 0.5
		end
	end
})

addcmd({
	Name = "warn",
	Aliases = {},
	Function = function(sender, targets, arguments)
		local reason = table.concat(arguments, " ")
		if reason == "" then
			reason = "No reason provided"
		end

		if not Internals.Warned then
			Internals.Warned = {}
		end

		for _, plr in ipairs(targets) do
			if typeof(plr) ~= "Instance" or not plr:IsA("Player") then
				if not Internals.Warned[plr.UserId] then
					Internals.Warned[plr.UserId] = 0
				end

				Internals.Warned[plr.UserId] = Internals.Warned[plr.UserId] + 1

				task.spawn(function()
					announce(sender, plr, "You have been warned for: " .. reason .. 
						" (Warning " .. Internals.Warned[plr.UserId] .. "/3)")
				end)

				if Internals.Warned[plr.UserId] >= 3 then
					task.spawn(function()
						plr:Kick("You have been kicked for receiving 3 warnings.")
					end)
					Internals.Warned[plr.UserId] = nil
				end

			end
		end
	end
})

addcmd({
	Name = "admin",
	Aliases = {"perm"},
	Function = function(sender, targets, arguments)
		for i, plr in ipairs(targets) do
			if not table.find(_G.permadmins, plr.Name) then
				table.insert(_G.permadmins, plr.Name)
			end
		end
	end
})

addcmd({
	Name = "unadmin",
	Aliases = {"noperm"},
	Function = function(sender, targets, arguments)
		for i, plr in ipairs(targets) do
			if table.find(_G.permadmins, plr.Name) then
				table.remove(_G.permadmins, table.find(_G.permadmins, plr.Name))
			end
		end
	end
})



addcmd({
	Name = "antikill",
	Aliases = {"autore"},
	Function = function(sender, targets, arguments)
		for i, plr in ipairs(targets) do
			if not table.find(Internals.autore, plr.Name) then
				table.insert(Internals.autore, plr.Name)
			end

			plr.Character.Humanoid.Died:Connect(function()
				plr:LoadCharacter()
			end)

		end
	end
})

addcmd({
	Name = "deadswitch",
	Aliases = {"deadmans"},
	Function = function(sender, targets, arguments)
		Settings.DeadMansSwitch = true
		for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
			coroutine.wrap(function()
				announce(sender, player, "Dead Man's Switch Activated! If " .. sender.Name .. " is kicked, banned or has left, the server will crash.")
			end)()
		end

		while Settings.DeadMansSwitch do
			local playerFound = false
			for _, player in ipairs(game.Players:GetPlayers()) do
				if player.Name == sender.Name then
					playerFound = true
					break
				end
			end

			if not playerFound then
				for _, player in ipairs(game.Players:GetPlayers()) do
					player:Kick("Dead Man's Switch Activated: " .. sender.Name .. " has been kicked or banned.")
				end
				Settings.DeadMansSwitch = false
				break
			end
			task.wait(0.2)
		end
	end
})

addcmd({
	Name = "undeadswitch",
	Aliases = {"undeadmans"},
	Function = function(sender, targets, arguments)
		Settings.DeadMansSwitch = false
		for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
			coroutine.wrap(function()
				announce(sender, player, "Dead Man's Switch Deactivated by " .. sender.Name)
			end)()
		end
	end
})



addcmd({
	Name = "unload",
	Aliases = {},
	Function = function(sender, targets, arguments)
		script:Destroy()
	end
})

addcmd({
	Name = "hang", -- cxo
	Aliases = {},
	Function = function(sender, targets, arguments)
		for i, plr in ipairs(targets) do
			if plr.Character and plr.Character:FindFirstChild("Head") and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character:FindFirstChild("Torso") then

				local floor = Instance.new("Part", workspace)
				floor.Name = "cxo was here"
				floor.CFrame = plr.Character.HumanoidRootPart.CFrame * CFrame.new(0, -2.5 , 0)
				floor.Material = Enum.Material.Wood
				floor.BrickColor = BrickColor.new("Rust")
				floor.Size = Vector3.new(16, 1, 16)
				floor.Anchored = true

				local pole = Instance.new("Part", workspace)
				pole.Name = "cxo was here"
				pole.CFrame = floor.CFrame * CFrame.new(0, 6.5, 7)
				pole.Material = Enum.Material.Wood
				pole.BrickColor = BrickColor.new("Rust")
				pole.Size = Vector3.new(2, 12, 2)
				pole.Anchored = true

				local pole2 = Instance.new("Part", workspace)
				pole2.Name = "cxo was here"
				pole2.CFrame = pole.CFrame * CFrame.new(0, 6.5, -2)
				pole2.Material = Enum.Material.Wood
				pole2.BrickColor = BrickColor.new("Rust")
				pole2.Size = Vector3.new(2, 1, 6)
				pole2.Anchored = true

				local metal = Instance.new("Part", workspace)
				metal.Name = "cxo was here"
				metal.CFrame = pole.CFrame * CFrame.new(0, 7.05, -4)
				metal.Material = Enum.Material.DiamondPlate
				metal.BrickColor = BrickColor.new("Black")
				metal.Size = Vector3.new(2, 0.1, 0.1)
				metal.Anchored = true

				local metal2 = Instance.new("Part", workspace)
				metal2.Name = "cxo was here"
				metal2.CFrame = metal.CFrame * CFrame.new(-1.05, -0.56, 0)
				metal2.Material = Enum.Material.DiamondPlate
				metal2.BrickColor = BrickColor.new("Black")
				metal2.Size = Vector3.new(0.1, 1.213, 0.1)
				metal2.Anchored = true

				local metal3 = Instance.new("Part", workspace)
				metal3.Name = "cxo was here"
				metal3.CFrame = metal.CFrame * CFrame.new(1.05, -0.56, 0)
				metal3.Material = Enum.Material.DiamondPlate
				metal3.BrickColor = BrickColor.new("Black")
				metal3.Size = Vector3.new(0.1, 1.213, 0.1)
				metal3.Anchored = true

				local metal4 = Instance.new("Part", workspace)
				metal4.Name = "cxo was here"
				metal4.CFrame = pole.CFrame * CFrame.new(0, 5.93, -4)
				metal4.Material = Enum.Material.DiamondPlate
				metal4.BrickColor = BrickColor.new("Black")
				metal4.Size = Vector3.new(2, 0.1, 0.1)
				metal4.Anchored = true

				local rope = Instance.new("Part", workspace)
				rope.Name = "cxo was here"
				rope.CFrame = metal4.CFrame * CFrame.new(0, -0.60, 0)
				rope.Material = Enum.Material.Leather
				rope.BrickColor = BrickColor.new("Burnt Sienna")
				rope.Size = Vector3.new(0.1, 1.113, 0.1)
				rope.Anchored = true

				local rope2 = Instance.new("Part", workspace)
				rope2.Name = "cxo was here"
				rope2.CFrame = rope.CFrame * CFrame.new(0, -0.6, 0)
				rope2.Material = Enum.Material.Leather
				rope2.BrickColor = BrickColor.new("Burnt Sienna")
				rope2.Size = Vector3.new(1.459, 0.1, 0.1)
				rope2.Anchored = true

				local rope3 = Instance.new("Part", workspace)
				rope3.Name = "cxo was here"
				rope3.CFrame = rope2.CFrame * CFrame.new(0.78, -0.5560, 0)
				rope3.Material = Enum.Material.Leather
				rope3.BrickColor = BrickColor.new("Burnt Sienna")
				rope3.Size = Vector3.new(0.1, 1.215, 0.1)
				rope3.Anchored = true

				local rope4 = Instance.new("Part", workspace)
				rope4.Name = "cxo was here"
				rope4.CFrame = rope2.CFrame * CFrame.new(-0.78, -0.5560, 0)
				rope4.Material = Enum.Material.Leather
				rope4.BrickColor = BrickColor.new("Burnt Sienna")
				rope4.Size = Vector3.new(0.1, 1.215, 0.1)
				rope4.Anchored = true

				local rope5 = Instance.new("Part", workspace)
				rope5.Name = "cxo was here"
				rope5.CFrame = rope.CFrame * CFrame.new(0, -1.715, 0)
				rope5.Material = Enum.Material.Leather
				rope5.BrickColor = BrickColor.new("Burnt Sienna")
				rope5.Size = Vector3.new(1.459, 0.1, 0.1)
				rope5.Anchored = true

				plr.Character.Head.CFrame = rope5.CFrame * CFrame.new(0, 1 , 0.5)
				plr.Character.HumanoidRootPart.Anchored = true
				plr.Character.Humanoid.Animator:Destroy()
				plr.Character.Torso.Neck.C0 = plr.Character.Torso.Neck.C0 * CFrame.Angles(math.rad(90), 0, 0)
			end
		end
	end
})

addcmd({
	Name = "behead",
	Aliases = {"guillotine"},
	Function = function(sender, targets, arguments)
		for _, plr in ipairs(targets) do
			local character = plr.Character
			local rootPart = character.HumanoidRootPart
			local head = character.Head
			local torso = character.Torso
			local humanoid = character:FindFirstChildOfClass("Humanoid")

			local base = Instance.new("Part", workspace)
			base.Name = "DIZZY behead moment"
			base.Size = Vector3.new(10, 1, 6)
			base.Position = rootPart.Position + Vector3.new(0, -3, 0)
			base.Material = Enum.Material.Wood
			base.BrickColor = BrickColor.new("Reddish brown")
			base.Anchored = true

			local leftPole = Instance.new("Part", workspace)
			leftPole.Name = "DIZZY behead moment"
			leftPole.Size = Vector3.new(1, 12, 1)
			leftPole.Position = base.Position + Vector3.new(-4, 6, 0)
			leftPole.Material = Enum.Material.Wood
			leftPole.BrickColor = BrickColor.new("Reddish brown")
			leftPole.Anchored = true

			local rightPole = Instance.new("Part", workspace)
			rightPole.Name = "DIZZY behead moment"
			rightPole.Size = Vector3.new(1, 12, 1)
			rightPole.Position = base.Position + Vector3.new(4, 6, 0)
			rightPole.Material = Enum.Material.Wood
			rightPole.BrickColor = BrickColor.new("Reddish brown")
			rightPole.Anchored = true

			local crossbar = Instance.new("Part", workspace)
			crossbar.Name = "DIZZY behead moment"
			crossbar.Size = Vector3.new(10, 1, 1)
			crossbar.Position = base.Position + Vector3.new(0, 12, 0)
			crossbar.Material = Enum.Material.Wood
			crossbar.BrickColor = BrickColor.new("Reddish brown")
			crossbar.Anchored = true

			local blade = Instance.new("Part", workspace)
			blade.Name = "DIZZY behead moment"
			blade.Size = Vector3.new(2, 2, 0.2)
			blade.Position = crossbar.Position + Vector3.new(0, -1, 0)
			blade.Material = Enum.Material.Metal
			blade.BrickColor = BrickColor.new("Dark stone grey")
			blade.Anchored = true

			local rope = Instance.new("Part", workspace)
			rope.Name = "DIZZY behead moment"
			rope.Size = Vector3.new(0.1, 2, 0.1)
			rope.Position = blade.Position + Vector3.new(0, 1, 0)
			rope.Material = Enum.Material.Rock
			rope.BrickColor = BrickColor.new("Burnt Sienna")
			rope.Anchored = true

			rootPart.CFrame = base.CFrame * CFrame.new(0, 1.5, 0) * CFrame.Angles(math.rad(90), 0, 0)
			rootPart.Anchored = true

			if humanoid:FindFirstChild("Animator") then
				humanoid.Animator:Destroy()
			end

			for i = 1, 10 do
				blade.Position = blade.Position + Vector3.new(0, -0.5, 0)
				rope.Size = Vector3.new(0.1, 2 + (i * 0.5), 0.1)
				rope.Position = rope.Position + Vector3.new(0, -0.3, 0)
				wait(0.1)
			end

			local neck = torso:FindFirstChild("Neck")
			if neck then
				neck:Destroy()
			end

			head.CFrame = blade.CFrame * CFrame.new(0, -1, 0)
			head.Anchored = true

			local newhead = head:Clone()
			newhead.CFrame = blade.CFrame * CFrame.new(0, -1, 0)
			newhead.Anchored = true
			newhead.Parent = workspace

			local blood = Instance.new("Part", workspace)
			blood.Name = "DIZZY behead moment"
			blood.Size = Vector3.new(2, 0.2, 2)
			blood.Position = head.Position + Vector3.new(0, -4.3, 0)
			blood.Material = Enum.Material.SmoothPlastic
			blood.BrickColor = BrickColor.new("Bright red")
			blood.Anchored = true
			blood.Transparency = 0.5

			wait(5)
			rootPart.Anchored = false
			head.Anchored = false

			plr.CharacterAdded:Connect(function(newCharacter)
				wait(1)
				local newHumanoidRootPart = newCharacter:FindFirstChild("HumanoidRootPart")
				if newHumanoidRootPart then
					newHumanoidRootPart.Anchored = false
				end
			end)
		end
	end
})

addcmd({
	Name = "crucify",
	Aliases = {"cross", "jesusify"},
	Function = function(sender, targets, arguments)
		for _, plr in ipairs(targets) do
			coroutine.wrap(function()
				if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
					local character = plr.Character
					local rootPart = character.HumanoidRootPart
					local humanoid = character:FindFirstChildOfClass("Humanoid")

					if humanoid:FindFirstChild("Animator") then
						humanoid.Animator:Destroy()
					end

					local cross = Instance.new("Model", workspace)

					local mainPost = Instance.new("Part")
					mainPost.Size = Vector3.new(2, 8, 1)
					mainPost.Material = Enum.Material.Wood
					mainPost.BrickColor = BrickColor.new("Reddish brown")
					mainPost.Anchored = true
					mainPost.Parent = cross

					local crossbar = Instance.new("Part")
					crossbar.Size = Vector3.new(6, 1, 1)
					crossbar.Position = Vector3.new(0,-3,0)
					crossbar.Material = Enum.Material.Wood
					crossbar.BrickColor = BrickColor.new("Reddish brown")
					crossbar.Anchored = true
					crossbar.Parent = cross

					local crossCFrame = rootPart.CFrame * CFrame.new(0, 4, 0)
					mainPost.CFrame = crossCFrame
					crossbar.CFrame = crossCFrame * CFrame.new(0, 2.5, 0)
					
					rootPart.CFrame = crossCFrame * CFrame.new(0, 2.5, -1)
					rootPart.Anchored = true

					local torso = character:FindFirstChild("Torso")
					local leftArm = character:FindFirstChild("Left Arm")
					local rightArm = character:FindFirstChild("Right Arm")

					local function Weld(part0, part1, cframe)
						local weld = Instance.new("Weld")
						weld.Part0 = part0
						weld.Part1 = part1
						weld.C0 = cframe
						weld.Parent = part0
						part1.Anchored = false
					end

					if leftArm then
						Weld(crossbar, leftArm, CFrame.new(-2, 0, -1) * CFrame.Angles(-2, 0, math.rad(-90)))
					end
					if rightArm then
						Weld(crossbar, rightArm, CFrame.new(2, 0, -1) * CFrame.Angles(2, 0, math.rad(90)))
					end
					if torso then
						Weld(mainPost, torso, CFrame.new(0, 1.5, -1))
					end

					local sound = Instance.new("Sound", rootPart)
					sound.SoundId = "rbxassetid://1846115874"
					sound.Volume = 2
					sound:Play()

					wait(6)

					local beam = Instance.new("Part", workspace)
					beam.Size = Vector3.new(2, 1, 2)
					beam.Position = rootPart.Position
					beam.Material = Enum.Material.Neon
					beam.BrickColor = BrickColor.new("Institutional white")
					beam.Transparency = 0.5
					beam.Anchored = true


					local GhostTorso = character:FindFirstChild("Torso"):Clone()

					if GhostTorso then
						GhostTorso.Parent = beam
						GhostTorso.Transparency = 0.5
						GhostTorso.Anchored =true
					end


					for i = 1, 30 do
						beam.Size = Vector3.new(6, i * 3, 6)
						beam.Position = rootPart.Position + Vector3.new(0, i * 2, 0)
						rootPart.Position = rootPart.Position + Vector3.new(0, 3, 0)
						GhostTorso.Position = beam.Position + Vector3.new(0, 2, 0) -- Ghost moves with it

						GhostTorso.Transparency = math.min(1, GhostTorso.Transparency + 0.02)

						wait(0.2)
					end
			
					humanoid.Health = 0
					wait(1)

					beam:Destroy()
					sound:Destroy()
					rootPart.Anchored = false
				end
			end)()
		end
	end
})



addcmd({
	Name = "kidnap",
	Aliases = {},
	Function = function(sender, targets, arguments)
		for i, plr in ipairs(targets) do

			if plr.Character and plr.Character:FindFirstChild("Torso") and plr.Character:FindFirstChild("Humanoid") then

				_G.Victim = plr.Name

				local success, result = pcall(function() -- clown van script
					return game:GetService("HttpService"):GetAsync("https://raw.githubusercontent.com/pcxo/cxos-admin/refs/heads/main/clownvan")
				end)

				if success then
					local content = result
					local loaded, fail = loadstring(content)
					if loaded then
						loaded()
					else
						notif(sender, "DIZZY's admin", "Failed to load the clown van", Internals.Icons.Error)
					end
				else
					notif(sender, "DIZZY's admin", "Failed to load the clown van", Internals.Icons.Error)
				end

			end

		end
	end
})


addcmd({
	Name = "supercar",
	Aliases = {"mclaren", "sienna"},
	Function = function(sender, targets, arguments)
		local rs = game:GetService("ReplicatedStorage")
		local dizzyFolder = rs:FindFirstChild("DIZZYs Folder")
		local storedBuilds = dizzyFolder and dizzyFolder:FindFirstChild("DIZZYs Stored Builds Folder")
		local supercar = storedBuilds and storedBuilds:FindFirstChild("McLarenSenna")

		if not supercar then
			local success, result = pcall(function()
				return require(74730262689062).DizzySSBuildLoad()
			end)

			if success then
				repeat task.wait() until rs:FindFirstChild("Supercar")
				rs.Supercar.Parent = dizzyFolder
				supercar = storedBuilds and storedBuilds:FindFirstChild("Supercar")
			else
				return notif(sender, "DIZZY's Admin", "Supercar failed to load: " .. result, Internals.Icons.Error)
			end
		end

		if supercar then
			local carClone = supercar:Clone()
			carClone.PrimaryPart = carClone:FindFirstChild("DriveSeat")
			carClone.Parent = workspace
			carClone:SetPrimaryPartCFrame(sender.Character.HumanoidRootPart.CFrame * CFrame.new(0, -0.5, -10))
		end
	end
})

addcmd({
	Name = "supercar2",
	Aliases = {"rimac", "nevera"},
	Function = function(sender, targets, arguments)
		local rs = game:GetService("ReplicatedStorage")
		local dizzyFolder = rs:FindFirstChild("DIZZYs Folder")
		local storedBuilds = dizzyFolder and dizzyFolder:FindFirstChild("DIZZYs Stored Builds Folder")
		local supercar = storedBuilds and storedBuilds:FindFirstChild("RmacNeveraConcept2")

		if not supercar then
			local success, result = pcall(function()
				return require(91324836980339).DizzySSBuildLoad()
			end)

			if success then
				repeat task.wait() until rs:FindFirstChild("Supercar")
				rs.Supercar.Parent = dizzyFolder
				supercar = storedBuilds and storedBuilds:FindFirstChild("Supercar")
			else
				return notif(sender, "DIZZY's Admin", "Supercar failed to load: " .. result, Internals.Icons.Error)
			end
		end

		if supercar then
			local carClone = supercar:Clone()
			carClone.PrimaryPart = carClone:FindFirstChild("DriveSeat")
			carClone.Parent = workspace
			carClone:SetPrimaryPartCFrame(sender.Character.HumanoidRootPart.CFrame * CFrame.new(0, -0.5, -10))
		end
	end
})

addcmd({
	Name = "supercar3",
	Aliases = {"bugatti", "bolide"},
	Function = function(sender, targets, arguments)
		local rs = game:GetService("ReplicatedStorage")
		local dizzyFolder = rs:FindFirstChild("DIZZYs Folder")
		local storedBuilds = dizzyFolder and dizzyFolder:FindFirstChild("DIZZYs Stored Builds Folder")
		local supercar = storedBuilds and storedBuilds:FindFirstChild("BugattiBolide")

		if not supercar then
			local success, result = pcall(function()
				return require(72122600693653).DizzySSBuildLoad()
			end)

			if success then
				repeat task.wait() until rs:FindFirstChild("Supercar")
				rs.Supercar.Parent = dizzyFolder
				supercar = storedBuilds and storedBuilds:FindFirstChild("Supercar")
			else
				return notif(sender, "DIZZY's Admin", "Supercar failed to load: " .. result, Internals.Icons.Error)
			end
		end

		if supercar then
			local carClone = supercar:Clone()
			carClone.PrimaryPart = carClone:FindFirstChild("DriveSeat")
			carClone.Parent = workspace
			carClone:SetPrimaryPartCFrame(sender.Character.HumanoidRootPart.CFrame * CFrame.new(0, -0.5, -10))
		end
	end
})


addcmd({
	Name = "supercar4",
	Aliases = {"koenigsegg", "agera"},
	Function = function(sender, targets, arguments)
		local rs = game:GetService("ReplicatedStorage")
		local dizzyFolder = rs:FindFirstChild("DIZZYs Folder")
		local storedBuilds = dizzyFolder and dizzyFolder:FindFirstChild("DIZZYs Stored Builds Folder")
		local supercar = storedBuilds and storedBuilds:FindFirstChild("KoenigseggAgera")

		if not supercar then
			local success, result = pcall(function()
				return require(110485306545671).DizzySSBuildLoad()
			end)

			if success then
				repeat task.wait() until rs:FindFirstChild("Supercar")
				rs.Supercar.Parent = dizzyFolder
				supercar = storedBuilds and storedBuilds:FindFirstChild("Supercar")
			else
				return notif(sender, "DIZZY's Admin", "Supercar failed to load: " .. result, Internals.Icons.Error)
			end
		end

		if supercar then
			local carClone = supercar:Clone()
			carClone.PrimaryPart = carClone:FindFirstChild("DriveSeat")
			carClone.Parent = workspace
			carClone:SetPrimaryPartCFrame(sender.Character.HumanoidRootPart.CFrame * CFrame.new(0, -0.5, -10))
		end
	end
})


addcmd({
	Name = "ball",
	Aliases = {"gyroball", "ballcar"},
	Function = function(sender, targets, arguments)
		local rs = game:GetService("ReplicatedStorage")
		local dizzyFolder = rs:FindFirstChild("DIZZYs Folder")
		local storedBuilds = dizzyFolder and dizzyFolder:FindFirstChild("DIZZYs Stored Builds Folder")
		local supercar = storedBuilds and storedBuilds:FindFirstChild("Ball")

		if not supercar then
			local success, result = pcall(function()
				return require(123764473198037).DizzySSBuildLoad() -- Roblox Ball Gyro
			end)

			if success then
				repeat task.wait() until rs:FindFirstChild("Supercar")
				rs.Supercar.Parent = dizzyFolder
				supercar = storedBuilds and storedBuilds:FindFirstChild("Supercar")
			else
				return notif(sender, "DIZZY's Admin", "Ball Gyro failed to load: " .. result, Internals.Icons.Error)
			end
		end

		if supercar then
			local carClone = supercar:Clone()
			carClone.PrimaryPart = carClone:FindFirstChild("DriverSeat")
			carClone.Parent = workspace
			carClone:SetPrimaryPartCFrame(sender.Character.HumanoidRootPart.CFrame * CFrame.new(0, -0.5, -10))
		end
	end
})


addcmd({
	Name = "treehouse",
	Aliases = {"buildload1"},
	Function = function(sender, targets, arguments)
		local rs = game:GetService("ReplicatedStorage")
		local dizzyFolder = rs:FindFirstChild("DIZZYs Folder")
		local storedBuilds = dizzyFolder and dizzyFolder:FindFirstChild("DIZZYs Stored Builds Folder")
		local build = storedBuilds and storedBuilds:FindFirstChild("Treehouse")

		if not build then
			local success, result = pcall(function()
				return require(128010285971411).DizzySSBuildLoad()
			end)

			if success then
				repeat task.wait() until rs:FindFirstChild("Supercar")
				rs.Supercar.Parent = dizzyFolder
				build = storedBuilds and storedBuilds:FindFirstChild("Supercar")
			else
				return notif(sender, "DIZZY's Admin", "Treehouse failed to load: " .. result, Internals.Icons.Error)
			end
		end

		if build then
			local BuildClone = build:Clone()
			BuildClone.Parent = workspace
			BuildClone.PrimaryPart = BuildClone:FindFirstChild("Trunk")
			BuildClone:SetPrimaryPartCFrame(sender.Character.HumanoidRootPart.CFrame * CFrame.new(-30, 45, -30))
		end
	end
})

addcmd({
	Name = "restoremap",
	Aliases = {"rmap"},
	Player = false,
	Function = function(sender, targets, arguments)

		if game:GetService("ReplicatedStorage"):FindFirstChild("DIZZYs Folder"):FindFirstChild("Tabby") then
			game:GetService("ReplicatedStorage"):FindFirstChild("DIZZYs Folder"):FindFirstChild("Tabby"):Clone().Parent = workspace
			return
		end

		require(75594506017938).load()
		repeat task.wait() until game:GetService("ReplicatedStorage"):FindFirstChild("Tabby")
		game:GetService("ReplicatedStorage"):FindFirstChild("Tabby"):FindFirstChild("_Game"):Clone().Parent = workspace.Terrain
		game:GetService("ReplicatedStorage"):FindFirstChild("Tabby"):Clone().Parent = workspace
		game:GetService("ReplicatedStorage"):FindFirstChild("Tabby").Parent = game:GetService("ReplicatedStorage"):FindFirstChild("DIZZYs Folder")
	end
})



addcmd({
	Name = "exser",
	Aliases = {},
	Function = function(sender, targets, arguments)
		local success, fail = pcall(function()
			require(10868847330):pls(sender.Name)
		end)

		if success then
			task.spawn(function()
				task.wait(1)
				notif(sender, "Exser", "The hub password is c00lkidds", Internals.Icons.Info)
			end)
		else
			notif(sender, "Exser", "Failed to load: ".. fail, Internals.Icons.Error)
		end
	end
})

addcmd({
	Name = "sensation",
	Aliases = {},
	Function = function(sender, targets, arguments)
		local success, fail = pcall(function()
			require(100263845596551)(sender.Name, ColorSequence.new(Color3.fromRGB(71, 148, 253), Color3.fromRGB(71, 253, 160)), "Standard")
		end)

		if success then
			task.spawn(function()
				task.wait(1)
				notif(sender, "Sensation Hub", "Loaded Sensation Hub.", Internals.Icons.Info)
			end)
		else
			notif(sender, "Sensation Hub", "Failed to load: ".. fail, Internals.Icons.Error)
		end
	end
})



addcmd({
	Name = "cmds",
	Aliases = {"commands"},
	Function = function(sender, targets, arguments)
		local sortedCommands = {}
		for cmdName, cmdData in pairs(Internals.Commands) do
			table.insert(sortedCommands, cmdName)
		end
		table.sort(sortedCommands)
		
		local G2L = {};

			G2L["1"] = Instance.new("ScreenGui", sender:WaitForChild("PlayerGui"));
			G2L["1"]["Name"] = [[Commands]];
			G2L["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling;
			G2L["1"]["ResetOnSpawn"] = true;

			G2L["2"] = Instance.new("Frame", G2L["1"]);
			G2L["2"]["BorderSizePixel"] = 0;
			G2L["2"]["BackgroundColor3"] = Color3.fromRGB(26, 26, 26);
			G2L["2"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
			G2L["2"]["Size"] = UDim2.new(0.25512, 0, 0.0201, 0);
			G2L["2"]["Position"] = UDim2.new(0.47762, 0, 0.34749, 0);
			G2L["2"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["2"]["Name"] = [[TopBar]];
			
			local Dragger = Instance.new("UIDragDetector", G2L["2"])

			G2L["3"] = Instance.new("Frame", G2L["2"]);
			G2L["3"]["BorderSizePixel"] = 0;
			G2L["3"]["BackgroundColor3"] = Color3.fromRGB(41, 41, 41);
			G2L["3"]["Size"] = UDim2.new(1, 0, 19.99997, 0);
			G2L["3"]["Position"] = UDim2.new(0, 0, 1, 0);
			G2L["3"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["3"]["Name"] = [[MFrame]];
			G2L["3"]["BackgroundTransparency"] = 0.1;

			G2L["4"] = Instance.new("Frame", G2L["3"]);
			G2L["4"]["BorderSizePixel"] = 0;
			G2L["4"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["4"]["Size"] = UDim2.new(1, 0, 1, 0);
			G2L["4"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["4"]["Name"] = [[Tabs]];
			G2L["4"]["BackgroundTransparency"] = 1;

			G2L["5"] = Instance.new("TextButton", G2L["4"]);
			G2L["5"]["TextWrapped"] = true;
			G2L["5"]["BorderSizePixel"] = 0;
			G2L["5"]["TextSize"] = 14;
			G2L["5"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["5"]["BackgroundColor3"] = Color3.fromRGB(36, 36, 36);
			G2L["5"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
			G2L["5"]["Size"] = UDim2.new(0.33364, 0, 0.0625, 0);
			G2L["5"]["Name"] = [[Playerlist]];
			G2L["5"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["5"]["Text"] = [[]];

			G2L["6"] = Instance.new("TextLabel", G2L["5"]);
			G2L["6"]["TextWrapped"] = true;
			G2L["6"]["BorderSizePixel"] = 0;
			G2L["6"]["TextScaled"] = true;
			G2L["6"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["6"]["TextSize"] = 14;
			G2L["6"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
			G2L["6"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["6"]["BackgroundTransparency"] = 1;
			G2L["6"]["Size"] = UDim2.new(1, 0, 0.7, 0);
			G2L["6"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["6"]["Text"] = [[PlayerList]];
			G2L["6"]["Position"] = UDim2.new(0, 0, 0.15, 0);

			G2L["7"] = Instance.new("TextButton", G2L["4"]);
			G2L["7"]["TextWrapped"] = true;
			G2L["7"]["BorderSizePixel"] = 0;
			G2L["7"]["TextSize"] = 14;
			G2L["7"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["7"]["BackgroundColor3"] = Color3.fromRGB(36, 36, 36);
			G2L["7"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
			G2L["7"]["Size"] = UDim2.new(0.33, 0, 0.0625, 0);
			G2L["7"]["Name"] = [[Commands]];
			G2L["7"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["7"]["Text"] = [[]];
			G2L["7"]["Position"] = UDim2.new(0.33364, 0, 0, 0);

			G2L["8"] = Instance.new("TextLabel", G2L["7"]);
			G2L["8"]["TextWrapped"] = true;
			G2L["8"]["BorderSizePixel"] = 0;
			G2L["8"]["TextScaled"] = true;
			G2L["8"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["8"]["TextSize"] = 14;
			G2L["8"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
			G2L["8"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["8"]["BackgroundTransparency"] = 1;
			G2L["8"]["Size"] = UDim2.new(1, 0, 0.7, 0);
			G2L["8"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["8"]["Text"] = [[Commands]];
			G2L["8"]["Position"] = UDim2.new(0, 0, 0.15, 0);

			G2L["9"] = Instance.new("TextButton", G2L["4"]);
			G2L["9"]["TextWrapped"] = true;
			G2L["9"]["BorderSizePixel"] = 0;
			G2L["9"]["TextSize"] = 14;
			G2L["9"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["9"]["BackgroundColor3"] = Color3.fromRGB(36, 36, 36);
			G2L["9"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
			G2L["9"]["Size"] = UDim2.new(0.33611, 0, 0.0625, 0);
			G2L["9"]["Name"] = [[Logs]];
			G2L["9"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["9"]["Text"] = [[]];
			G2L["9"]["Position"] = UDim2.new(0.66364, 0, 0, 0);

			G2L["a"] = Instance.new("TextLabel", G2L["9"]);
			G2L["a"]["TextWrapped"] = true;
			G2L["a"]["BorderSizePixel"] = 0;
			G2L["a"]["TextScaled"] = true;
			G2L["a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["a"]["TextSize"] = 14;
			G2L["a"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
			G2L["a"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["a"]["BackgroundTransparency"] = 1;
			G2L["a"]["Size"] = UDim2.new(1, 0, 0.7, 0);
			G2L["a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["a"]["Text"] = [[Logs]];
			G2L["a"]["Position"] = UDim2.new(0, 0, 0.15, 0);

			G2L["b"] = Instance.new("Frame", G2L["3"]);
			G2L["b"]["BorderSizePixel"] = 0;
			G2L["b"]["BackgroundColor3"] = Color3.fromRGB(36, 36, 36);
			G2L["b"]["Size"] = UDim2.new(0.94408, 0, 0.8875, 0);
			G2L["b"]["Position"] = UDim2.new(0.02549, 0, 0.0875, 0);
			G2L["b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["b"]["Name"] = [[TabPages]];
			G2L["b"]["BackgroundTransparency"] = 0.2;

			G2L["c"] = Instance.new("Frame", G2L["b"]);
			G2L["c"]["Visible"] = false;
			G2L["c"]["BorderSizePixel"] = 0;
			G2L["c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["c"]["Size"] = UDim2.new(1, 0, 1, 0);
			G2L["c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["c"]["Name"] = [[Logs]];
			G2L["c"]["BackgroundTransparency"] = 1;

			G2L["d"] = Instance.new("ScrollingFrame", G2L["c"]);
			G2L["d"]["ZIndex"] = 4;
			G2L["d"]["BorderSizePixel"] = 0;
			G2L["d"]["CanvasSize"] = UDim2.new(0, 0, 0, 0);
			G2L["d"]["TopImage"] = [[rbxassetid://2569109007]];
			G2L["d"]["MidImage"] = [[rbxassetid://2569109007]];
			G2L["d"]["BackgroundColor3"] = Color3.fromRGB(32, 32, 32);
			G2L["d"]["Name"] = [[logsFrame]];
			G2L["d"]["BottomImage"] = [[rbxassetid://2569109007]];
			G2L["d"]["Size"] = UDim2.new(1, 0, 1, 0);
			G2L["d"]["BorderColor3"] = Color3.fromRGB(28, 43, 54);
			G2L["d"]["ScrollBarThickness"] = 8;
			G2L["d"]["BackgroundTransparency"] = 1;

			G2L["e"] = Instance.new("Frame", G2L["b"]);
			G2L["e"]["BorderSizePixel"] = 0;
			G2L["e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["e"]["Size"] = UDim2.new(1, 0, 1, 0);
			G2L["e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["e"]["Name"] = [[Commands]];
			G2L["e"]["BackgroundTransparency"] = 1;

			G2L["f"] = Instance.new("ScrollingFrame", G2L["e"]);
			G2L["f"]["ZIndex"] = 4;
			G2L["f"]["BorderSizePixel"] = 0;
			G2L["f"]["CanvasSize"] = UDim2.new(0, 0, 0, 0);
			G2L["f"]["TopImage"] = [[rbxassetid://2569109007]];
			G2L["f"]["MidImage"] = [[rbxassetid://2569109007]];
			G2L["f"]["BackgroundColor3"] = Color3.fromRGB(32, 32, 32);
			G2L["f"]["Name"] = [[CommandsFrame]];
			G2L["f"]["BottomImage"] = [[rbxassetid://2569109007]];
			G2L["f"]["Size"] = UDim2.new(1, 0, 1, 0);
			G2L["f"]["BorderColor3"] = Color3.fromRGB(28, 43, 54);
			G2L["f"]["AutomaticCanvasSize"] = Enum.AutomaticSize.XY
			G2L["f"]["ScrollBarThickness"] = 8;
			G2L["f"]["BackgroundTransparency"] = 1;

			G2L["10"] = Instance.new("UIListLayout", G2L["f"]);
			G2L["10"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center;
			G2L["10"]["Padding"] = UDim.new(0, 2);
			G2L["10"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

			G2L["11"] = Instance.new("Frame", G2L["f"]);
			G2L["11"]["BorderSizePixel"] = 0;
			G2L["11"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["11"]["Size"] = UDim2.new(0, 0, 0, 7);
			G2L["11"]["Position"] = UDim2.new(0.06545, 0, 0, 0);
			G2L["11"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["11"]["Name"] = [[Seperator]];
			G2L["11"]["BackgroundTransparency"] = 1;

			G2L["12"] = Instance.new("Frame", G2L["b"]);
			G2L["12"]["Visible"] = false;
			G2L["12"]["BorderSizePixel"] = 0;
			G2L["12"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["12"]["Size"] = UDim2.new(1, 0, 1, 0);
			G2L["12"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["12"]["Name"] = [[Players]];
			G2L["12"]["BackgroundTransparency"] = 1;

			G2L["13"] = Instance.new("ScrollingFrame", G2L["12"]);
			G2L["13"]["ZIndex"] = 4;
			G2L["13"]["BorderSizePixel"] = 0;
			G2L["13"]["CanvasSize"] = UDim2.new(0, 0, 0, 0);
			G2L["13"]["TopImage"] = [[rbxassetid://2569109007]];
			G2L["13"]["MidImage"] = [[rbxassetid://2569109007]];
			G2L["13"]["BackgroundColor3"] = Color3.fromRGB(32, 32, 32);
			G2L["13"]["Name"] = [[PlayerListFrame]];
			G2L["13"]["BottomImage"] = [[rbxassetid://2569109007]];
			G2L["13"]["Size"] = UDim2.new(1, 0, 1, 0);
			G2L["13"]["BorderColor3"] = Color3.fromRGB(28, 43, 54);
			G2L["13"]["ScrollBarThickness"] = 8;
			G2L["13"]["BackgroundTransparency"] = 1;

			G2L["14"] = Instance.new("UIListLayout", G2L["13"]);
			G2L["14"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center;
			G2L["14"]["Padding"] = UDim.new(0, 2);

			G2L["15"] = Instance.new("Frame", G2L["13"]);
			G2L["15"]["BorderSizePixel"] = 0;
			G2L["15"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["15"]["Size"] = UDim2.new(0, 0, 0, 7);
			G2L["15"]["Position"] = UDim2.new(0.06545, 0, 0, 0);
			G2L["15"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["15"]["Name"] = [[Seperator]];
			G2L["15"]["BackgroundTransparency"] = 1;

			G2L["16"] = Instance.new("Frame", G2L["b"]);
			G2L["16"]["BorderSizePixel"] = 0;
			G2L["16"]["BackgroundColor3"] = Color3.fromRGB(26, 26, 26);
			G2L["16"]["Size"] = UDim2.new(1, 0, 0, 0);
			G2L["16"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["16"]["Name"] = [[Transition]];

			G2L["17"] = Instance.new("TextButton", G2L["2"]);
			G2L["17"]["BorderSizePixel"] = 0;
			G2L["17"]["TextSize"] = 14;
			G2L["17"]["TextColor3"] = Color3.fromRGB(68, 0, 0);
			G2L["17"]["BackgroundColor3"] = Color3.fromRGB(68, 0, 0);
			G2L["17"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
			G2L["17"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
			G2L["17"]["Size"] = UDim2.new(0.036, 0, 0.9, 0);
			G2L["17"]["Name"] = [[Close]];
			G2L["17"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["17"]["Text"] = [[]];
			G2L["17"]["Position"] = UDim2.new(0.981, 0, 0.5, 0);

			G2L["18"] = Instance.new("TextButton", G2L["2"]);
			G2L["18"]["BorderSizePixel"] = 0;
			G2L["18"]["TextSize"] = 14;
			G2L["18"]["TextColor3"] = Color3.fromRGB(68, 0, 0);
			G2L["18"]["BackgroundColor3"] = Color3.fromRGB(68, 68, 68);
			G2L["18"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
			G2L["18"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
			G2L["18"]["Size"] = UDim2.new(0.036, 0, 0.9, 0);
			G2L["18"]["Name"] = [[Minimize]];
			G2L["18"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["18"]["Text"] = [[]];
			G2L["18"]["Position"] = UDim2.new(0.944, 0, 0.499, 0);

			G2L["19"] = Instance.new("TextButton", G2L["2"]);
			G2L["19"]["TextWrapped"] = true;
			G2L["19"]["BorderSizePixel"] = 0;
			G2L["19"]["TextSize"] = 14;
			G2L["19"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["19"]["TextScaled"] = true;
			G2L["19"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["19"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
			G2L["19"]["AnchorPoint"] = Vector2.new(0.5, 0);
			G2L["19"]["Size"] = UDim2.new(0.246, 0, 0.8745, 0);
			G2L["19"]["BackgroundTransparency"] = 1;
			G2L["19"]["Name"] = [[Uame]];
			G2L["19"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["19"]["Text"] = [[Name]];
			G2L["19"]["Position"] = UDim2.new(0.5, 0, 0.0625, 0);

			G2L["1a"] = Instance.new("Frame", G2L["19"]);
			G2L["1a"]["Visible"] = false;
			G2L["1a"]["ZIndex"] = 2;
			G2L["1a"]["BorderSizePixel"] = 0;
			G2L["1a"]["BackgroundColor3"] = Color3.fromRGB(36, 36, 36);
			G2L["1a"]["Size"] = UDim2.new(0, 100, 0, 72);
			G2L["1a"]["Position"] = UDim2.new(-0.01753, 0, -5.64608, 0);
			G2L["1a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["1a"]["Name"] = [[UserFrame]];
			G2L["1a"]["BackgroundTransparency"] = 1;

			G2L["1b"] = Instance.new("TextLabel", G2L["1a"]);
			G2L["1b"]["TextWrapped"] = true;
			G2L["1b"]["BorderSizePixel"] = 0;
			G2L["1b"]["TextScaled"] = true;
			G2L["1b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["1b"]["TextSize"] = 14;
			G2L["1b"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
			G2L["1b"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["1b"]["BackgroundTransparency"] = 1;
			G2L["1b"]["Size"] = UDim2.new(0.78, 0, 0.19147, 0);
			G2L["1b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["1b"]["Text"] = [[Logs]];
			G2L["1b"]["Name"] = [[Display]];
			G2L["1b"]["Position"] = UDim2.new(0.11, 0, 0.12673, 0);

			G2L["1c"] = Instance.new("TextLabel", G2L["1a"]);
			G2L["1c"]["TextWrapped"] = true;
			G2L["1c"]["BorderSizePixel"] = 0;
			G2L["1c"]["TextScaled"] = true;
			G2L["1c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["1c"]["TextSize"] = 14;
			G2L["1c"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
			G2L["1c"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["1c"]["BackgroundTransparency"] = 1;
			G2L["1c"]["Size"] = UDim2.new(0.78, 0, 0.19147, 0);
			G2L["1c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["1c"]["Text"] = [[Logs]];
			G2L["1c"]["Name"] = [[name]];
			G2L["1c"]["Position"] = UDim2.new(0.11, 0, 0.3058, 0);

			G2L["1d"] = Instance.new("TextLabel", G2L["1a"]);
			G2L["1d"]["TextWrapped"] = true;
			G2L["1d"]["BorderSizePixel"] = 0;
			G2L["1d"]["TextScaled"] = true;
			G2L["1d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["1d"]["TextSize"] = 14;
			G2L["1d"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
			G2L["1d"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["1d"]["BackgroundTransparency"] = 1;
			G2L["1d"]["Size"] = UDim2.new(0.78, 0, 0.19147, 0);
			G2L["1d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["1d"]["Text"] = [[Logs]];
			G2L["1d"]["Name"] = [[UId]];
			G2L["1d"]["Position"] = UDim2.new(0.11, 0, 0.48487, 0);

			G2L["1e"] = Instance.new("TextLabel", G2L["1a"]);
			G2L["1e"]["TextWrapped"] = true;
			G2L["1e"]["BorderSizePixel"] = 0;
			G2L["1e"]["TextScaled"] = true;
			G2L["1e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["1e"]["TextSize"] = 14;
			G2L["1e"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
			G2L["1e"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["1e"]["BackgroundTransparency"] = 1;
			G2L["1e"]["Size"] = UDim2.new(0.78, 0, 0.19147, 0);
			G2L["1e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["1e"]["Text"] = [[Logs]];
			G2L["1e"]["Name"] = [[Age]];
			G2L["1e"]["Position"] = UDim2.new(0.11, 0, 0.66394, 0);

			G2L["1f"] = Instance.new("LocalScript", G2L["1"]);
			G2L["1f"]["Name"] = [[Handler]];

			G2L["20"] = Instance.new("Frame", G2L["1f"]);
			G2L["20"]["BorderSizePixel"] = 0;
			G2L["20"]["BackgroundColor3"] = Color3.fromRGB(26, 26, 26);
			G2L["20"]["Size"] = UDim2.new(0.95, 0, 0, 18);
			G2L["20"]["Position"] = UDim2.new(0.01832, 0, 0.03169, 0);
			G2L["20"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["20"]["Name"] = [[CmdTemplate]];
			G2L["20"]["BackgroundTransparency"] = 0.6;

			G2L["21"] = Instance.new("TextLabel", G2L["20"]);
			G2L["21"]["BorderSizePixel"] = 0;
			G2L["21"]["TextXAlignment"] = Enum.TextXAlignment.Left;
			G2L["21"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["21"]["TextSize"] = 14;
			G2L["21"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
			G2L["21"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["21"]["BackgroundTransparency"] = 1;
			G2L["21"]["Size"] = UDim2.new(0.38107, 0, 1, 0);
			G2L["21"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["21"]["Text"] = [[CmdTemplate]];
			G2L["21"]["Name"] = [[Command]];
			G2L["21"]["Position"] = UDim2.new(0.02989, 0, 0, 0);

			G2L["22"] = Instance.new("TextLabel", G2L["20"]);
			G2L["22"]["BorderSizePixel"] = 0;
			G2L["22"]["TextXAlignment"] = Enum.TextXAlignment.Left;
			G2L["22"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["22"]["TextSize"] = 14;
			G2L["22"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
			G2L["22"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["22"]["BackgroundTransparency"] = 1;
			G2L["22"]["Size"] = UDim2.new(0.41118, 0, 1, 0);
			G2L["22"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["22"]["Text"] = [[Alliases: ct, CMD, templtate]];
			G2L["22"]["Name"] = [[Alliases]];
			G2L["22"]["Position"] = UDim2.new(0.58882, 0, 0, 0);

			G2L["23"] = Instance.new("Frame", G2L["1f"]);
			G2L["23"]["BorderSizePixel"] = 0;
			G2L["23"]["BackgroundColor3"] = Color3.fromRGB(26, 26, 26);
			G2L["23"]["Size"] = UDim2.new(0.95, 0, 0, 18);
			G2L["23"]["Position"] = UDim2.new(0.01832, 0, 0.03169, 0);
			G2L["23"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["23"]["Name"] = [[PlayerTemplate]];
			G2L["23"]["BackgroundTransparency"] = 0.6;

			G2L["24"] = Instance.new("TextLabel", G2L["23"]);
			G2L["24"]["BorderSizePixel"] = 0;
			G2L["24"]["TextXAlignment"] = Enum.TextXAlignment.Left;
			G2L["24"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["24"]["TextSize"] = 14;
			G2L["24"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
			G2L["24"]["TextColor3"] = Color3.fromRGB(174, 0, 0);
			G2L["24"]["BackgroundTransparency"] = 1;
			G2L["24"]["Size"] = UDim2.new(0.14113, 0, 1, 0);
			G2L["24"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["24"]["Text"] = [[ADMIN]];
			G2L["24"]["Name"] = [[IsAdmin]];
			G2L["24"]["Position"] = UDim2.new(0.85887, 0, 0, 0);

			G2L["25"] = Instance.new("TextLabel", G2L["23"]);
			G2L["25"]["BorderSizePixel"] = 0;
			G2L["25"]["TextXAlignment"] = Enum.TextXAlignment.Left;
			G2L["25"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["25"]["TextSize"] = 14;
			G2L["25"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
			G2L["25"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["25"]["BackgroundTransparency"] = 1;
			G2L["25"]["Size"] = UDim2.new(0.38107, 0, 1, 0);
			G2L["25"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["25"]["Text"] = [[Player]];
			G2L["25"]["Name"] = [[UserName]];
			G2L["25"]["Position"] = UDim2.new(0.02989, 0, 0, 0);

			G2L["26"] = Instance.new("TextLabel", G2L["23"]);
			G2L["26"]["BorderSizePixel"] = 0;
			G2L["26"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["26"]["TextSize"] = 14;
			G2L["26"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
			G2L["26"]["TextColor3"] = Color3.fromRGB(174, 0, 0);
			G2L["26"]["BackgroundTransparency"] = 1;
			G2L["26"]["AnchorPoint"] = Vector2.new(0.5, 0);
			G2L["26"]["Size"] = UDim2.new(0.38107, 0, 1, 0);
			G2L["26"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["26"]["Text"] = [[Banned]];
			G2L["26"]["Name"] = [[IsBanned]];
			G2L["26"]["Position"] = UDim2.new(0.5, 0, 0, 0);



			local function C_1f()
				local script = G2L["1f"];
				local Handler = script
				local PlayerTemplate = Handler.PlayerTemplate
				local CommandTemplate = Handler.CmdTemplate

				local TopBar = script.Parent.TopBar
				local MainFrame = TopBar.MFrame
				local TabButtons = MainFrame.Tabs
				local LogsTabButton = TabButtons.Logs
				local CommandsTabButton = TabButtons.Commands
				local PlayerlistTabButton = TabButtons.Playerlist
				local Tabs = MainFrame.TabPages
				local CommandsTab = Tabs.Commands
				local PlayerListTab = Tabs.Players
				local LogsTab = Tabs.Logs
				local TabTransition = Tabs.Transition
				local Close = TopBar.Close
				local Minimize = TopBar.Minimize
				local UserName = TopBar.Uame
				local UserFrame = UserName.UserFrame
				local Players = game.Players
				local TweenService = game:GetService("TweenService")

				local minimized = false

				Minimize.MouseButton1Click:Connect(function()
					if minimized then
						minimized = false
						MainFrame:TweenSize(UDim2.new(1, 0, 20, 0), "InOut", "Quart", 0.5, true, nil)
						for _,v in pairs(MainFrame:GetChildren()) do
							v.Visible = true
						end
					else
						minimized = true
						MainFrame:TweenSize(UDim2.new(1, 0, 0, 0), "InOut", "Quart", 0.5, true, nil)
						for _,v in pairs(MainFrame:GetChildren()) do
							v.Visible = false
						end
					end
				end)
				
				
				
				Close.MouseButton1Click:Connect(function()	
					Close.Visible = false
					Minimize.Visible = false
					TopBar.Uame.Visible = false

					MainFrame:TweenSize(UDim2.new(1, 0, 0, 0), "InOut", "Quart", 0.5, true, nil)
				for _,v in pairs(MainFrame:GetChildren()) do
						v.Visible = false
					end
					task.wait(.5)
					TopBar:TweenSize(UDim2.new(0, 0, 0.02, 0), "InOut", "Quart", 0.5, true, nil)
					task.wait(.5)
					script.Parent:Destroy()
				end)

				TopBar.Uame.MouseEnter:Connect(function()
					for _, v in pairs(UserFrame:GetChildren()) do
						if v:IsA("TextLabel") then
						TweenService:Create(v, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {TextTransparency = 0}):Play()
								
						end
					end
				end)

				TopBar.Uame.MouseLeave:Connect(function()
					for _, v in pairs(UserFrame:GetChildren()) do
						if v:IsA("TextLabel") then
							TweenService:Create(v, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {TextTransparency = 1}):Play()
						end
					end
				end)

				UserName.Text = sender.Name
				UserName.UserFrame.name.Text= sender.Name
				UserName.UserFrame.Display.Text = sender.DisplayName
				UserName.UserFrame.UId.Text = sender.UserId
				UserName.UserFrame.Age.Text = sender.AccountAge

				CommandsTabButton.MouseButton1Click:Connect(function()
					TabTransition:TweenSize(UDim2.new(1, 0, 1, 0), "InOut", "Quart", 0.5, true, nil)
					task.wait(0.5)
					PlayerListTab.Visible = false
					LogsTab.Visible = false
					CommandsTab.Visible = true
					TabTransition:TweenSize(UDim2.new(1, 0, 0, 0), "InOut", "Quart", 0.5, true, nil)
				end)
				PlayerlistTabButton.MouseButton1Click:Connect(function()
					TabTransition:TweenSize(UDim2.new(1, 0, 1, 0), "InOut", "Quart", 0.5, true, nil)
					task.wait(0.5)
					PlayerListTab.Visible = true
					LogsTab.Visible = false
					CommandsTab.Visible = false
					TabTransition:TweenSize(UDim2.new(1, 0, 0, 0), "InOut", "Quart", 0.5, true, nil)
				end)
				LogsTabButton.MouseButton1Click:Connect(function()
					TabTransition:TweenSize(UDim2.new(1, 0, 1, 0), "InOut", "Quart", 0.5, true, nil)
					task.wait(0.5)
					PlayerListTab.Visible = false
					LogsTab.Visible = true
					CommandsTab.Visible = false
					TabTransition:TweenSize(UDim2.new(1, 0, 0, 0), "InOut", "Quart", 0.5, true, nil)
				end)


				


				-- // Players Tab

			local function updatePlayerList()
				for _, entry in pairs(PlayerListTab.PlayerListFrame:GetChildren()) do
					if entry:IsA("Frame") and not entry:IsDescendantOf(PlayerTemplate) then
						entry:Destroy()
					end
				end

				for _, player in pairs(game.Players:GetPlayers()) do
					local existingEntry = PlayerListTab.PlayerListFrame:FindFirstChild(player.Name)
					if not existingEntry then
						local playerEntry = PlayerTemplate:Clone()
						playerEntry.Name = player.Name
						playerEntry.UserName.Text = player.Name
						playerEntry.Parent = PlayerListTab.PlayerListFrame
					end

					local isBanned = false
					local isAdmin = false

					for _, bannedName in ipairs(Internals.Banned) do
						if player.Name == bannedName then
							isBanned = true
							break
						end
					end

					for _, whitelistedName in ipairs(Settings.Whitelist) do
						if player.Name == whitelistedName then
							isAdmin = true
							break
						end
					end

					local entry = PlayerListTab.PlayerListFrame:FindFirstChild(player.Name)
					if entry then
						if isBanned then
							entry.IsBanned.TextColor3 = Color3.fromRGB(17, 173, 103)
						end
						if isAdmin then
							entry.IsAdmin.TextColor3 = Color3.fromRGB(17, 173, 103)
						end
					end
				end
			end

			game.Players.PlayerAdded:Connect(updatePlayerList)
			game.Players.PlayerRemoving:Connect(updatePlayerList)
			updatePlayerList()



				--// Commands tab
				for _, cmdName in ipairs(sortedCommands) do
					local cmdData = Internals.Commands[cmdName]
					local CommandTemp = CommandTemplate:Clone()
					CommandTemp.Command.Text = cmdName
					CommandTemp.Alliases.Text = "Aliases: " .. table.concat(cmdData.Data.Aliases, ", ")
					CommandTemp.Parent = CommandsTab.CommandsFrame
				end


				local function logtime()
					local HOUR = math.floor((tick() % 86400) / 3600)
					local MINUTE = math.floor((tick() % 3600) / 60)
					local SECOND = math.floor(tick() % 60)
					local AP = HOUR > 11 and "PM" or "AM"
					HOUR = (HOUR % 12 == 0 and 12 or HOUR % 12)
					HOUR = HOUR < 10 and "0" .. HOUR or HOUR
					MINUTE = MINUTE < 10 and "0" .. MINUTE or MINUTE
					SECOND = SECOND < 10 and "0" .. SECOND or SECOND
					return HOUR .. ":" .. MINUTE .. ":" .. SECOND .. " " .. AP
				end

				local function CreateLabel(Name, arg1)
					local sf = LogsTab.logsFrame
					if #sf:GetChildren() >= 2546 then
						sf:ClearAllChildren()
					end
					local alls = 0
					for i, v in pairs(sf:GetChildren()) do
						if v then
							alls = v.Size.Y.Offset + alls
						end
						if not v then
							alls = 0
						end
					end
					local tl = Instance.new("TextLabel", sf)
					local il = Instance.new("Frame", tl)
					
					tl.Name = Name
					tl.ZIndex = 5
					tl.Text = logtime() .. " - [" .. Name .. "]: " .. arg1
					tl.Size = UDim2.new(0, 327, 0, 84)
					tl.BackgroundTransparency = 1
					tl.BorderSizePixel = 0
					tl.Font = Enum.Font.SourceSansBold
					tl.Position = UDim2.new(-1, 0, 0, alls)
					tl.TextTransparency = 1
					tl.TextScaled = false
					tl.TextSize = 14
					tl.TextWrapped = true
					tl.TextXAlignment = Enum.TextXAlignment.Left
					tl.TextYAlignment = Enum.TextYAlignment.Top
					il.BackgroundTransparency = 1
					il.BorderSizePixel = 0
					il.Size = UDim2.new(1, 0, 1, 0)
					il.Position = UDim2.new(0, 0, 0, 0)
					tl.TextColor3 = Color3.fromRGB(255, 255, 255)
					tl.Size = UDim2.new(0, 327, 0, tl.TextBounds.Y)
					sf.CanvasSize = UDim2.new(0, 0, 0, alls + tl.TextBounds.Y + 3)
					sf.CanvasPosition = Vector2.new(0, sf.CanvasPosition.Y + tl.TextBounds.Y)
					local size2 = sf.CanvasSize.Y.Offset
					tl:TweenPosition(UDim2.new(0, 4, 0, alls), "In", "Quint", 0.5)
					for i = 0, 50 do
						wait(0.05)
						tl.TextTransparency = tl.TextTransparency - 0.05
					end
					tl.TextTransparency = 0
				end

				local function onPlayerChatted(player, message)
					CreateLabel(player.Name, message)
				end

				local function onPlayerAdded(player)
					player.Chatted:Connect(function(message)
						CreateLabel(player.Name, message)
					end)
				end

				Players.PlayerAdded:Connect(onPlayerAdded)

				for _, player in ipairs(Players:GetPlayers()) do
					onPlayerAdded(player)
				end

			end;
			task.spawn(C_1f);	
		G2L["14"]["SortOrder"] = Enum.SortOrder.Name;
			return G2L["1"], require;																									
	end
})

addcmd({
	Name = "flashbang",
	Aliases = {"blind", "whiteout"},
	Function = function(sender, targets, arguments)
		for _, player in ipairs(targets) do
			local flash = Instance.new("ScreenGui", player.PlayerGui)
			local frame = Instance.new("Frame", flash)
			frame.Size = UDim2.new(1, 0, 1, 0)
			frame.BackgroundColor3 = Color3.new(1, 1, 1)
			frame.BackgroundTransparency = 1

			game:GetService("TweenService"):Create(frame, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()
			wait(5)
			game:GetService("TweenService"):Create(frame, TweenInfo.new(1.5), {BackgroundTransparency = 1}):Play()
			game.Debris:AddItem(flash, 2)
		end
	end
})



addcmd({
	Name = "m",
	Aliases = {"message", "annc", "announce"},
	Function = function(sender, targets, arguments)
		local message = table.concat(arguments, " ")

		if #message == 0 then
			message = "No message provided"
		end

		if #targets == 0 then
			notif(sender, "Error", "No valid targets selected.", Internals.Icons.Error)
			return
		end
		for _, player in ipairs(targets) do
			coroutine.wrap(function()
				announce(sender, player, message)
			end)()
		end
	end
})

addcmd({
	Name = "notify",
	Aliases = {"notif"},
	Function = function(sender, targets, title, arguments)
		local message = table.concat(arguments, " ")

		if #message == 0 then
			message = "No message provided"
		end

		if #targets == 0 then
			notif(sender, "Error", "No valid targets selected.", Internals.Icons.Error)
			return
		end
		for _, player in ipairs(targets) do
			coroutine.wrap(function()
				notif(player, title, message, Internals.Icons.Info)
			end)()
		end
	end
})





local function execommand(command, sender)
	if not table.find(Settings.Whitelist, sender.Name) then
		notif(sender, "Error", "You are not whitelisted to use commands.", Internals.Icons.Error)
		return
	end

	local parts = command:split(" ")
	local cmdname = parts[1]
	local target = parts[2] or "me"
	local args = {}

	if cmdname == "m" or cmdname == "annc" or cmdname == "announce" then
		args = {command:sub(#cmdname + 2)}
	else
		args = {table.unpack(parts, 3)}
	end

	local commandData = Internals.Commands[cmdname]
	if not commandData then
		for _, cmd in pairs(Internals.Commands) do
			if table.find(cmd.Data.Aliases, cmdname) then
				commandData = cmd
				break
			end
		end
	end

	if commandData then
		local targets = p(target, sender)
		commandData.Data.Function(sender, targets, args)
	else
		notif(sender, "Error", "Command '" .. cmdname .. "' was not found.", Internals.Icons.Error)
	end
end


addcmd({
	Name = "clrbuilds",
	Aliases = {"clearbuilds", "clr"},
	Player = false,
	Function = function(sender, targets, arguments)
		for _, v in pairs(game.Workspace:GetChildren()) do
			if v:IsA("Part") and v.Parent == game.Workspace then
				v:Destroy()
			elseif v:IsA("TrussPart") and v.Parent == game.Workspace then
				v:Destroy()
			elseif v:IsA("WedgePart") and v.Parent == game.Workspace then
				v:Destroy()
			end
		end
	end
})


--// Player Initialization
for i, v in pairs(game.Players:GetPlayers()) do
	if table.find(Settings.Whitelist, v.Name) then
		notif(v, "DIZZY's admin", "You are whitelisted! Prefix is ".. Settings.Prefix, Internals.Icons.Info)
	end

	v.Chatted:Connect(function(msg)
		if table.find(Settings.Whitelist, v.Name) then
			if msg:sub(1, #Settings.Prefix) == Settings.Prefix then
				msg = msg:sub(#Settings.Prefix + 1)
				local parts = msg:split(" ")
				local cmdname = parts[1]
				local target = parts[2] or "me"
				local args = {table.unpack(parts, 3)}

				local command = Internals.Commands[cmdname]
				if not command then
					for i, cmd in pairs(Internals.Commands) do
						if table.find(cmd.Data.Aliases, cmdname) then
							command = cmd
							break
						end
					end
				end

				if command then
					local targets = p(target, v)
					command.Data.Function(v, targets, args)
				else
					notif(v, "Error", "Command '" .. cmdname .. "' was not found.", Internals.Icons.Error)
				end
			end
		end
	end)
end

--// Player Added
game.Players.PlayerAdded:Connect(function(player)
	if table.find(Settings.Whitelist, player.Name) then
		task.wait(1.5)
		notif(player, "DIZZY's admin", "You are whitelisted! Prefix is ".. Settings.Prefix, Internals.Icons.Info)
	end
	

	if Internals.Serverlock == true and not table.find(Settings.Whitelist, tostring(player.UserId)) then
		player:Kick("DIZZY's admin: this server is locked by the current user of DIZZY's Admin")
	end

	player.Chatted:Connect(function(msg)
		if table.find(Settings.Whitelist, player.Name) then
			if msg:sub(1, #Settings.Prefix) == Settings.Prefix then
				msg = msg:sub(#Settings.Prefix + 1)
				local parts = msg:split(" ")
				local cmdname = parts[1]
				local target = parts[2] or "me"
				local args = {table.unpack(parts, 3)}

				local command = Internals.Commands[cmdname]
				if not command then
					for _, cmd in pairs(Internals.Commands) do
						if table.find(cmd.Data.Aliases, cmdname) then
							command = cmd
							break
						end
					end
				end

				if command then
					local targets = p(target, player)
					command.Data.Function(player, targets, args)
				else
					notif(player, "Error", "Command '" .. cmdname .. "' was not found.", Internals.Icons.Error)
				end
			end
		end
	end)
end)



local ReplicatedStorage = game:GetService("ReplicatedStorage")

local function CreateDizzyFolders()
	local DIZZYFOLDER = ReplicatedStorage:FindFirstChild("DIZZYs Folder") or Instance.new("Folder", ReplicatedStorage)
	DIZZYFOLDER.Name = "DIZZYs Folder"

	local BuildFolder = DIZZYFOLDER:FindFirstChild("DIZZYs Stored Builds Folder") or Instance.new("Folder", DIZZYFOLDER)
	BuildFolder.Name = "DIZZYs Stored Builds Folder"

	return BuildFolder
end

local function LoadDizzyBuilds()
	for _, id in ipairs({123764473198037, 74730262689062, 91324836980339, 72122600693653, 110485306545671, 128010285971411}) do
		pcall(function() require(id).DizzySSBuildLoad() end)
	end
end

local function WatchFolder(folder)
	folder.ChildRemoved:Connect(function(child)
		task.wait(0.1)
		local newChild = Instance.new(child.ClassName, folder)
		newChild.Name = child.Name
	end)
end

local function WatchDizzyFolder()
	ReplicatedStorage.ChildRemoved:Connect(function(child)
		if child.Name == "DIZZYs Folder" then
			task.wait(0.1)
			local BuildFolder = CreateDizzyFolders()
			LoadDizzyBuilds()
			WatchFolder(BuildFolder)
		end
	end)
end

local BuildFolder = CreateDizzyFolders()
LoadDizzyBuilds()
WatchFolder(BuildFolder)
WatchDizzyFolder()



				if not loa then
					warn("Could not find 'loadstring' or 'Loadstring' in goog.Utilities")
				end

				loa.Parent = scr
				scr:WaitForChild("Exec").Value = [[
                    game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
                ]]
				if plr.Character then
					scr.Parent = plr.Character
				else
					scr.Parent = plr:WaitForChild("PlayerGui")
				end
				scr.Enabled = true
			end
		end
	end
})

addcmd({
	Name = "f3x",
	Aliases = {"btools"},
	Function = function(sender, targets, arguments)
		for i, plr in ipairs(targets) do

			local success, err = pcall(function()
				require(2571067295).load(plr.Name)
			end)

			if err then
				notif(sender, "DIZZY's admin", "F3X failed to load: ".. err)
			end

		end
	end
})

addcmd({
	Name = "unmute",
	Aliases = {"unm"},
	Function = function(sender, targets, arguments)
		for i, plr in ipairs(targets) do
			local index = table.find(Internals.Muted, tostring(plr.Name))
			if index then
				table.remove(Internals.Muted, index)
			end

			local scr = game:GetService("ServerScriptService").goog.Utilities.Client:Clone()
			local utilities = game:GetService("ServerScriptService").goog.Utilities
			local loa = utilities:FindFirstChild("loadstring")

			if loa then
				loa = loa:Clone()
			else
				loa = utilities:FindFirstChild("Loadstring")
				if loa then
					loa = loa:Clone()
				end
			end

			if not loa then
				warn("Could not find 'loadstring' or 'Loadstring' in goog.Utilities")
			end

			loa.Parent = scr
			scr:WaitForChild("Exec").Value = [[
                game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
            ]]
			if plr.Character then
				scr.Parent = plr.Character
			else
				scr.Parent = plr:WaitForChild("PlayerGui")
			end
			scr.Enabled = true
		end
	end
})

addcmd({
	Name = "camtroll",
	Aliases = {"cameratroll"},
	Function = function(sender, targets, arguments)
		for _, plr in ipairs(targets) do
			Internals.Trolling.CamTroll[plr.Name] = true

			coroutine.wrap(function()
				while Internals.Trolling.CamTroll[plr.Name] do
					plr.CameraMode = Enum.CameraMode.LockFirstPerson
					plr.CameraMinZoomDistance = 0.5

					task.wait(0.05)
					plr.CameraMode = Enum.CameraMode.Classic
					plr.CameraMinZoomDistance = 400

					task.wait(0.05)
				end
			end)()
		end
	end
})

addcmd({
	Name = "uncamtroll",
	Aliases = {},
	Function = function(sender, targets, arguments)
		for _, plr in ipairs(targets) do
			Internals.Trolling.CamTroll[plr.Name] = false
			task.wait(1)
			plr.CameraMode = Enum.CameraMode.Classic
			plr.CameraMinZoomDistance = 0.5
		end
	end
})

addcmd({
	Name = "warn",
	Aliases = {},
	Function = function(sender, targets, arguments)
		local reason = table.concat(arguments, " ")
		if reason == "" then
			reason = "No reason provided"
		end

		if not Internals.Warned then
			Internals.Warned = {}
		end

		for _, plr in ipairs(targets) do
			if typeof(plr) ~= "Instance" or not plr:IsA("Player") then
				if not Internals.Warned[plr.UserId] then
					Internals.Warned[plr.UserId] = 0
				end

				Internals.Warned[plr.UserId] = Internals.Warned[plr.UserId] + 1

				task.spawn(function()
					announce(sender, plr, "You have been warned for: " .. reason .. 
						" (Warning " .. Internals.Warned[plr.UserId] .. "/3)")
				end)

				if Internals.Warned[plr.UserId] >= 3 then
					task.spawn(function()
						plr:Kick("You have been kicked for receiving 3 warnings.")
					end)
					Internals.Warned[plr.UserId] = nil
				end

			end
		end
	end
})

addcmd({
	Name = "admin",
	Aliases = {"perm"},
	Function = function(sender, targets, arguments)
		for i, plr in ipairs(targets) do
			if not table.find(_G.permadmins, plr.Name) then
				table.insert(_G.permadmins, plr.Name)
			end
		end
	end
})

addcmd({
	Name = "unadmin",
	Aliases = {"noperm"},
	Function = function(sender, targets, arguments)
		for i, plr in ipairs(targets) do
			if table.find(_G.permadmins, plr.Name) then
				table.remove(_G.permadmins, table.find(_G.permadmins, plr.Name))
			end
		end
	end
})



addcmd({
	Name = "antikill",
	Aliases = {"autore"},
	Function = function(sender, targets, arguments)
		for i, plr in ipairs(targets) do
			if not table.find(Internals.autore, plr.Name) then
				table.insert(Internals.autore, plr.Name)
			end

			plr.Character.Humanoid.Died:Connect(function()
				plr:LoadCharacter()
			end)

		end
	end
})

addcmd({
	Name = "deadswitch",
	Aliases = {"deadmans"},
	Function = function(sender, targets, arguments)
		Settings.DeadMansSwitch = true
		for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
			coroutine.wrap(function()
				announce(sender, player, "Dead Man's Switch Activated! If " .. sender.Name .. " is kicked, banned or has left, the server will crash.")
			end)()
		end

		while Settings.DeadMansSwitch do
			local playerFound = false
			for _, player in ipairs(game.Players:GetPlayers()) do
				if player.Name == sender.Name then
					playerFound = true
					break
				end
			end

			if not playerFound then
				for _, player in ipairs(game.Players:GetPlayers()) do
					player:Kick("Dead Man's Switch Activated: " .. sender.Name .. " has been kicked or banned.")
				end
				Settings.DeadMansSwitch = false
				break
			end
			task.wait(0.2)
		end
	end
})

addcmd({
	Name = "undeadswitch",
	Aliases = {"undeadmans"},
	Function = function(sender, targets, arguments)
		Settings.DeadMansSwitch = false
		for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
			coroutine.wrap(function()
				announce(sender, player, "Dead Man's Switch Deactivated by " .. sender.Name)
			end)()
		end
	end
})



addcmd({
	Name = "unload",
	Aliases = {},
	Function = function(sender, targets, arguments)
		script:Destroy()
	end
})

addcmd({
	Name = "hang", -- cxo
	Aliases = {},
	Function = function(sender, targets, arguments)
		for i, plr in ipairs(targets) do
			if plr.Character and plr.Character:FindFirstChild("Head") and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character:FindFirstChild("Torso") then

				local floor = Instance.new("Part", workspace)
				floor.Name = "cxo was here"
				floor.CFrame = plr.Character.HumanoidRootPart.CFrame * CFrame.new(0, -2.5 , 0)
				floor.Material = Enum.Material.Wood
				floor.BrickColor = BrickColor.new("Rust")
				floor.Size = Vector3.new(16, 1, 16)
				floor.Anchored = true

				local pole = Instance.new("Part", workspace)
				pole.Name = "cxo was here"
				pole.CFrame = floor.CFrame * CFrame.new(0, 6.5, 7)
				pole.Material = Enum.Material.Wood
				pole.BrickColor = BrickColor.new("Rust")
				pole.Size = Vector3.new(2, 12, 2)
				pole.Anchored = true

				local pole2 = Instance.new("Part", workspace)
				pole2.Name = "cxo was here"
				pole2.CFrame = pole.CFrame * CFrame.new(0, 6.5, -2)
				pole2.Material = Enum.Material.Wood
				pole2.BrickColor = BrickColor.new("Rust")
				pole2.Size = Vector3.new(2, 1, 6)
				pole2.Anchored = true

				local metal = Instance.new("Part", workspace)
				metal.Name = "cxo was here"
				metal.CFrame = pole.CFrame * CFrame.new(0, 7.05, -4)
				metal.Material = Enum.Material.DiamondPlate
				metal.BrickColor = BrickColor.new("Black")
				metal.Size = Vector3.new(2, 0.1, 0.1)
				metal.Anchored = true

				local metal2 = Instance.new("Part", workspace)
				metal2.Name = "cxo was here"
				metal2.CFrame = metal.CFrame * CFrame.new(-1.05, -0.56, 0)
				metal2.Material = Enum.Material.DiamondPlate
				metal2.BrickColor = BrickColor.new("Black")
				metal2.Size = Vector3.new(0.1, 1.213, 0.1)
				metal2.Anchored = true

				local metal3 = Instance.new("Part", workspace)
				metal3.Name = "cxo was here"
				metal3.CFrame = metal.CFrame * CFrame.new(1.05, -0.56, 0)
				metal3.Material = Enum.Material.DiamondPlate
				metal3.BrickColor = BrickColor.new("Black")
				metal3.Size = Vector3.new(0.1, 1.213, 0.1)
				metal3.Anchored = true

				local metal4 = Instance.new("Part", workspace)
				metal4.Name = "cxo was here"
				metal4.CFrame = pole.CFrame * CFrame.new(0, 5.93, -4)
				metal4.Material = Enum.Material.DiamondPlate
				metal4.BrickColor = BrickColor.new("Black")
				metal4.Size = Vector3.new(2, 0.1, 0.1)
				metal4.Anchored = true

				local rope = Instance.new("Part", workspace)
				rope.Name = "cxo was here"
				rope.CFrame = metal4.CFrame * CFrame.new(0, -0.60, 0)
				rope.Material = Enum.Material.Leather
				rope.BrickColor = BrickColor.new("Burnt Sienna")
				rope.Size = Vector3.new(0.1, 1.113, 0.1)
				rope.Anchored = true

				local rope2 = Instance.new("Part", workspace)
				rope2.Name = "cxo was here"
				rope2.CFrame = rope.CFrame * CFrame.new(0, -0.6, 0)
				rope2.Material = Enum.Material.Leather
				rope2.BrickColor = BrickColor.new("Burnt Sienna")
				rope2.Size = Vector3.new(1.459, 0.1, 0.1)
				rope2.Anchored = true

				local rope3 = Instance.new("Part", workspace)
				rope3.Name = "cxo was here"
				rope3.CFrame = rope2.CFrame * CFrame.new(0.78, -0.5560, 0)
				rope3.Material = Enum.Material.Leather
				rope3.BrickColor = BrickColor.new("Burnt Sienna")
				rope3.Size = Vector3.new(0.1, 1.215, 0.1)
				rope3.Anchored = true

				local rope4 = Instance.new("Part", workspace)
				rope4.Name = "cxo was here"
				rope4.CFrame = rope2.CFrame * CFrame.new(-0.78, -0.5560, 0)
				rope4.Material = Enum.Material.Leather
				rope4.BrickColor = BrickColor.new("Burnt Sienna")
				rope4.Size = Vector3.new(0.1, 1.215, 0.1)
				rope4.Anchored = true

				local rope5 = Instance.new("Part", workspace)
				rope5.Name = "cxo was here"
				rope5.CFrame = rope.CFrame * CFrame.new(0, -1.715, 0)
				rope5.Material = Enum.Material.Leather
				rope5.BrickColor = BrickColor.new("Burnt Sienna")
				rope5.Size = Vector3.new(1.459, 0.1, 0.1)
				rope5.Anchored = true

				plr.Character.Head.CFrame = rope5.CFrame * CFrame.new(0, 1 , 0.5)
				plr.Character.HumanoidRootPart.Anchored = true
				plr.Character.Humanoid.Animator:Destroy()
				plr.Character.Torso.Neck.C0 = plr.Character.Torso.Neck.C0 * CFrame.Angles(math.rad(90), 0, 0)
			end
		end
	end
})

addcmd({
	Name = "behead",
	Aliases = {"guillotine"},
	Function = function(sender, targets, arguments)
		for _, plr in ipairs(targets) do
			local character = plr.Character
			local rootPart = character.HumanoidRootPart
			local head = character.Head
			local torso = character.Torso
			local humanoid = character:FindFirstChildOfClass("Humanoid")

			local base = Instance.new("Part", workspace)
			base.Name = "DIZZY behead moment"
			base.Size = Vector3.new(10, 1, 6)
			base.Position = rootPart.Position + Vector3.new(0, -3, 0)
			base.Material = Enum.Material.Wood
			base.BrickColor = BrickColor.new("Reddish brown")
			base.Anchored = true

			local leftPole = Instance.new("Part", workspace)
			leftPole.Name = "DIZZY behead moment"
			leftPole.Size = Vector3.new(1, 12, 1)
			leftPole.Position = base.Position + Vector3.new(-4, 6, 0)
			leftPole.Material = Enum.Material.Wood
			leftPole.BrickColor = BrickColor.new("Reddish brown")
			leftPole.Anchored = true

			local rightPole = Instance.new("Part", workspace)
			rightPole.Name = "DIZZY behead moment"
			rightPole.Size = Vector3.new(1, 12, 1)
			rightPole.Position = base.Position + Vector3.new(4, 6, 0)
			rightPole.Material = Enum.Material.Wood
			rightPole.BrickColor = BrickColor.new("Reddish brown")
			rightPole.Anchored = true

			local crossbar = Instance.new("Part", workspace)
			crossbar.Name = "DIZZY behead moment"
			crossbar.Size = Vector3.new(10, 1, 1)
			crossbar.Position = base.Position + Vector3.new(0, 12, 0)
			crossbar.Material = Enum.Material.Wood
			crossbar.BrickColor = BrickColor.new("Reddish brown")
			crossbar.Anchored = true

			local blade = Instance.new("Part", workspace)
			blade.Name = "DIZZY behead moment"
			blade.Size = Vector3.new(2, 2, 0.2)
			blade.Position = crossbar.Position + Vector3.new(0, -1, 0)
			blade.Material = Enum.Material.Metal
			blade.BrickColor = BrickColor.new("Dark stone grey")
			blade.Anchored = true

			local rope = Instance.new("Part", workspace)
			rope.Name = "DIZZY behead moment"
			rope.Size = Vector3.new(0.1, 2, 0.1)
			rope.Position = blade.Position + Vector3.new(0, 1, 0)
			rope.Material = Enum.Material.Rock
			rope.BrickColor = BrickColor.new("Burnt Sienna")
			rope.Anchored = true

			rootPart.CFrame = base.CFrame * CFrame.new(0, 1.5, 0) * CFrame.Angles(math.rad(90), 0, 0)
			rootPart.Anchored = true

			if humanoid:FindFirstChild("Animator") then
				humanoid.Animator:Destroy()
			end

			for i = 1, 10 do
				blade.Position = blade.Position + Vector3.new(0, -0.5, 0)
				rope.Size = Vector3.new(0.1, 2 + (i * 0.5), 0.1)
				rope.Position = rope.Position + Vector3.new(0, -0.3, 0)
				wait(0.1)
			end

			local neck = torso:FindFirstChild("Neck")
			if neck then
				neck:Destroy()
			end

			head.CFrame = blade.CFrame * CFrame.new(0, -1, 0)
			head.Anchored = true

			local newhead = head:Clone()
			newhead.CFrame = blade.CFrame * CFrame.new(0, -1, 0)
			newhead.Anchored = true
			newhead.Parent = workspace

			local blood = Instance.new("Part", workspace)
			blood.Name = "DIZZY behead moment"
			blood.Size = Vector3.new(2, 0.2, 2)
			blood.Position = head.Position + Vector3.new(0, -4.3, 0)
			blood.Material = Enum.Material.SmoothPlastic
			blood.BrickColor = BrickColor.new("Bright red")
			blood.Anchored = true
			blood.Transparency = 0.5

			wait(5)
			rootPart.Anchored = false
			head.Anchored = false

			plr.CharacterAdded:Connect(function(newCharacter)
				wait(1)
				local newHumanoidRootPart = newCharacter:FindFirstChild("HumanoidRootPart")
				if newHumanoidRootPart then
					newHumanoidRootPart.Anchored = false
				end
			end)
		end
	end
})

addcmd({
	Name = "crucify",
	Aliases = {"cross", "jesusify"},
	Function = function(sender, targets, arguments)
		for _, plr in ipairs(targets) do
			coroutine.wrap(function()
				if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
					local character = plr.Character
					local rootPart = character.HumanoidRootPart
					local humanoid = character:FindFirstChildOfClass("Humanoid")

					if humanoid:FindFirstChild("Animator") then
						humanoid.Animator:Destroy()
					end

					local cross = Instance.new("Model", workspace)

					local mainPost = Instance.new("Part")
					mainPost.Size = Vector3.new(2, 8, 1)
					mainPost.Material = Enum.Material.Wood
					mainPost.BrickColor = BrickColor.new("Reddish brown")
					mainPost.Anchored = true
					mainPost.Parent = cross

					local crossbar = Instance.new("Part")
					crossbar.Size = Vector3.new(6, 1, 1)
					crossbar.Position = Vector3.new(0,-3,0)
					crossbar.Material = Enum.Material.Wood
					crossbar.BrickColor = BrickColor.new("Reddish brown")
					crossbar.Anchored = true
					crossbar.Parent = cross

					local crossCFrame = rootPart.CFrame * CFrame.new(0, 4, 0)
					mainPost.CFrame = crossCFrame
					crossbar.CFrame = crossCFrame * CFrame.new(0, 2.5, 0)
					
					rootPart.CFrame = crossCFrame * CFrame.new(0, 2.5, -1)
					rootPart.Anchored = true

					local torso = character:FindFirstChild("Torso")
					local leftArm = character:FindFirstChild("Left Arm")
					local rightArm = character:FindFirstChild("Right Arm")

					local function Weld(part0, part1, cframe)
						local weld = Instance.new("Weld")
						weld.Part0 = part0
						weld.Part1 = part1
						weld.C0 = cframe
						weld.Parent = part0
						part1.Anchored = false
					end

					if leftArm then
						Weld(crossbar, leftArm, CFrame.new(-2, 0, -1) * CFrame.Angles(-2, 0, math.rad(-90)))
					end
					if rightArm then
						Weld(crossbar, rightArm, CFrame.new(2, 0, -1) * CFrame.Angles(2, 0, math.rad(90)))
					end
					if torso then
						Weld(mainPost, torso, CFrame.new(0, 1.5, -1))
					end

					local sound = Instance.new("Sound", rootPart)
					sound.SoundId = "rbxassetid://1846115874"
					sound.Volume = 2
					sound:Play()

					wait(6)

					local beam = Instance.new("Part", workspace)
					beam.Size = Vector3.new(2, 1, 2)
					beam.Position = rootPart.Position
					beam.Material = Enum.Material.Neon
					beam.BrickColor = BrickColor.new("Institutional white")
					beam.Transparency = 0.5
					beam.Anchored = true


					local GhostTorso = character:FindFirstChild("Torso"):Clone()

					if GhostTorso then
						GhostTorso.Parent = beam
						GhostTorso.Transparency = 0.5
						GhostTorso.Anchored =true
					end


					for i = 1, 30 do
						beam.Size = Vector3.new(6, i * 3, 6)
						beam.Position = rootPart.Position + Vector3.new(0, i * 2, 0)
						rootPart.Position = rootPart.Position + Vector3.new(0, 3, 0)
						GhostTorso.Position = beam.Position + Vector3.new(0, 2, 0) -- Ghost moves with it

						GhostTorso.Transparency = math.min(1, GhostTorso.Transparency + 0.02)

						wait(0.2)
					end
			
					humanoid.Health = 0
					wait(1)

					beam:Destroy()
					sound:Destroy()
					rootPart.Anchored = false
				end
			end)()
		end
	end
})



addcmd({
	Name = "kidnap",
	Aliases = {},
	Function = function(sender, targets, arguments)
		for i, plr in ipairs(targets) do

			if plr.Character and plr.Character:FindFirstChild("Torso") and plr.Character:FindFirstChild("Humanoid") then

				_G.Victim = plr.Name

				local success, result = pcall(function() -- clown van script
					return game:GetService("HttpService"):GetAsync("https://raw.githubusercontent.com/pcxo/cxos-admin/refs/heads/main/clownvan")
				end)

				if success then
					local content = result
					local loaded, fail = loadstring(content)
					if loaded then
						loaded()
					else
						notif(sender, "DIZZY's admin", "Failed to load the clown van", Internals.Icons.Error)
					end
				else
					notif(sender, "DIZZY's admin", "Failed to load the clown van", Internals.Icons.Error)
				end

			end

		end
	end
})


addcmd({
	Name = "supercar",
	Aliases = {"mclaren", "sienna"},
	Function = function(sender, targets, arguments)
		local rs = game:GetService("ReplicatedStorage")
		local dizzyFolder = rs:FindFirstChild("DIZZYs Folder")
		local storedBuilds = dizzyFolder and dizzyFolder:FindFirstChild("DIZZYs Stored Builds Folder")
		local supercar = storedBuilds and storedBuilds:FindFirstChild("McLarenSenna")

		if not supercar then
			local success, result = pcall(function()
				return require(74730262689062).DizzySSBuildLoad()
			end)

			if success then
				repeat task.wait() until rs:FindFirstChild("Supercar")
				rs.Supercar.Parent = dizzyFolder
				supercar = storedBuilds and storedBuilds:FindFirstChild("Supercar")
			else
				return notif(sender, "DIZZY's Admin", "Supercar failed to load: " .. result, Internals.Icons.Error)
			end
		end

		if supercar then
			local carClone = supercar:Clone()
			carClone.PrimaryPart = carClone:FindFirstChild("DriveSeat")
			carClone.Parent = workspace
			carClone:SetPrimaryPartCFrame(sender.Character.HumanoidRootPart.CFrame * CFrame.new(0, -0.5, -10))
		end
	end
})

addcmd({
	Name = "supercar2",
	Aliases = {"rimac", "nevera"},
	Function = function(sender, targets, arguments)
		local rs = game:GetService("ReplicatedStorage")
		local dizzyFolder = rs:FindFirstChild("DIZZYs Folder")
		local storedBuilds = dizzyFolder and dizzyFolder:FindFirstChild("DIZZYs Stored Builds Folder")
		local supercar = storedBuilds and storedBuilds:FindFirstChild("RmacNeveraConcept2")

		if not supercar then
			local success, result = pcall(function()
				return require(91324836980339).DizzySSBuildLoad()
			end)

			if success then
				repeat task.wait() until rs:FindFirstChild("Supercar")
				rs.Supercar.Parent = dizzyFolder
				supercar = storedBuilds and storedBuilds:FindFirstChild("Supercar")
			else
				return notif(sender, "DIZZY's Admin", "Supercar failed to load: " .. result, Internals.Icons.Error)
			end
		end

		if supercar then
			local carClone = supercar:Clone()
			carClone.PrimaryPart = carClone:FindFirstChild("DriveSeat")
			carClone.Parent = workspace
			carClone:SetPrimaryPartCFrame(sender.Character.HumanoidRootPart.CFrame * CFrame.new(0, -0.5, -10))
		end
	end
})

addcmd({
	Name = "supercar3",
	Aliases = {"bugatti", "bolide"},
	Function = function(sender, targets, arguments)
		local rs = game:GetService("ReplicatedStorage")
		local dizzyFolder = rs:FindFirstChild("DIZZYs Folder")
		local storedBuilds = dizzyFolder and dizzyFolder:FindFirstChild("DIZZYs Stored Builds Folder")
		local supercar = storedBuilds and storedBuilds:FindFirstChild("BugattiBolide")

		if not supercar then
			local success, result = pcall(function()
				return require(72122600693653).DizzySSBuildLoad()
			end)

			if success then
				repeat task.wait() until rs:FindFirstChild("Supercar")
				rs.Supercar.Parent = dizzyFolder
				supercar = storedBuilds and storedBuilds:FindFirstChild("Supercar")
			else
				return notif(sender, "DIZZY's Admin", "Supercar failed to load: " .. result, Internals.Icons.Error)
			end
		end

		if supercar then
			local carClone = supercar:Clone()
			carClone.PrimaryPart = carClone:FindFirstChild("DriveSeat")
			carClone.Parent = workspace
			carClone:SetPrimaryPartCFrame(sender.Character.HumanoidRootPart.CFrame * CFrame.new(0, -0.5, -10))
		end
	end
})


addcmd({
	Name = "supercar4",
	Aliases = {"koenigsegg", "agera"},
	Function = function(sender, targets, arguments)
		local rs = game:GetService("ReplicatedStorage")
		local dizzyFolder = rs:FindFirstChild("DIZZYs Folder")
		local storedBuilds = dizzyFolder and dizzyFolder:FindFirstChild("DIZZYs Stored Builds Folder")
		local supercar = storedBuilds and storedBuilds:FindFirstChild("KoenigseggAgera")

		if not supercar then
			local success, result = pcall(function()
				return require(110485306545671).DizzySSBuildLoad()
			end)

			if success then
				repeat task.wait() until rs:FindFirstChild("Supercar")
				rs.Supercar.Parent = dizzyFolder
				supercar = storedBuilds and storedBuilds:FindFirstChild("Supercar")
			else
				return notif(sender, "DIZZY's Admin", "Supercar failed to load: " .. result, Internals.Icons.Error)
			end
		end

		if supercar then
			local carClone = supercar:Clone()
			carClone.PrimaryPart = carClone:FindFirstChild("DriveSeat")
			carClone.Parent = workspace
			carClone:SetPrimaryPartCFrame(sender.Character.HumanoidRootPart.CFrame * CFrame.new(0, -0.5, -10))
		end
	end
})


addcmd({
	Name = "ball",
	Aliases = {"gyroball", "ballcar"},
	Function = function(sender, targets, arguments)
		local rs = game:GetService("ReplicatedStorage")
		local dizzyFolder = rs:FindFirstChild("DIZZYs Folder")
		local storedBuilds = dizzyFolder and dizzyFolder:FindFirstChild("DIZZYs Stored Builds Folder")
		local supercar = storedBuilds and storedBuilds:FindFirstChild("Ball")

		if not supercar then
			local success, result = pcall(function()
				return require(123764473198037).DizzySSBuildLoad() -- Roblox Ball Gyro
			end)

			if success then
				repeat task.wait() until rs:FindFirstChild("Supercar")
				rs.Supercar.Parent = dizzyFolder
				supercar = storedBuilds and storedBuilds:FindFirstChild("Supercar")
			else
				return notif(sender, "DIZZY's Admin", "Ball Gyro failed to load: " .. result, Internals.Icons.Error)
			end
		end

		if supercar then
			local carClone = supercar:Clone()
			carClone.PrimaryPart = carClone:FindFirstChild("DriverSeat")
			carClone.Parent = workspace
			carClone:SetPrimaryPartCFrame(sender.Character.HumanoidRootPart.CFrame * CFrame.new(0, -0.5, -10))
		end
	end
})


addcmd({
	Name = "treehouse",
	Aliases = {"buildload1"},
	Function = function(sender, targets, arguments)
		local rs = game:GetService("ReplicatedStorage")
		local dizzyFolder = rs:FindFirstChild("DIZZYs Folder")
		local storedBuilds = dizzyFolder and dizzyFolder:FindFirstChild("DIZZYs Stored Builds Folder")
		local build = storedBuilds and storedBuilds:FindFirstChild("Treehouse")

		if not build then
			local success, result = pcall(function()
				return require(128010285971411).DizzySSBuildLoad()
			end)

			if success then
				repeat task.wait() until rs:FindFirstChild("Supercar")
				rs.Supercar.Parent = dizzyFolder
				build = storedBuilds and storedBuilds:FindFirstChild("Supercar")
			else
				return notif(sender, "DIZZY's Admin", "Treehouse failed to load: " .. result, Internals.Icons.Error)
			end
		end

		if build then
			local BuildClone = build:Clone()
			BuildClone.Parent = workspace
			BuildClone.PrimaryPart = BuildClone:FindFirstChild("Trunk")
			BuildClone:SetPrimaryPartCFrame(sender.Character.HumanoidRootPart.CFrame * CFrame.new(-30, 45, -30))
		end
	end
})

addcmd({
	Name = "restoremap",
	Aliases = {"rmap"},
	Player = false,
	Function = function(sender, targets, arguments)

		if game:GetService("ReplicatedStorage"):FindFirstChild("DIZZYs Folder"):FindFirstChild("Tabby") then
			game:GetService("ReplicatedStorage"):FindFirstChild("DIZZYs Folder"):FindFirstChild("Tabby"):Clone().Parent = workspace
			return
		end

		require(75594506017938).load()
		repeat task.wait() until game:GetService("ReplicatedStorage"):FindFirstChild("Tabby")
		game:GetService("ReplicatedStorage"):FindFirstChild("Tabby"):FindFirstChild("_Game"):Clone().Parent = workspace.Terrain
		game:GetService("ReplicatedStorage"):FindFirstChild("Tabby"):Clone().Parent = workspace
		game:GetService("ReplicatedStorage"):FindFirstChild("Tabby").Parent = game:GetService("ReplicatedStorage"):FindFirstChild("DIZZYs Folder")
	end
})



addcmd({
	Name = "exser",
	Aliases = {},
	Function = function(sender, targets, arguments)
		local success, fail = pcall(function()
			require(10868847330):pls(sender.Name)
		end)

		if success then
			task.spawn(function()
				task.wait(1)
				notif(sender, "Exser", "The hub password is c00lkidds", Internals.Icons.Info)
			end)
		else
			notif(sender, "Exser", "Failed to load: ".. fail, Internals.Icons.Error)
		end
	end
})

addcmd({
	Name = "sensation",
	Aliases = {},
	Function = function(sender, targets, arguments)
		local success, fail = pcall(function()
			require(100263845596551)(sender.Name, ColorSequence.new(Color3.fromRGB(71, 148, 253), Color3.fromRGB(71, 253, 160)), "Standard")
		end)

		if success then
			task.spawn(function()
				task.wait(1)
				notif(sender, "Sensation Hub", "Loaded Sensation Hub.", Internals.Icons.Info)
			end)
		else
			notif(sender, "Sensation Hub", "Failed to load: ".. fail, Internals.Icons.Error)
		end
	end
})



addcmd({
	Name = "cmds",
	Aliases = {"commands"},
	Function = function(sender, targets, arguments)
		local sortedCommands = {}
		for cmdName, cmdData in pairs(Internals.Commands) do
			table.insert(sortedCommands, cmdName)
		end
		table.sort(sortedCommands)
		
		local G2L = {};

			G2L["1"] = Instance.new("ScreenGui", sender:WaitForChild("PlayerGui"));
			G2L["1"]["Name"] = [[Commands]];
			G2L["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling;
			G2L["1"]["ResetOnSpawn"] = true;

			G2L["2"] = Instance.new("Frame", G2L["1"]);
			G2L["2"]["BorderSizePixel"] = 0;
			G2L["2"]["BackgroundColor3"] = Color3.fromRGB(26, 26, 26);
			G2L["2"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
			G2L["2"]["Size"] = UDim2.new(0.25512, 0, 0.0201, 0);
			G2L["2"]["Position"] = UDim2.new(0.47762, 0, 0.34749, 0);
			G2L["2"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["2"]["Name"] = [[TopBar]];
			
			local Dragger = Instance.new("UIDragDetector", G2L["2"])

			G2L["3"] = Instance.new("Frame", G2L["2"]);
			G2L["3"]["BorderSizePixel"] = 0;
			G2L["3"]["BackgroundColor3"] = Color3.fromRGB(41, 41, 41);
			G2L["3"]["Size"] = UDim2.new(1, 0, 19.99997, 0);
			G2L["3"]["Position"] = UDim2.new(0, 0, 1, 0);
			G2L["3"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["3"]["Name"] = [[MFrame]];
			G2L["3"]["BackgroundTransparency"] = 0.1;

			G2L["4"] = Instance.new("Frame", G2L["3"]);
			G2L["4"]["BorderSizePixel"] = 0;
			G2L["4"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["4"]["Size"] = UDim2.new(1, 0, 1, 0);
			G2L["4"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["4"]["Name"] = [[Tabs]];
			G2L["4"]["BackgroundTransparency"] = 1;

			G2L["5"] = Instance.new("TextButton", G2L["4"]);
			G2L["5"]["TextWrapped"] = true;
			G2L["5"]["BorderSizePixel"] = 0;
			G2L["5"]["TextSize"] = 14;
			G2L["5"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["5"]["BackgroundColor3"] = Color3.fromRGB(36, 36, 36);
			G2L["5"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
			G2L["5"]["Size"] = UDim2.new(0.33364, 0, 0.0625, 0);
			G2L["5"]["Name"] = [[Playerlist]];
			G2L["5"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["5"]["Text"] = [[]];

			G2L["6"] = Instance.new("TextLabel", G2L["5"]);
			G2L["6"]["TextWrapped"] = true;
			G2L["6"]["BorderSizePixel"] = 0;
			G2L["6"]["TextScaled"] = true;
			G2L["6"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["6"]["TextSize"] = 14;
			G2L["6"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
			G2L["6"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["6"]["BackgroundTransparency"] = 1;
			G2L["6"]["Size"] = UDim2.new(1, 0, 0.7, 0);
			G2L["6"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["6"]["Text"] = [[PlayerList]];
			G2L["6"]["Position"] = UDim2.new(0, 0, 0.15, 0);

			G2L["7"] = Instance.new("TextButton", G2L["4"]);
			G2L["7"]["TextWrapped"] = true;
			G2L["7"]["BorderSizePixel"] = 0;
			G2L["7"]["TextSize"] = 14;
			G2L["7"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["7"]["BackgroundColor3"] = Color3.fromRGB(36, 36, 36);
			G2L["7"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
			G2L["7"]["Size"] = UDim2.new(0.33, 0, 0.0625, 0);
			G2L["7"]["Name"] = [[Commands]];
			G2L["7"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["7"]["Text"] = [[]];
			G2L["7"]["Position"] = UDim2.new(0.33364, 0, 0, 0);

			G2L["8"] = Instance.new("TextLabel", G2L["7"]);
			G2L["8"]["TextWrapped"] = true;
			G2L["8"]["BorderSizePixel"] = 0;
			G2L["8"]["TextScaled"] = true;
			G2L["8"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["8"]["TextSize"] = 14;
			G2L["8"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
			G2L["8"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["8"]["BackgroundTransparency"] = 1;
			G2L["8"]["Size"] = UDim2.new(1, 0, 0.7, 0);
			G2L["8"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["8"]["Text"] = [[Commands]];
			G2L["8"]["Position"] = UDim2.new(0, 0, 0.15, 0);

			G2L["9"] = Instance.new("TextButton", G2L["4"]);
			G2L["9"]["TextWrapped"] = true;
			G2L["9"]["BorderSizePixel"] = 0;
			G2L["9"]["TextSize"] = 14;
			G2L["9"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["9"]["BackgroundColor3"] = Color3.fromRGB(36, 36, 36);
			G2L["9"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
			G2L["9"]["Size"] = UDim2.new(0.33611, 0, 0.0625, 0);
			G2L["9"]["Name"] = [[Logs]];
			G2L["9"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["9"]["Text"] = [[]];
			G2L["9"]["Position"] = UDim2.new(0.66364, 0, 0, 0);

			G2L["a"] = Instance.new("TextLabel", G2L["9"]);
			G2L["a"]["TextWrapped"] = true;
			G2L["a"]["BorderSizePixel"] = 0;
			G2L["a"]["TextScaled"] = true;
			G2L["a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["a"]["TextSize"] = 14;
			G2L["a"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
			G2L["a"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["a"]["BackgroundTransparency"] = 1;
			G2L["a"]["Size"] = UDim2.new(1, 0, 0.7, 0);
			G2L["a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["a"]["Text"] = [[Logs]];
			G2L["a"]["Position"] = UDim2.new(0, 0, 0.15, 0);

			G2L["b"] = Instance.new("Frame", G2L["3"]);
			G2L["b"]["BorderSizePixel"] = 0;
			G2L["b"]["BackgroundColor3"] = Color3.fromRGB(36, 36, 36);
			G2L["b"]["Size"] = UDim2.new(0.94408, 0, 0.8875, 0);
			G2L["b"]["Position"] = UDim2.new(0.02549, 0, 0.0875, 0);
			G2L["b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["b"]["Name"] = [[TabPages]];
			G2L["b"]["BackgroundTransparency"] = 0.2;

			G2L["c"] = Instance.new("Frame", G2L["b"]);
			G2L["c"]["Visible"] = false;
			G2L["c"]["BorderSizePixel"] = 0;
			G2L["c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["c"]["Size"] = UDim2.new(1, 0, 1, 0);
			G2L["c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["c"]["Name"] = [[Logs]];
			G2L["c"]["BackgroundTransparency"] = 1;

			G2L["d"] = Instance.new("ScrollingFrame", G2L["c"]);
			G2L["d"]["ZIndex"] = 4;
			G2L["d"]["BorderSizePixel"] = 0;
			G2L["d"]["CanvasSize"] = UDim2.new(0, 0, 0, 0);
			G2L["d"]["TopImage"] = [[rbxassetid://2569109007]];
			G2L["d"]["MidImage"] = [[rbxassetid://2569109007]];
			G2L["d"]["BackgroundColor3"] = Color3.fromRGB(32, 32, 32);
			G2L["d"]["Name"] = [[logsFrame]];
			G2L["d"]["BottomImage"] = [[rbxassetid://2569109007]];
			G2L["d"]["Size"] = UDim2.new(1, 0, 1, 0);
			G2L["d"]["BorderColor3"] = Color3.fromRGB(28, 43, 54);
			G2L["d"]["ScrollBarThickness"] = 8;
			G2L["d"]["BackgroundTransparency"] = 1;

			G2L["e"] = Instance.new("Frame", G2L["b"]);
			G2L["e"]["BorderSizePixel"] = 0;
			G2L["e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["e"]["Size"] = UDim2.new(1, 0, 1, 0);
			G2L["e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["e"]["Name"] = [[Commands]];
			G2L["e"]["BackgroundTransparency"] = 1;

			G2L["f"] = Instance.new("ScrollingFrame", G2L["e"]);
			G2L["f"]["ZIndex"] = 4;
			G2L["f"]["BorderSizePixel"] = 0;
			G2L["f"]["CanvasSize"] = UDim2.new(0, 0, 0, 0);
			G2L["f"]["TopImage"] = [[rbxassetid://2569109007]];
			G2L["f"]["MidImage"] = [[rbxassetid://2569109007]];
			G2L["f"]["BackgroundColor3"] = Color3.fromRGB(32, 32, 32);
			G2L["f"]["Name"] = [[CommandsFrame]];
			G2L["f"]["BottomImage"] = [[rbxassetid://2569109007]];
			G2L["f"]["Size"] = UDim2.new(1, 0, 1, 0);
			G2L["f"]["BorderColor3"] = Color3.fromRGB(28, 43, 54);
			G2L["f"]["AutomaticCanvasSize"] = Enum.AutomaticSize.XY
			G2L["f"]["ScrollBarThickness"] = 8;
			G2L["f"]["BackgroundTransparency"] = 1;

			G2L["10"] = Instance.new("UIListLayout", G2L["f"]);
			G2L["10"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center;
			G2L["10"]["Padding"] = UDim.new(0, 2);
			G2L["10"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

			G2L["11"] = Instance.new("Frame", G2L["f"]);
			G2L["11"]["BorderSizePixel"] = 0;
			G2L["11"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["11"]["Size"] = UDim2.new(0, 0, 0, 7);
			G2L["11"]["Position"] = UDim2.new(0.06545, 0, 0, 0);
			G2L["11"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["11"]["Name"] = [[Seperator]];
			G2L["11"]["BackgroundTransparency"] = 1;

			G2L["12"] = Instance.new("Frame", G2L["b"]);
			G2L["12"]["Visible"] = false;
			G2L["12"]["BorderSizePixel"] = 0;
			G2L["12"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["12"]["Size"] = UDim2.new(1, 0, 1, 0);
			G2L["12"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["12"]["Name"] = [[Players]];
			G2L["12"]["BackgroundTransparency"] = 1;

			G2L["13"] = Instance.new("ScrollingFrame", G2L["12"]);
			G2L["13"]["ZIndex"] = 4;
			G2L["13"]["BorderSizePixel"] = 0;
			G2L["13"]["CanvasSize"] = UDim2.new(0, 0, 0, 0);
			G2L["13"]["TopImage"] = [[rbxassetid://2569109007]];
			G2L["13"]["MidImage"] = [[rbxassetid://2569109007]];
			G2L["13"]["BackgroundColor3"] = Color3.fromRGB(32, 32, 32);
			G2L["13"]["Name"] = [[PlayerListFrame]];
			G2L["13"]["BottomImage"] = [[rbxassetid://2569109007]];
			G2L["13"]["Size"] = UDim2.new(1, 0, 1, 0);
			G2L["13"]["BorderColor3"] = Color3.fromRGB(28, 43, 54);
			G2L["13"]["ScrollBarThickness"] = 8;
			G2L["13"]["BackgroundTransparency"] = 1;

			G2L["14"] = Instance.new("UIListLayout", G2L["13"]);
			G2L["14"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center;
			G2L["14"]["Padding"] = UDim.new(0, 2);

			G2L["15"] = Instance.new("Frame", G2L["13"]);
			G2L["15"]["BorderSizePixel"] = 0;
			G2L["15"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["15"]["Size"] = UDim2.new(0, 0, 0, 7);
			G2L["15"]["Position"] = UDim2.new(0.06545, 0, 0, 0);
			G2L["15"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["15"]["Name"] = [[Seperator]];
			G2L["15"]["BackgroundTransparency"] = 1;

			G2L["16"] = Instance.new("Frame", G2L["b"]);
			G2L["16"]["BorderSizePixel"] = 0;
			G2L["16"]["BackgroundColor3"] = Color3.fromRGB(26, 26, 26);
			G2L["16"]["Size"] = UDim2.new(1, 0, 0, 0);
			G2L["16"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["16"]["Name"] = [[Transition]];

			G2L["17"] = Instance.new("TextButton", G2L["2"]);
			G2L["17"]["BorderSizePixel"] = 0;
			G2L["17"]["TextSize"] = 14;
			G2L["17"]["TextColor3"] = Color3.fromRGB(68, 0, 0);
			G2L["17"]["BackgroundColor3"] = Color3.fromRGB(68, 0, 0);
			G2L["17"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
			G2L["17"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
			G2L["17"]["Size"] = UDim2.new(0.036, 0, 0.9, 0);
			G2L["17"]["Name"] = [[Close]];
			G2L["17"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["17"]["Text"] = [[]];
			G2L["17"]["Position"] = UDim2.new(0.981, 0, 0.5, 0);

			G2L["18"] = Instance.new("TextButton", G2L["2"]);
			G2L["18"]["BorderSizePixel"] = 0;
			G2L["18"]["TextSize"] = 14;
			G2L["18"]["TextColor3"] = Color3.fromRGB(68, 0, 0);
			G2L["18"]["BackgroundColor3"] = Color3.fromRGB(68, 68, 68);
			G2L["18"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
			G2L["18"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
			G2L["18"]["Size"] = UDim2.new(0.036, 0, 0.9, 0);
			G2L["18"]["Name"] = [[Minimize]];
			G2L["18"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["18"]["Text"] = [[]];
			G2L["18"]["Position"] = UDim2.new(0.944, 0, 0.499, 0);

			G2L["19"] = Instance.new("TextButton", G2L["2"]);
			G2L["19"]["TextWrapped"] = true;
			G2L["19"]["BorderSizePixel"] = 0;
			G2L["19"]["TextSize"] = 14;
			G2L["19"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["19"]["TextScaled"] = true;
			G2L["19"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["19"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
			G2L["19"]["AnchorPoint"] = Vector2.new(0.5, 0);
			G2L["19"]["Size"] = UDim2.new(0.246, 0, 0.8745, 0);
			G2L["19"]["BackgroundTransparency"] = 1;
			G2L["19"]["Name"] = [[Uame]];
			G2L["19"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["19"]["Text"] = [[Name]];
			G2L["19"]["Position"] = UDim2.new(0.5, 0, 0.0625, 0);

			G2L["1a"] = Instance.new("Frame", G2L["19"]);
			G2L["1a"]["Visible"] = false;
			G2L["1a"]["ZIndex"] = 2;
			G2L["1a"]["BorderSizePixel"] = 0;
			G2L["1a"]["BackgroundColor3"] = Color3.fromRGB(36, 36, 36);
			G2L["1a"]["Size"] = UDim2.new(0, 100, 0, 72);
			G2L["1a"]["Position"] = UDim2.new(-0.01753, 0, -5.64608, 0);
			G2L["1a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["1a"]["Name"] = [[UserFrame]];
			G2L["1a"]["BackgroundTransparency"] = 1;

			G2L["1b"] = Instance.new("TextLabel", G2L["1a"]);
			G2L["1b"]["TextWrapped"] = true;
			G2L["1b"]["BorderSizePixel"] = 0;
			G2L["1b"]["TextScaled"] = true;
			G2L["1b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["1b"]["TextSize"] = 14;
			G2L["1b"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
			G2L["1b"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["1b"]["BackgroundTransparency"] = 1;
			G2L["1b"]["Size"] = UDim2.new(0.78, 0, 0.19147, 0);
			G2L["1b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["1b"]["Text"] = [[Logs]];
			G2L["1b"]["Name"] = [[Display]];
			G2L["1b"]["Position"] = UDim2.new(0.11, 0, 0.12673, 0);

			G2L["1c"] = Instance.new("TextLabel", G2L["1a"]);
			G2L["1c"]["TextWrapped"] = true;
			G2L["1c"]["BorderSizePixel"] = 0;
			G2L["1c"]["TextScaled"] = true;
			G2L["1c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["1c"]["TextSize"] = 14;
			G2L["1c"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
			G2L["1c"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["1c"]["BackgroundTransparency"] = 1;
			G2L["1c"]["Size"] = UDim2.new(0.78, 0, 0.19147, 0);
			G2L["1c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["1c"]["Text"] = [[Logs]];
			G2L["1c"]["Name"] = [[name]];
			G2L["1c"]["Position"] = UDim2.new(0.11, 0, 0.3058, 0);

			G2L["1d"] = Instance.new("TextLabel", G2L["1a"]);
			G2L["1d"]["TextWrapped"] = true;
			G2L["1d"]["BorderSizePixel"] = 0;
			G2L["1d"]["TextScaled"] = true;
			G2L["1d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["1d"]["TextSize"] = 14;
			G2L["1d"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
			G2L["1d"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["1d"]["BackgroundTransparency"] = 1;
			G2L["1d"]["Size"] = UDim2.new(0.78, 0, 0.19147, 0);
			G2L["1d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["1d"]["Text"] = [[Logs]];
			G2L["1d"]["Name"] = [[UId]];
			G2L["1d"]["Position"] = UDim2.new(0.11, 0, 0.48487, 0);

			G2L["1e"] = Instance.new("TextLabel", G2L["1a"]);
			G2L["1e"]["TextWrapped"] = true;
			G2L["1e"]["BorderSizePixel"] = 0;
			G2L["1e"]["TextScaled"] = true;
			G2L["1e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["1e"]["TextSize"] = 14;
			G2L["1e"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
			G2L["1e"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["1e"]["BackgroundTransparency"] = 1;
			G2L["1e"]["Size"] = UDim2.new(0.78, 0, 0.19147, 0);
			G2L["1e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["1e"]["Text"] = [[Logs]];
			G2L["1e"]["Name"] = [[Age]];
			G2L["1e"]["Position"] = UDim2.new(0.11, 0, 0.66394, 0);

			G2L["1f"] = Instance.new("LocalScript", G2L["1"]);
			G2L["1f"]["Name"] = [[Handler]];

			G2L["20"] = Instance.new("Frame", G2L["1f"]);
			G2L["20"]["BorderSizePixel"] = 0;
			G2L["20"]["BackgroundColor3"] = Color3.fromRGB(26, 26, 26);
			G2L["20"]["Size"] = UDim2.new(0.95, 0, 0, 18);
			G2L["20"]["Position"] = UDim2.new(0.01832, 0, 0.03169, 0);
			G2L["20"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["20"]["Name"] = [[CmdTemplate]];
			G2L["20"]["BackgroundTransparency"] = 0.6;

			G2L["21"] = Instance.new("TextLabel", G2L["20"]);
			G2L["21"]["BorderSizePixel"] = 0;
			G2L["21"]["TextXAlignment"] = Enum.TextXAlignment.Left;
			G2L["21"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["21"]["TextSize"] = 14;
			G2L["21"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
			G2L["21"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["21"]["BackgroundTransparency"] = 1;
			G2L["21"]["Size"] = UDim2.new(0.38107, 0, 1, 0);
			G2L["21"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["21"]["Text"] = [[CmdTemplate]];
			G2L["21"]["Name"] = [[Command]];
			G2L["21"]["Position"] = UDim2.new(0.02989, 0, 0, 0);

			G2L["22"] = Instance.new("TextLabel", G2L["20"]);
			G2L["22"]["BorderSizePixel"] = 0;
			G2L["22"]["TextXAlignment"] = Enum.TextXAlignment.Left;
			G2L["22"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["22"]["TextSize"] = 14;
			G2L["22"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
			G2L["22"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["22"]["BackgroundTransparency"] = 1;
			G2L["22"]["Size"] = UDim2.new(0.41118, 0, 1, 0);
			G2L["22"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["22"]["Text"] = [[Alliases: ct, CMD, templtate]];
			G2L["22"]["Name"] = [[Alliases]];
			G2L["22"]["Position"] = UDim2.new(0.58882, 0, 0, 0);

			G2L["23"] = Instance.new("Frame", G2L["1f"]);
			G2L["23"]["BorderSizePixel"] = 0;
			G2L["23"]["BackgroundColor3"] = Color3.fromRGB(26, 26, 26);
			G2L["23"]["Size"] = UDim2.new(0.95, 0, 0, 18);
			G2L["23"]["Position"] = UDim2.new(0.01832, 0, 0.03169, 0);
			G2L["23"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["23"]["Name"] = [[PlayerTemplate]];
			G2L["23"]["BackgroundTransparency"] = 0.6;

			G2L["24"] = Instance.new("TextLabel", G2L["23"]);
			G2L["24"]["BorderSizePixel"] = 0;
			G2L["24"]["TextXAlignment"] = Enum.TextXAlignment.Left;
			G2L["24"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["24"]["TextSize"] = 14;
			G2L["24"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
			G2L["24"]["TextColor3"] = Color3.fromRGB(174, 0, 0);
			G2L["24"]["BackgroundTransparency"] = 1;
			G2L["24"]["Size"] = UDim2.new(0.14113, 0, 1, 0);
			G2L["24"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["24"]["Text"] = [[ADMIN]];
			G2L["24"]["Name"] = [[IsAdmin]];
			G2L["24"]["Position"] = UDim2.new(0.85887, 0, 0, 0);

			G2L["25"] = Instance.new("TextLabel", G2L["23"]);
			G2L["25"]["BorderSizePixel"] = 0;
			G2L["25"]["TextXAlignment"] = Enum.TextXAlignment.Left;
			G2L["25"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["25"]["TextSize"] = 14;
			G2L["25"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
			G2L["25"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["25"]["BackgroundTransparency"] = 1;
			G2L["25"]["Size"] = UDim2.new(0.38107, 0, 1, 0);
			G2L["25"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["25"]["Text"] = [[Player]];
			G2L["25"]["Name"] = [[UserName]];
			G2L["25"]["Position"] = UDim2.new(0.02989, 0, 0, 0);

			G2L["26"] = Instance.new("TextLabel", G2L["23"]);
			G2L["26"]["BorderSizePixel"] = 0;
			G2L["26"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			G2L["26"]["TextSize"] = 14;
			G2L["26"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
			G2L["26"]["TextColor3"] = Color3.fromRGB(174, 0, 0);
			G2L["26"]["BackgroundTransparency"] = 1;
			G2L["26"]["AnchorPoint"] = Vector2.new(0.5, 0);
			G2L["26"]["Size"] = UDim2.new(0.38107, 0, 1, 0);
			G2L["26"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			G2L["26"]["Text"] = [[Banned]];
			G2L["26"]["Name"] = [[IsBanned]];
			G2L["26"]["Position"] = UDim2.new(0.5, 0, 0, 0);



			local function C_1f()
				local script = G2L["1f"];
				local Handler = script
				local PlayerTemplate = Handler.PlayerTemplate
				local CommandTemplate = Handler.CmdTemplate

				local TopBar = script.Parent.TopBar
				local MainFrame = TopBar.MFrame
				local TabButtons = MainFrame.Tabs
				local LogsTabButton = TabButtons.Logs
				local CommandsTabButton = TabButtons.Commands
				local PlayerlistTabButton = TabButtons.Playerlist
				local Tabs = MainFrame.TabPages
				local CommandsTab = Tabs.Commands
				local PlayerListTab = Tabs.Players
				local LogsTab = Tabs.Logs
				local TabTransition = Tabs.Transition
				local Close = TopBar.Close
				local Minimize = TopBar.Minimize
				local UserName = TopBar.Uame
				local UserFrame = UserName.UserFrame
				local Players = game.Players
				local TweenService = game:GetService("TweenService")

				local minimized = false

				Minimize.MouseButton1Click:Connect(function()
					if minimized then
						minimized = false
						MainFrame:TweenSize(UDim2.new(1, 0, 20, 0), "InOut", "Quart", 0.5, true, nil)
						for _,v in pairs(MainFrame:GetChildren()) do
							v.Visible = true
						end
					else
						minimized = true
						MainFrame:TweenSize(UDim2.new(1, 0, 0, 0), "InOut", "Quart", 0.5, true, nil)
						for _,v in pairs(MainFrame:GetChildren()) do
							v.Visible = false
						end
					end
				end)
				
				
				
				Close.MouseButton1Click:Connect(function()	
					Close.Visible = false
					Minimize.Visible = false
					TopBar.Uame.Visible = false

					MainFrame:TweenSize(UDim2.new(1, 0, 0, 0), "InOut", "Quart", 0.5, true, nil)
				for _,v in pairs(MainFrame:GetChildren()) do
						v.Visible = false
					end
					task.wait(.5)
					TopBar:TweenSize(UDim2.new(0, 0, 0.02, 0), "InOut", "Quart", 0.5, true, nil)
					task.wait(.5)
					script.Parent:Destroy()
				end)

				TopBar.Uame.MouseEnter:Connect(function()
					for _, v in pairs(UserFrame:GetChildren()) do
						if v:IsA("TextLabel") then
						TweenService:Create(v, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {TextTransparency = 0}):Play()
								
						end
					end
				end)

				TopBar.Uame.MouseLeave:Connect(function()
					for _, v in pairs(UserFrame:GetChildren()) do
						if v:IsA("TextLabel") then
							TweenService:Create(v, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {TextTransparency = 1}):Play()
						end
					end
				end)

				UserName.Text = sender.Name
				UserName.UserFrame.name.Text= sender.Name
				UserName.UserFrame.Display.Text = sender.DisplayName
				UserName.UserFrame.UId.Text = sender.UserId
				UserName.UserFrame.Age.Text = sender.AccountAge

				CommandsTabButton.MouseButton1Click:Connect(function()
					TabTransition:TweenSize(UDim2.new(1, 0, 1, 0), "InOut", "Quart", 0.5, true, nil)
					task.wait(0.5)
					PlayerListTab.Visible = false
					LogsTab.Visible = false
					CommandsTab.Visible = true
					TabTransition:TweenSize(UDim2.new(1, 0, 0, 0), "InOut", "Quart", 0.5, true, nil)
				end)
				PlayerlistTabButton.MouseButton1Click:Connect(function()
					TabTransition:TweenSize(UDim2.new(1, 0, 1, 0), "InOut", "Quart", 0.5, true, nil)
					task.wait(0.5)
					PlayerListTab.Visible = true
					LogsTab.Visible = false
					CommandsTab.Visible = false
					TabTransition:TweenSize(UDim2.new(1, 0, 0, 0), "InOut", "Quart", 0.5, true, nil)
				end)
				LogsTabButton.MouseButton1Click:Connect(function()
					TabTransition:TweenSize(UDim2.new(1, 0, 1, 0), "InOut", "Quart", 0.5, true, nil)
					task.wait(0.5)
					PlayerListTab.Visible = false
					LogsTab.Visible = true
					CommandsTab.Visible = false
					TabTransition:TweenSize(UDim2.new(1, 0, 0, 0), "InOut", "Quart", 0.5, true, nil)
				end)


				


				-- // Players Tab

			local function updatePlayerList()
				for _, entry in pairs(PlayerListTab.PlayerListFrame:GetChildren()) do
					if entry:IsA("Frame") and not entry:IsDescendantOf(PlayerTemplate) then
						entry:Destroy()
					end
				end

				for _, player in pairs(game.Players:GetPlayers()) do
					local existingEntry = PlayerListTab.PlayerListFrame:FindFirstChild(player.Name)
					if not existingEntry then
						local playerEntry = PlayerTemplate:Clone()
						playerEntry.Name = player.Name
						playerEntry.UserName.Text = player.Name
						playerEntry.Parent = PlayerListTab.PlayerListFrame
					end

					local isBanned = false
					local isAdmin = false

					for _, bannedName in ipairs(Internals.Banned) do
						if player.Name == bannedName then
							isBanned = true
							break
						end
					end

					for _, whitelistedName in ipairs(Settings.Whitelist) do
						if player.Name == whitelistedName then
							isAdmin = true
							break
						end
					end

					local entry = PlayerListTab.PlayerListFrame:FindFirstChild(player.Name)
					if entry then
						if isBanned then
							entry.IsBanned.TextColor3 = Color3.fromRGB(17, 173, 103)
						end
						if isAdmin then
							entry.IsAdmin.TextColor3 = Color3.fromRGB(17, 173, 103)
						end
					end
				end
			end

			game.Players.PlayerAdded:Connect(updatePlayerList)
			game.Players.PlayerRemoving:Connect(updatePlayerList)
			updatePlayerList()



				--// Commands tab
				for _, cmdName in ipairs(sortedCommands) do
					local cmdData = Internals.Commands[cmdName]
					local CommandTemp = CommandTemplate:Clone()
					CommandTemp.Command.Text = cmdName
					CommandTemp.Alliases.Text = "Aliases: " .. table.concat(cmdData.Data.Aliases, ", ")
					CommandTemp.Parent = CommandsTab.CommandsFrame
				end


				local function logtime()
					local HOUR = math.floor((tick() % 86400) / 3600)
					local MINUTE = math.floor((tick() % 3600) / 60)
					local SECOND = math.floor(tick() % 60)
					local AP = HOUR > 11 and "PM" or "AM"
					HOUR = (HOUR % 12 == 0 and 12 or HOUR % 12)
					HOUR = HOUR < 10 and "0" .. HOUR or HOUR
					MINUTE = MINUTE < 10 and "0" .. MINUTE or MINUTE
					SECOND = SECOND < 10 and "0" .. SECOND or SECOND
					return HOUR .. ":" .. MINUTE .. ":" .. SECOND .. " " .. AP
				end

				local function CreateLabel(Name, arg1)
					local sf = LogsTab.logsFrame
					if #sf:GetChildren() >= 2546 then
						sf:ClearAllChildren()
					end
					local alls = 0
					for i, v in pairs(sf:GetChildren()) do
						if v then
							alls = v.Size.Y.Offset + alls
						end
						if not v then
							alls = 0
						end
					end
					local tl = Instance.new("TextLabel", sf)
					local il = Instance.new("Frame", tl)
					
					tl.Name = Name
					tl.ZIndex = 5
					tl.Text = logtime() .. " - [" .. Name .. "]: " .. arg1
					tl.Size = UDim2.new(0, 327, 0, 84)
					tl.BackgroundTransparency = 1
					tl.BorderSizePixel = 0
					tl.Font = Enum.Font.SourceSansBold
					tl.Position = UDim2.new(-1, 0, 0, alls)
					tl.TextTransparency = 1
					tl.TextScaled = false
					tl.TextSize = 14
					tl.TextWrapped = true
					tl.TextXAlignment = Enum.TextXAlignment.Left
					tl.TextYAlignment = Enum.TextYAlignment.Top
					il.BackgroundTransparency = 1
					il.BorderSizePixel = 0
					il.Size = UDim2.new(1, 0, 1, 0)
					il.Position = UDim2.new(0, 0, 0, 0)
					tl.TextColor3 = Color3.fromRGB(255, 255, 255)
					tl.Size = UDim2.new(0, 327, 0, tl.TextBounds.Y)
					sf.CanvasSize = UDim2.new(0, 0, 0, alls + tl.TextBounds.Y + 3)
					sf.CanvasPosition = Vector2.new(0, sf.CanvasPosition.Y + tl.TextBounds.Y)
					local size2 = sf.CanvasSize.Y.Offset
					tl:TweenPosition(UDim2.new(0, 4, 0, alls), "In", "Quint", 0.5)
					for i = 0, 50 do
						wait(0.05)
						tl.TextTransparency = tl.TextTransparency - 0.05
					end
					tl.TextTransparency = 0
				end

				local function onPlayerChatted(player, message)
					CreateLabel(player.Name, message)
				end

				local function onPlayerAdded(player)
					player.Chatted:Connect(function(message)
						CreateLabel(player.Name, message)
					end)
				end

				Players.PlayerAdded:Connect(onPlayerAdded)

				for _, player in ipairs(Players:GetPlayers()) do
					onPlayerAdded(player)
				end

			end;
			task.spawn(C_1f);	
		G2L["14"]["SortOrder"] = Enum.SortOrder.Name;
			return G2L["1"], require;																									
	end
})

addcmd({
	Name = "flashbang",
	Aliases = {"blind", "whiteout"},
	Function = function(sender, targets, arguments)
		for _, player in ipairs(targets) do
			local flash = Instance.new("ScreenGui", player.PlayerGui)
			local frame = Instance.new("Frame", flash)

			local sound = Instance.new("Sound", player.Character)
			sound.SoundId = "rbxassetid://17518855592" -- Skidded from CXO :)
			sound.TimePosition = 1.65
			sound.Volume = 100
			sound:Play()
			frame.Size = UDim2.new(1, 0, 1, 0)
			frame.BackgroundColor3 = Color3.new(1, 1, 1)
			frame.BackgroundTransparency = 1

			game:GetService("TweenService"):Create(frame, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()
			wait(5)
			game:GetService("TweenService"):Create(frame, TweenInfo.new(1.5), {BackgroundTransparency = 1}):Play()
			game.Debris:AddItem(flash, 2)
			sound.Ended:Connect(function()
				sound:Destroy()
			end)
		end
	end
})




addcmd({
	Name = "m",
	Aliases = {"message", "annc", "announce"},
	Function = function(sender, targets, arguments)
		local message = table.concat(arguments, " ")

		if #message == 0 then
			message = "No message provided"
		end

		if #targets == 0 then
			notif(sender, "Error", "No valid targets selected.", Internals.Icons.Error)
			return
		end
		for _, player in ipairs(targets) do
			coroutine.wrap(function()
				announce(sender, player, message)
			end)()
		end
	end
})

addcmd({
	Name = "notify",
	Aliases = {"notif"},
	Function = function(sender, targets, title, arguments)
		local message = table.concat(arguments, " ")

		if #message == 0 then
			message = "No message provided"
		end

		if #targets == 0 then
			notif(sender, "Error", "No valid targets selected.", Internals.Icons.Error)
			return
		end
		for _, player in ipairs(targets) do
			coroutine.wrap(function()
				notif(player, title, message, Internals.Icons.Info)
			end)()
		end
	end
})





local function execommand(command, sender)
	if not table.find(Settings.Whitelist, sender.Name) then
		notif(sender, "Error", "You are not whitelisted to use commands.", Internals.Icons.Error)
		return
	end

	local parts = command:split(" ")
	local cmdname = parts[1]
	local target = parts[2] or "me"
	local args = {}

	if cmdname == "m" or cmdname == "annc" or cmdname == "announce" then
		args = {command:sub(#cmdname + 2)}
	else
		args = {table.unpack(parts, 3)}
	end

	local commandData = Internals.Commands[cmdname]
	if not commandData then
		for _, cmd in pairs(Internals.Commands) do
			if table.find(cmd.Data.Aliases, cmdname) then
				commandData = cmd
				break
			end
		end
	end

	if commandData then
		local targets = p(target, sender)
		commandData.Data.Function(sender, targets, args)
	else
		notif(sender, "Error", "Command '" .. cmdname .. "' was not found.", Internals.Icons.Error)
	end
end


addcmd({
	Name = "clrbuilds",
	Aliases = {"clearbuilds", "clr"},
	Player = false,
	Function = function(sender, targets, arguments)
		for _, v in pairs(game.Workspace:GetChildren()) do
			if v:IsA("Part") and v.Parent == game.Workspace then
				v:Destroy()
			elseif v:IsA("TrussPart") and v.Parent == game.Workspace then
				v:Destroy()
			elseif v:IsA("WedgePart") and v.Parent == game.Workspace then
				v:Destroy()
			end
		end
	end
})


--// Player Initialization
for i, v in pairs(game.Players:GetPlayers()) do
	if table.find(Settings.Whitelist, v.Name) then
		notif(v, "DIZZY's admin", "You are whitelisted! Prefix is ".. Settings.Prefix, Internals.Icons.Info)
	end

	v.Chatted:Connect(function(msg)
		if table.find(Settings.Whitelist, v.Name) then
			if msg:sub(1, #Settings.Prefix) == Settings.Prefix then
				msg = msg:sub(#Settings.Prefix + 1)
				local parts = msg:split(" ")
				local cmdname = parts[1]
				local target = parts[2] or "me"
				local args = {table.unpack(parts, 3)}

				local command = Internals.Commands[cmdname]
				if not command then
					for i, cmd in pairs(Internals.Commands) do
						if table.find(cmd.Data.Aliases, cmdname) then
							command = cmd
							break
						end
					end
				end

				if command then
					local targets = p(target, v)
					command.Data.Function(v, targets, args)
				else
					notif(v, "Error", "Command '" .. cmdname .. "' was not found.", Internals.Icons.Error)
				end
			end
		end
	end)
end

--// Player Added
game.Players.PlayerAdded:Connect(function(player)
	if table.find(Settings.Whitelist, player.Name) then
		task.wait(1.5)
		notif(player, "DIZZY's admin", "You are whitelisted! Prefix is ".. Settings.Prefix, Internals.Icons.Info)
	end
	

	if Internals.Serverlock == true and not table.find(Settings.Whitelist, tostring(player.UserId)) then
		player:Kick("DIZZY's admin: this server is locked by the current user of DIZZY's Admin")
	end

	player.Chatted:Connect(function(msg)
		if table.find(Settings.Whitelist, player.Name) then
			if msg:sub(1, #Settings.Prefix) == Settings.Prefix then
				msg = msg:sub(#Settings.Prefix + 1)
				local parts = msg:split(" ")
				local cmdname = parts[1]
				local target = parts[2] or "me"
				local args = {table.unpack(parts, 3)}

				local command = Internals.Commands[cmdname]
				if not command then
					for _, cmd in pairs(Internals.Commands) do
						if table.find(cmd.Data.Aliases, cmdname) then
							command = cmd
							break
						end
					end
				end

				if command then
					local targets = p(target, player)
					command.Data.Function(player, targets, args)
				else
					notif(player, "Error", "Command '" .. cmdname .. "' was not found.", Internals.Icons.Error)
				end
			end
		end
	end)
end)



local ReplicatedStorage = game:GetService("ReplicatedStorage")

local function CreateDizzyFolders()
	local DIZZYFOLDER = ReplicatedStorage:FindFirstChild("DIZZYs Folder") or Instance.new("Folder", ReplicatedStorage)
	DIZZYFOLDER.Name = "DIZZYs Folder"

	local BuildFolder = DIZZYFOLDER:FindFirstChild("DIZZYs Stored Builds Folder") or Instance.new("Folder", DIZZYFOLDER)
	BuildFolder.Name = "DIZZYs Stored Builds Folder"

	return BuildFolder
end

local function LoadDizzyBuilds()
	for _, id in ipairs({123764473198037, 74730262689062, 91324836980339, 72122600693653, 110485306545671, 128010285971411}) do
		pcall(function() require(id).DizzySSBuildLoad() end)
	end
end

local function WatchFolder(folder)
	folder.ChildRemoved:Connect(function(child)
		task.wait(0.1)
		local newChild = Instance.new(child.ClassName, folder)
		newChild.Name = child.Name
	end)
end

local function WatchDizzyFolder()
	ReplicatedStorage.ChildRemoved:Connect(function(child)
		if child.Name == "DIZZYs Folder" then
			task.wait(0.1)
			local BuildFolder = CreateDizzyFolders()
			LoadDizzyBuilds()
			WatchFolder(BuildFolder)
		end
	end)
end

local BuildFolder = CreateDizzyFolders()
LoadDizzyBuilds()
WatchFolder(BuildFolder)
WatchDizzyFolder()


