local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Dark Hub | Legends Of Speed ⚡️", HidePremium = false, SaveConfig = true, ConfigFolder = "OrionTest"})
local Tab = Window:MakeTab({
    Name = "Farm",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})
local Section = Tab:AddSection({
    Name = "AutoHoop"
})
local Section = Tab:AddSection({
    Name = "AutoOrb"
})
local Section = Tab:AddSection({
    Name = "AutoRebirth"
})
