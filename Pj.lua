-- [[ GOLDEN FAKE DONATION HUB - ALL-IN-ONE VERSION ]] --
-- [[ สไตล์เดียวกับ GitHub Pj.lua : รันแผ่นเดียวใช้ได้เลย ]] --

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local PlayerGui = lp:WaitForChild("PlayerGui")

-- 1. ลบ GUI เก่าถ้ามี (ป้องกันการเปิดซ้ำแล้วซ้อนกัน)
if PlayerGui:FindFirstChild("FakeDonateHub") then
    PlayerGui:FindFirstChild("FakeDonateHub"):Destroy()
end

-- 2. สร้าง Main UI (Control Panel)
local MainGui = Instance.new("ScreenGui")
MainGui.Name = "FakeDonateHub"
MainGui.ResetOnSpawn = false
MainGui.Parent = PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 180)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true -- ทำให้ลากเมนูไปมาบนจอได้
MainFrame.Parent = MainGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- แถบหัวข้อเมนู
local Header = Instance.new("TextLabel")
Header.Size = UDim2.new(1, 0, 0, 40)
Header.Text = "🌟 FAKE DONATE HUB 🌟"
Header.TextColor3 = Color3.fromRGB(255, 215, 0)
Header.BackgroundTransparency = 1
Header.Font = Enum.Font.GothamBold
Header.TextSize = 18
Header.Parent = MainFrame

-- ช่องกรอกจำนวนเงิน
local AmountBox = Instance.new("TextBox")
AmountBox.Size = UDim2.new(0.85, 0, 0, 40)
AmountBox.Position = UDim2.new(0.075, 0, 0.3, 0)
AmountBox.PlaceholderText = "กรอกจำนวน Robux..."
AmountBox.Text = ""
AmountBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
AmountBox.TextColor3 = Color3.new(1, 1, 1)
AmountBox.Font = Enum.Font.Gotham
AmountBox.Parent = MainFrame

local BoxCorner = Instance.new("UICorner")
BoxCorner.Parent = AmountBox

-- ปุ่มกด Execute (รันโดเนท)
local ExecuteBtn = Instance.new("TextButton")
ExecuteBtn.Size = UDim2.new(0.85, 0, 0, 45)
ExecuteBtn.Position = UDim2.new(0.075, 0, 0.65, 0)
ExecuteBtn.Text = "EXECUTE DONATION"
ExecuteBtn.BackgroundColor3 = Color3.fromRGB(212, 175, 55)
ExecuteBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
ExecuteBtn.Font = Enum.Font.GothamBold
ExecuteBtn.TextSize = 16
ExecuteBtn.Parent = MainFrame

local BtnCorner = Instance.new("UICorner")
BtnCorner.Parent = ExecuteBtn

--- [[ ฟังก์ชันเอฟเฟกต์โดเนทสีทอง & เงินพุ่ง ]] ---
local function CreateGoldEffect(amount)
    local AnnounceGui = Instance.new("ScreenGui")
    AnnounceGui.Name = "DonationEffect"
    AnnounceGui.Parent = PlayerGui

    -- กรอบสีทอง
    local Alert = Instance.new("Frame")
    Alert.Size = UDim2.new(0, 0, 0, 130) -- เริ่มต้นจากขนาด 0 เพื่อทำ Tween
    Alert.Position = UDim2.new(0.5, 0, 0.3, 0)
    Alert.AnchorPoint = Vector2.new(0.5, 0.5)
    Alert.BackgroundColor3 = Color3.fromRGB(
