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

UniversalTab:AddSection({ Name = "Auto Hoop" })

UniversalTab:AddDropdown({
    Name = "Auto Race Type",
    Default = "Pick AutoRace Type",
    Options = {"Teleport", "Smooth"},
    Callback = function(Value)
        print(Value)
    end    
})

UniversalTab:AddSection({ Name = "Auto Rebirth" })

-- AutoFarm Tab
local FarmTab = Window:MakeTab({
    Name = "AutoFarm",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local FarmSection = FarmTab:AddSection({ Name = "AutoFarm Settings" })

_G.SelectedOrb = "Yellow Orb"
_G.OrbCooldown = 0.05
_G.OrbMultiplier = "750x"

FarmSection:AddDropdown({
    Name = "Orb Type",
    Default = "Yellow Orb",
    Options = {"Yellow Orb", "Blue Orb", "Red Orb", "Orange Orb", "Gem", "Ethereal Orb"},
    Callback = function(Value)
        _G.SelectedOrb = Value
    end    
})

FarmSection:AddDropdown({
    Name = "Orb Multiplier",
    Default = "750x",
    Options = {"750x", "800x", "850x", "900x", "950x", "1000x"},
    Callback = function(Value)
        _G.OrbMultiplier = Value
    end    
})

FarmSection:AddTextbox({
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

FarmSection:AddToggle({
    Name = "Auto Farm",
    Default = false,
    Callback = function(Value)
        _G.AutoFarm = Value
        while _G.AutoFarm do
            if _G.SelectedOrb then
                local args = {"collectOrb", _G.SelectedOrb, "City"} -- change "City" if needed
                game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("orbEvent"):FireServer(unpack(args))
            end
            task.wait(_G.OrbCooldown or 0.05)
        end
    end    
})