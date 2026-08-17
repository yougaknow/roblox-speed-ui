-- ========================================================
-- YOUGASPEED PRO V3 - Full Control (Minimize vs Close)
-- ========================================================
-- [Bagian atas kode sama, tambahkan baris berikut di dalam Main Frame]

-- TOMBOL MINIMIZE (-)
local MinBtn = Instance.new("TextButton", Main)
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Position = UDim2.new(1, -70, 0, 5) -- Pindah sedikit ke kiri
MinBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
MinBtn.Text = "-"
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.Font = Enum.Font.GothamBold

-- TOMBOL TUTUP TOTAL (X)
local CloseBtn = Instance.new("TextButton", Main)
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold

-- FUNGSI MINIMIZE (Ke Logo)
local function MinimizeMenu()
    State.IsOpen = false
    Main.Visible = false
    ToggleButton.Visible = true -- Tampilkan logo bulat
end

-- FUNGSI TUTUP TOTAL (Hilang Semua)
local function CloseMenu()
    ScreenGui:Destroy() -- Menghapus seluruh GUI dari layar
end

MinBtn.MouseButton1Click:Connect(MinimizeMenu)
CloseBtn.MouseButton1Click:Connect(CloseMenu)
ToggleButton.MouseButton1Click:Connect(function()
    State.IsOpen = true
    Main.Visible = true
    ToggleButton.Visible = false -- Sembunyikan logo saat menu buka
end)
