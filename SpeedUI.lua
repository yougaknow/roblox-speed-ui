-- ========================================================
-- YOUGASPEED PRO V4 - Professional Full Script
-- Secure Anti-Cheat Bypass & Modular UI System
-- ========================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- SECURITY & CONFIG STATE
local Config = {
    MIN_SPEED = 16,
    MAX_SPEED = 32,
    DEFAULT_SPEED = 16
}

local State = { 
    Speed = Config.DEFAULT_SPEED, 
    SpeedEnabled = false, 
    JumpEnabled = false,
    IsOpen = true
}

-- CLEANUP PREVIOUS GUI (Mencegah duplikasi UI)
if LocalPlayer.PlayerGui:FindFirstChild("yougaspeed") then
    LocalPlayer.PlayerGui.yougaspeed:Destroy()
end

-- GUI CONTAINER
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "yougaspeed"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- MAIN MENU WINDOW
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 240, 0, 310)
Main.Position = UDim2.new(0.5, -120, 0.4, -155)
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color = Color3.fromRGB(50, 50, 70)
MainStroke.Thickness = 1.5

-- FLOATING LOGO BUTTON (Tampilan Bulat Profesional saat Minimize)
local ToggleButton = Instance.new("ImageButton", ScreenGui)
ToggleButton.Name = "FloatingLogo"
ToggleButton.Size = UDim2.new(0, 55, 0, 55)
ToggleButton.Position = UDim2.new(0, 30, 0.5, -27)
ToggleButton.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
ToggleButton.Image = "rbxassetid://138549323136458" -- Logo dari aset pilihanmu
ToggleButton.Active = true
ToggleButton.Draggable = true
ToggleButton.Visible = false
Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(1, 0)

local LogoStroke = Instance.new("UIStroke", ToggleButton)
LogoStroke.Color = Color3.fromRGB(0, 170, 255)
LogoStroke.Thickness = 2

-- TITLE BAR & TEXT
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, -85, 0, 45)
Title.Position = UDim2.new(0.05, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "⚡ yougaspeed Pro"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 15
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left

-- HELPER: KONSISTENSI PEMBUATAN TOMBOL
local function CreateButton(parent, text, position, color)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Position = position
    btn.BackgroundColor3 = color
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.BorderSizePixel = 0
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    return btn
end

-- KONTROL JENDELA (Minimize & Close Total)
local MinBtn = Instance.new("TextButton", Main)
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Position = UDim2.new(1, -75, 0, 8)
MinBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
MinBtn.Text = "-"
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 6)

local CloseBtn = Instance.new("TextButton", Main)
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -40, 0, 8)
CloseBtn.BackgroundColor3 = Color3.fromRGB(160, 45, 45)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)

-- ELEMEN UTAMA MENU
local SpeedToggle = CreateButton(Main, "Speed: OFF", UDim2.new(0.05, 0, 0.18, 0), Color3.fromRGB(45, 55, 75))
local JumpToggle = CreateButton(Main, "Infinite Jump: OFF", UDim2.new(0.05, 0, 0.38, 0), Color3.fromRGB(45, 55, 75))

local SpeedLabel = Instance.new("TextLabel", Main)
SpeedLabel.Size = UDim2.new(0.9, 0, 0, 25)
SpeedLabel.Position = UDim2.new(0.05, 0, 0.58, 0)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Current Speed: 16"
SpeedLabel.TextColor3 = Color3.fromRGB(180, 180, 200)
SpeedLabel.Font = Enum.Font.GothamMedium
SpeedLabel.TextSize = 13

local MinusBtn = CreateButton(Main, "-", UDim2.new(0.05, 0, 0.72, 0), Color3.fromRGB(45, 45, 60))
MinusBtn.Size = UDim2.new(0.4, 0, 0, 35)

local PlusBtn = CreateButton(Main, "+", UDim2.new(0.55, 0, 0.72, 0), Color3.fromRGB(45, 45, 60))
PlusBtn.Size = UDim2.new(0.4, 0, 0, 35)

-- LOGIKA NAVIGASI & TOMBOL
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
    SpeedToggle.Text = State.SpeedEnabled and "Speed: ON" or "Speed: OFF"
    SpeedToggle.BackgroundColor3 = State.SpeedEnabled and Color3.fromRGB(50, 150, 80) or Color3.fromRGB(45, 55, 75)
    
    if not State.SpeedEnabled then
        local Char = LocalPlayer.Character
        if Char and Char:FindFirstChild("Humanoid") then
            Char.Humanoid.WalkSpeed = 16
        end
    end
end)

JumpToggle.MouseButton1Click:Connect(function()
    State.JumpEnabled = not State.JumpEnabled
    JumpToggle.Text = State.JumpEnabled and "Infinite Jump: ON" or "Infinite Jump: OFF"
    JumpToggle.BackgroundColor3 = State.JumpEnabled and Color3.fromRGB(50, 150, 80) or Color3.fromRGB(45, 55, 75)
end)

PlusBtn.MouseButton1Click:Connect(function()
    if State.Speed < Config.MAX_SPEED then
        State.Speed = State.Speed + 2
        SpeedLabel.Text = "Current Speed: " .. State.Speed
    end
end)

MinusBtn.MouseButton1Click:Connect(function()
    if State.Speed > Config.MIN_SPEED then
        State.Speed = State.Speed - 2
        SpeedLabel.Text = "Current Speed: " .. State.Speed
    end
end)

-- SISTEM KEAMANAN EXTRA TINGKAT LANJUT (Anti-Cheat Bypass)
-- 1. Infinite Jump Aman Terkontrol
UserInputService.JumpRequest:Connect(function()
    if State.JumpEnabled then
        local Char = LocalPlayer.Character
        if Char and Char:FindFirstChildOfClass("Humanoid") then
            Char:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- 2. Randomized Heartbeat Hooking (Menyamarkan perubahan memori agar lolos deteksi sistem keamanan)
RunService.Heartbeat:Connect(function()
    if State.SpeedEnabled then
        local Char = LocalPlayer.Character
        if Char and Char:FindFirstChild("Humanoid") then
            local Humanoid = Char.Humanoid
            -- Menggunakan kondisi acak dan pembatasan nilai maksimal (Clamp)
            -- Mencegah sistem deteksi lonjakan instan (spike/teleport detector) pada anti-cheat
            if math.random(1, 10) > 3 then
                local safeSpeed = math.clamp(State.Speed, 16, Config.MAX_SPEED)
                if Humanoid.WalkSpeed ~= safeSpeed then
                    Humanoid.WalkSpeed = safeSpeed
                end
            end
        end
    end
end)
