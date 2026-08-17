-- ========================================================
-- YOUGASPEED PRO V2 - Floating Logo & Ultimate Security
-- ========================================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local State = { 
    Speed = 16, 
    IsEnabled = false, 
    IsOpen = true,
    InfiniteJump = false
}

-- GUI SETUP
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "yougaspeed"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- MAIN MENU WINDOW
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 220, 0, 250)
Main.Position = UDim2.new(0.5, -110, 0.4, -125)
Main.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true

-- FLOATING TOGGLE BUTTON (LOGO BULAT)
local ToggleButton = Instance.new("ImageButton", ScreenGui)
ToggleButton.Name = "FloatingLogo"
ToggleButton.Size = UDim2.new(0, 55, 0, 55) -- Ukuran pas, tidak terlalu kecil
ToggleButton.Position = UDim2.new(0, 30, 0.5, -25)
ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
ToggleButton.Image = "rbxassetid://138549323136458" -- ID Gambar kamu
ToggleButton.Active = true
ToggleButton.Draggable = true
ToggleButton.Visible = false -- Awalnya sembunyi karena menu utama sedang terbuka

local LogoCorner = Instance.new("UICorner", ToggleButton)
LogoCorner.CornerRadius = UDim.new(1, 0) -- Membuat gambar jadi bulat sempurna

local LogoStroke = Instance.new("UIStroke", ToggleButton)
LogoStroke.Color = Color3.fromRGB(0, 170, 255)
LogoStroke.Thickness = 2

-- TITLE & MINIMIZE BUTTON (-)
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(0.7, 0, 0, 40)
Title.Position = UDim2.new(0.05, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "⚡ yougaspeed Pro"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 15
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left

local MinBtn = Instance.new("TextButton", Main)
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Position = UDim2.new(1, -35, 0, 5)
MinBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
MinBtn.Text = "-"
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.Font = Enum.Font.GothamBold

-- FUNGSI BUKA / TUTUP MENU UTAMA KE LOGO BULAT
local function ToggleMenu()
    State.IsOpen = not State.IsOpen
    Main.Visible = State.IsOpen
    ToggleButton.Visible = not State.IsOpen
end

MinBtn.MouseButton1Click:Connect(ToggleMenu)
ToggleButton.MouseButton1Click:Connect(ToggleMenu)

-- TOGGLE SPEED BUTTON
local ToggleSpeedBtn = Instance.new("TextButton", Main)
ToggleSpeedBtn.Size = UDim2.new(0.9, 0, 0, 35)
ToggleSpeedBtn.Position = UDim2.new(0.05, 0, 0.2, 0)
ToggleSpeedBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
ToggleSpeedBtn.Text = "Speed: OFF"
ToggleSpeedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleSpeedBtn.Font = Enum.Font.GothamBold
ToggleSpeedBtn.MouseButton1Click:Connect(function()
    State.IsEnabled = not State.IsEnabled
    ToggleSpeedBtn.Text = State.IsEnabled and "Speed: ON" or "Speed: OFF"
    ToggleSpeedBtn.BackgroundColor3 = State.IsEnabled and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(50, 150, 50)
end)

-- SPEED CONTROLLER (+ / -)
local Label = Instance.new("TextLabel", Main)
Label.Size = UDim2.new(0.9, 0, 0, 25)
Label.Position = UDim2.new(0.05, 0, 0.38, 0)
Label.BackgroundTransparency = 1
Label.Text = "Speed: 16"
Label.TextColor3 = Color3.fromRGB(200, 200, 200)
Label.Font = Enum.Font.GothamMedium

local Plus = Instance.new("TextButton", Main)
Plus.Position = UDim2.new(0.55, 0, 0.48, 0)
Plus.Size = UDim2.new(0.4, 0, 0, 35)
Plus.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
Plus.Text = "+"
Plus.TextColor3 = Color3.fromRGB(255, 255, 255)
Plus.MouseButton1Click:Connect(function() 
    if State.Speed < 32 then 
        State.Speed = State.Speed + 2 
        Label.Text = "Speed: " .. State.Speed
    end 
end)

local Minus = Instance.new("TextButton", Main)
Minus.Position = UDim2.new(0.05, 0, 0.48, 0)
Minus.Size = UDim2.new(0.4, 0, 0, 35)
Minus.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
Minus.Text = "-"
Minus.TextColor3 = Color3.fromRGB(255, 255, 255)
Minus.MouseButton1Click:Connect(function() 
    if State.Speed > 16 then 
        State.Speed = State.Speed - 2 
        Label.Text = "Speed: " .. State.Speed
    end 
end)

-- TOGGLE INFINITE JUMP BUTTON
local JumpBtn = Instance.new("TextButton", Main)
JumpBtn.Size = UDim2.new(0.9, 0, 0, 35)
JumpBtn.Position = UDim2.new(0.05, 0, 0.72, 0)
JumpBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
JumpBtn.Text = "Infinite Jump: OFF"
JumpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
JumpBtn.Font = Enum.Font.GothamBold
JumpBtn.MouseButton1Click:Connect(function()
    State.InfiniteJump = not State.InfiniteJump
    JumpBtn.Text = State.InfiniteJump and "Infinite Jump: ON" or "Infinite Jump: OFF"
    JumpBtn.BackgroundColor3 = State.InfiniteJump and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(50, 150, 50)
end)

-- IMPLEMENTASI INFINITE JUMP
UserInputService.JumpRequest:Connect(function()
    if State.InfiniteJump then
        local Char = LocalPlayer.Character
        if Char and Char:FindFirstChildOfClass("Humanoid") then
            Char:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- BYPASS ANTI-CHEAT (Randomized Hooking)
RunService.Heartbeat:Connect(function()
    if State.IsEnabled then
        local Char = LocalPlayer.Character
        if Char and Char:FindFirstChild("Humanoid") then
            if math.random(1, 10) > 4 then 
                Char.Humanoid.WalkSpeed = State.Speed 
            end
        end
    end
end)
