--// SIMPLE KEY SYSTEM
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SimpleKeySystem"
ScreenGui.Parent = playerGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 300, 0, 150)
Frame.Position = UDim2.new(0.5, -150, 0.5, -75)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = Frame

local TextLabel = Instance.new("TextLabel")
TextLabel.Size = UDim2.new(1, 0, 0, 50)
TextLabel.BackgroundTransparency = 1
TextLabel.Text = "Enter Key:"
TextLabel.TextColor3 = Color3.new(1, 1, 1)
TextLabel.Font = Enum.Font.SourceSansBold
TextLabel.TextSize = 24
TextLabel.Parent = Frame

local TextBox = Instance.new("TextBox")
TextBox.Size = UDim2.new(1, -20, 0, 40)
TextBox.Position = UDim2.new(0, 10, 0, 60)
TextBox.ClearTextOnFocus = false
TextBox.Text = ""
TextBox.PlaceholderText = "Type your key here"
TextBox.TextColor3 = Color3.new(0, 0, 0)
TextBox.BackgroundColor3 = Color3.new(1, 1, 1)
TextBox.Font = Enum.Font.SourceSans
TextBox.TextSize = 22
TextBox.Parent = Frame

local TextBoxCorner = Instance.new("UICorner")
TextBoxCorner.CornerRadius = UDim.new(0, 8)
TextBoxCorner.Parent = TextBox

local Button = Instance.new("TextButton")
Button.Size = UDim2.new(0.5, -15, 0, 30)
Button.Position = UDim2.new(0, 10, 1, -40)
Button.Text = "Submit"
Button.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
Button.TextColor3 = Color3.new(1, 1, 1)
Button.Font = Enum.Font.SourceSansBold
Button.TextSize = 22
Button.Parent = Frame

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0, 8)
ButtonCorner.Parent = Button

local correctKey = "MySecretKey" -- Change to your actual key

local function runMainScript()
    ScreenGui:Destroy()

    --// ORION UI STARTS
    local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()

    local Window = OrionLib:MakeWindow({
        Name = "🔒 FuZys Script",
        HidePremium = false,
        SaveConfig = true,
        ConfigFolder = "OrionTest"
    })

    -- Universal Tab
    local UniversalTab = Window:MakeTab({
        Name = "🔧 Universal",
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
        Name = "⚡ AutoFarm",
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
                    local args = {"collectOrb", _G.SelectedOrb, "City"}
                    game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("orbEvent"):FireServer(unpack(args))
                end
                task.wait(_G.OrbCooldown or 0.05)
            end
        end    
    })
end

Button.MouseButton1Click:Connect(function()
    if TextBox.Text == correctKey then
        runMainScript()
    else
        TextLabel.Text = "Incorrect Key! Try again."
        TextLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
        wait(2)
        TextLabel.Text = "Enter Key:"
        TextLabel.TextColor3 = Color3.new(1, 1, 1)
        TextBox.Text = ""
    end
end)