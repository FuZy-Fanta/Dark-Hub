local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()

local Window = OrionLib:MakeWindow({
	Name = "FuZys Script",
	HidePremium = false,
	SaveConfig = true,
	ConfigFolder = "OrionTest"
})

-- Universal Tab
local UniversalTab = Window:MakeTab({
	Name = "Universal",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local UniversalSection = UniversalTab:AddSection({
	Name = "Auto Hoop"
})

local hoopsFolder = workspace:WaitForChild("Hoops") -- change if folder name differs
local player = game.Players.LocalPlayer
local autoHoopsRunning = false

local function bringHoopsToPlayer()
    local character = player.Character or player.CharacterAdded:Wait()
    local hrp = character:WaitForChild("HumanoidRootPart")

    while autoHoopsRunning do
        for _, hoop in pairs(hoopsFolder:GetChildren()) do
            if not autoHoopsRunning then break end
            if hoop:IsA("BasePart") then
                hoop.CFrame = hrp.CFrame * CFrame.new(0, -3, 0) -- 3 studs below player
            end
        end
        task.wait() -- minimal wait, no lag added
    end
end

UniversalSection:AddToggle({
	Name = "Auto Hoop",
	Default = false,
	Callback = function(value)
		autoHoopsRunning = value
		if value then
			spawn(bringHoopsToPlayer)
		end
	end
})

-- Rebirth Section
local RebirthSection = UniversalTab:AddSection({
	Name = "AutoRebirth"
})

local rebirthing = false
local targetRebirth = 0

RebirthSection:AddTextbox({
	Name = "Rebirth Target",
	Default = "0",
	TextDisappear = false,
	Callback = function(Value)
		local num = tonumber(Value)
		if num and num >= 0 then
			targetRebirth = num
			print("Rebirth target set to: " .. targetRebirth)
		else
			warn("Invalid rebirth target")
		end
	end
})

RebirthSection:AddToggle({
	Name = "Auto Rebirth",
	Default = false,
	Callback = function(Value)
		rebirthing = Value
		if rebirthing then
			spawn(function()
				local player = game.Players.LocalPlayer
				local stats = player:WaitForChild("leaderstats")
				local rebirths = stats:WaitForChild("Rebirths")

				while rebirthing do
					if rebirths.Value >= targetRebirth then
						rebirthing = false
						print("Reached rebirth target: " .. targetRebirth)
						break
					end

					local args = {"rebirthRequest"}
					game:GetService("ReplicatedStorage").rEvents.rebirthEvent:FireServer(unpack(args))
					task.wait(1)
				end
			end)
		end
	end
})

-- AutoFarm Tab
local FarmTab = Window:MakeTab({
	Name = "AutoFarm",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local FarmSection1 = FarmTab:AddSection({
	Name = "Auto Farm 1"
})

_G.SelectedOrb = "Yellow Orb"
_G.OrbCooldown = 0.05
_G.OrbMultiplier = "750x"
_G.AutoFarm = false

FarmSection1:AddDropdown({
	Name = "Orb Type",
	Default = "Yellow Orb",
	Options = {"Yellow Orb", "Blue Orb", "Red Orb", "Orange Orb", "Gem", "Ethereal Orb"},
	Callback = function(Value)
		_G.SelectedOrb = Value
	end    
})

FarmSection1:AddDropdown({
	Name = "Orb Multiplier",
	Default = "750x",
	Options = {"750x", "800x", "850x", "900x", "950x", "1000x"},
	Callback = function(Value)
		_G.OrbMultiplier = Value
	end    
})

FarmSection1:AddTextbox({
	Name = "Orb Cooldown (seconds)",
	Default = "0.05",
	TextDisappear = true,
	Callback = function(Value)
		local num = tonumber(Value)
		if num and num >= 0 then
			_G.OrbCooldown = num
			print("Orb Cooldown set to: "..num.." seconds")
		else
			warn("Invalid input for Orb Cooldown!")
		end
	end
})

FarmSection1:AddToggle({
	Name = "Auto Farm",
	Default = false,
	Callback = function(Value)
		_G.AutoFarm = Value
		if Value then
			spawn(function()
				while _G.AutoFarm do
					if _G.SelectedOrb then
						local args = {
							"collectOrb",
							_G.SelectedOrb,
							"City" -- Change this if you're in a different zone
						}
						game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("orbEvent"):FireServer(unpack(args))
					end
					task.wait(_G.OrbCooldown or 0.05)
				end
			end)
		end
	end    
})

local FarmSection2 = FarmTab:AddSection({
	Name = "Auto Farm 2"
})

FarmSection2:AddDropdown({
	Name = "Orb Type",
	Default = "Yellow Orb",
	Options = {"Yellow Orb", "Blue Orb", "Red Orb", "Orange Orb", "Gem", "Ethereal Orb"},
	Callback = function(Value)
		_G.SelectedOrb = Value
	end    
})

FarmSection2:AddDropdown({
	Name = "Orb Multiplier",
	Default = "750x",
	Options = {"750x", "800x", "850x", "900x", "950x", "1000x"},
	Callback = function(Value)
		_G.OrbMultiplier = Value
	end    
})

FarmSection2:AddTextbox({
	Name = "Orb Cooldown (seconds)",
	Default = "0.05",
	TextDisappear = true,
	Callback = function(Value)
		local num = tonumber(Value)
		if num and num >= 0 then
			_G.OrbCooldown = num
			print("Orb Cooldown set to: "..num.." seconds")
		else
			warn("Invalid input for Orb Cooldown!")
		end
	end
})

FarmSection2:AddToggle({
	Name = "Auto Farm",
	Default = false,
	Callback = function(Value)
		_G.AutoFarm = Value
		if Value then
			spawn(function()
				while _G.AutoFarm do
					if _G.SelectedOrb then
						local args = {
							"collectOrb",
							_G.SelectedOrb,
							"City"
						}
						game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("orbEvent"):FireServer(unpack(args))
					end
					task.wait(_G.OrbCooldown or 0.05)
				end
			end)
		end
	end    
})