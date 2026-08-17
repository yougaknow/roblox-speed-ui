-- ========================================================
-- YOUGASPEED UI - Roblox Lua Script
-- Mobile-optimized and draggable window
-- ========================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Config = {
    MIN_SPEED = 16,
    MAX_SPEED = 32,
    DEFAULT_SPEED = 16
}

local State = {
    CurrentSpeed = Config.DEFAULT_SPEED,
    IsEnabled = false
}

-- CREATE MAIN SCREEN GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "yougaspeed" -- Nama UI diubah
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local MainPanel = Instance.new("Frame")
MainPanel.Parent = ScreenGui
MainPanel.Size = UDim2.new(0, 220, 0, 160)
MainPanel.Position = UDim2.new(0.5, -110, 0.4, -80)
MainPanel.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainPanel.BorderSizePixel = 0
MainPanel.Active = true
MainPanel.Draggable = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainPanel

local TitleBar = Instance.new("Frame")
TitleBar.Parent = MainPanel
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundTransparency = 1

local TitleText = Instance.new("TextLabel")
TitleText.Parent = TitleBar
TitleText.Size = UDim2.new(0.7, 0, 1, 0)
TitleText.Position = UDim2.new(0, 15, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "⚡ yougaspeed" -- Nama di judul UI
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextSize = 16
TitleText.Font = Enum.Font.GothamBold
TitleText.TextXAlignment = Enum.TextXAlignment.Left

local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = TitleBar
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0.5, -15)
CloseBtn.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 14
CloseBtn.Font = Enum.Font.GothamBold

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

local Content = Instance.new("Frame")
Content.Parent = MainPanel
Content.Size = UDim2.new(1, 0, 1, -40)
Content.Position = UDim2.new(0, 0, 0, 40)
Content.BackgroundTransparency = 1

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Parent = Content
ToggleBtn.Size = UDim2.new(0.85, 0, 0, 40)
ToggleBtn.Position = UDim2.new(0.075, 0, 0.1, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
ToggleBtn.Text = "Status: OFF"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextSize = 14
ToggleBtn.Font = Enum.Font.GothamBold

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 8)
ToggleCorner.Parent = ToggleBtn

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Parent = Content
SpeedLabel.Size = UDim2.new(0.85, 0, 0, 25)
SpeedLabel.Position = UDim2.new(0.075, 0, 0.45, 0)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Speed: 16"
SpeedLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
SpeedLabel.TextSize = 14
SpeedLabel.Font = Enum.Font.GothamMedium
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left

local PlusBtn = Instance.new("TextButton")
PlusBtn.Parent = Content
PlusBtn.Size = UDim2.new(0.4, 0, 0, 35)
PlusBtn.Position = UDim2.new(0.525, 0, 0.65, 0)
PlusBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
PlusBtn.Text = "Speed +"
PlusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
PlusBtn.TextSize = 14
PlusBtn.Font = Enum.Font.GothamBold

local PlusCorner = Instance.new("UICorner")
PlusCorner.CornerRadius = UDim.new(0, 8)
PlusCorner.Parent = PlusBtn

local MinusBtn = Instance.new("TextButton")
MinusBtn.Parent = Content
MinusBtn.Size = UDim2.new(0.4, 0, 0, 35)
MinusBtn.Position = UDim2.new(0.075, 0, 0.65, 0)
MinusBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
MinusBtn.Text = "Speed -"
MinusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinusBtn.TextSize = 14
MinusBtn.Font = Enum.Font.GothamBold

local MinusCorner = Instance.new("UICorner")
MinusCorner.CornerRadius = UDim.new(0, 8)
MinusCorner.Parent = MinusBtn

ToggleBtn.MouseButton1Click:Connect(function()
    State.IsEnabled = not State.IsEnabled
    if State.IsEnabled then
        ToggleBtn.Text = "Status: ON"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    else
        ToggleBtn.Text = "Status: OFF"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = 16
        end
    end
end)

PlusBtn.MouseButton1Click:Connect(function()
    if State.CurrentSpeed < Config.MAX_SPEED then
        State.CurrentSpeed = State.CurrentSpeed + 2
        SpeedLabel.Text = "Speed: " .. State.CurrentSpeed
    end
end)

MinusBtn.MouseButton1Click:Connect(function()
    if State.CurrentSpeed > Config.MIN_SPEED then
        State.CurrentSpeed = State.CurrentSpeed - 2
        SpeedLabel.Text = "Speed: " .. State.CurrentSpeed
    end
end)

RunService.Heartbeat:Connect(function()
    if State.IsEnabled then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            local humanoid = char.Humanoid
            if humanoid.WalkSpeed ~= State.CurrentSpeed then
                humanoid.WalkSpeed = State.CurrentSpeed
            end
        end
    end
end)
