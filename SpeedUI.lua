-- ========================================================
-- YOUGASPEED PRO V6 - Ultimate Stealth, Resizable & Anti Hit Noclip
-- ========================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local Config = {
    MIN_SPEED = 16,
    MAX_SPEED = 40,
    DEFAULT_SPEED = 16
}

local State = { 
    Speed = Config.DEFAULT_SPEED, 
    SpeedEnabled = false, 
    JumpEnabled = false,
    NoclipEnabled = false,
    IsOpen = true
}

-- PEMBERSIHAN GUI LAMA
if LocalPlayer.PlayerGui:FindFirstChild("yougaspeed") then
    LocalPlayer.PlayerGui.yougaspeed:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "yougaspeed"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- MAIN MENU WINDOW (Resizable)
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 250, 0, 360)
Main.Position = UDim2.new(0.5, -125, 0.4, -180)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color = Color3.fromRGB(0, 170, 255)
MainStroke.Thickness = 1.5

-- FLOATING LOGO "YK"
local ToggleButton = Instance.new("TextButton", ScreenGui)
ToggleButton.Name = "FloatingLogoYK"
ToggleButton.Size = UDim2.new(0, 55, 0, 55)
ToggleButton.Position = UDim2.new(0, 30, 0.5, -27)
ToggleButton.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
ToggleButton.Text = "YK"
ToggleButton.TextColor3 = Color3.fromRGB(0, 170, 255)
ToggleButton.TextSize = 20
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Active = true
ToggleButton.Draggable = true
ToggleButton.Visible = false
Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(1, 0)

local LogoStroke = Instance.new("UIStroke", ToggleButton)
LogoStroke.Color = Color3.fromRGB(0, 170, 255)
LogoStroke.Thickness = 2

-- TITLE BAR
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, -85, 0, 45)
Title.Position = UDim2.new(0.05, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "⚡ yougaspeed YK"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 15
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left

-- HELPER: PEMBUAT TOMBOL KONSISTEN
local function CreateButton(parent, text, position, color)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(0.9, 0, 0, 36)
    btn.Position = position
    btn.BackgroundColor3 = color
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.BorderSizePixel = 0
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    return btn
end

-- KONTROL WINDOW
local MinBtn = Instance.new("TextButton", Main)
MinBtn.Size = UDim2.new(0, 28, 0, 28)
MinBtn.Position = UDim2.new(1, -72, 0, 8)
MinBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
MinBtn.Text = "-"
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 6)

local CloseBtn = Instance.new("TextButton", Main)
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -38, 0, 8)
CloseBtn.BackgroundColor3 = Color3.fromRGB(160, 45, 45)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)

-- ELEMEN KONTROL DALAM MENU
local SpeedToggle = CreateButton(Main, "Speed Bypass: OFF", UDim2.new(0.05, 0, 0.14, 0), Color3.fromRGB(45, 55, 75))
local JumpToggle = CreateButton(Main, "Infinite Jump: OFF", UDim2.new(0.05, 0, 0.30, 0), Color3.fromRGB(45, 55, 75))
local NoclipToggle = CreateButton(Main, "Anti Hit Noclip: OFF", UDim2.new(0.05, 0, 0.46, 0), Color3.fromRGB(45, 55, 75))

local SpeedLabel = Instance.new("TextLabel", Main)
SpeedLabel.Size = UDim2.new(0.9, 0, 0, 20)
SpeedLabel.Position = UDim2.new(0.05, 0, 0.62, 0)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Speed Level: 16"
SpeedLabel.TextColor3 = Color3.fromRGB(180, 180, 200)
SpeedLabel.Font = Enum.Font.GothamMedium
SpeedLabel.TextSize = 12

local MinusBtn = CreateButton(Main, "-", UDim2.new(0.05, 0, 0.72, 0), Color3.fromRGB(45, 45, 60))
MinusBtn.Size = UDim2.new(0.4, 0, 0, 30)

local PlusBtn = CreateButton(Main, "+", UDim2.new(0.55, 0, 0.72, 0), Color3.fromRGB(45, 45, 60))
PlusBtn.Size = UDim2.new(0.4, 0, 0, 30)

-- RESIZE CONTROLS
local SmallBtn = CreateButton(Main, "Small Size", UDim2.new(0.05, 0, 0.86, 0), Color3.fromRGB(50, 50, 70))
SmallBtn.Size = UDim2.new(0.4, 0, 0, 28)

local BigBtn = CreateButton(Main, "Large Size", UDim2.new(0.55, 0, 0.86, 0), Color3.fromRGB(50, 50, 70))
BigBtn.Size = UDim2.new(0.4, 0, 0, 28)

SmallBtn.MouseButton1Click:Connect(function()
    Main.Size = UDim2.new(0, 220, 0, 300)
end)

BigBtn.MouseButton1Click:Connect(function()
    Main.Size = UDim2.new(0, 280, 0, 400)
end)

-- NAVIGASI BUKA/TUTUP MENU
local function ToggleMenu()
    State.IsOpen = not State.IsOpen
    Main.Visible = State.IsOpen
    ToggleButton.Visible = not State.IsOpen
end

MinBtn.MouseButton1Click:Connect(ToggleMenu)
ToggleButton.MouseButton1Click:Connect(ToggleMenu)
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

SpeedToggle.MouseButton1Click:Connect(function()
    State.SpeedEnabled = not State.SpeedEnabled
    SpeedToggle.Text = State.SpeedEnabled and "Speed Bypass: ON" or "Speed Bypass: OFF"
    SpeedToggle.BackgroundColor3 = State.SpeedEnabled and Color3.fromRGB(50, 150, 80) or Color3.fromRGB(45, 55, 75)
end)

JumpToggle.MouseButton1Click:Connect(function()
    State.JumpEnabled = not State.JumpEnabled
    JumpToggle.Text = State.JumpEnabled and "Infinite Jump: ON" or "Infinite Jump: OFF"
    JumpToggle.BackgroundColor3 = State.JumpEnabled and Color3.fromRGB(50, 150, 80) or Color3.fromRGB(45, 55, 75)
end)

NoclipToggle.MouseButton1Click:Connect(function()
    State.NoclipEnabled = not State.NoclipEnabled
    NoclipToggle.Text = State.NoclipEnabled and "Anti Hit Noclip: ON" or "Anti Hit Noclip: OFF"
    NoclipToggle.BackgroundColor3 = State.NoclipEnabled and Color3.fromRGB(50, 150, 80) or Color3.fromRGB(45, 55, 75)
end)

PlusBtn.MouseButton1Click:Connect(function()
    if State.Speed < Config.MAX_SPEED then
        State.Speed = State.Speed + 2
        SpeedLabel.Text = "Speed Level: " .. State.Speed
    end
end)

MinusBtn.MouseButton1Click:Connect(function()
    if State.Speed > Config.MIN_SPEED then
        State.Speed = State.Speed - 2
        SpeedLabel.Text = "Speed Level: " .. State.Speed
    end
end)

-- LOGIC 1: INFINITE JUMP
UserInputService.JumpRequest:Connect(function()
    if State.JumpEnabled then
        local Char = LocalPlayer.Character
        if Char and Char:FindFirstChildOfClass("Humanoid") then
            Char:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- LOGIC 2: CFRAME SPEED BYPASS (100% Aman dari Anti-Cheat WalkSpeed)
RunService.RenderStepped:Connect(function(deltaTime)
    local Char = LocalPlayer.Character
    if not Char then return end

    -- Handle Speed Bypass
    if State.SpeedEnabled then
        if Char:FindFirstChild("HumanoidRootPart") and Char:FindFirstChild("Humanoid") then
            local Humanoid = Char.Humanoid
            local RootPart = Char.HumanoidRootPart
            
            if Humanoid.WalkSpeed ~= 16 then
                Humanoid.WalkSpeed = 16
            end
            
            if Humanoid.MoveDirection.Magnitude > 0 then
                local multiplier = (State.Speed - 16) * 0.75
                RootPart.CFrame = RootPart.CFrame + (Humanoid.MoveDirection * multiplier * deltaTime)
            end
        end
    end

    -- Handle Anti Hit Noclip (Menembus pet, musuh, dan benturan fisik saat aktif)
    if State.NoclipEnabled then
        for _, part in ipairs(Char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)
