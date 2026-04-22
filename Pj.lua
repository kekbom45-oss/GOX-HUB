-- [[ FAKE DONATION COMMANDER - GOLD EDITION ]] --
-- วิธีใช้: ก๊อปปี้สคริปต์นี้ไปวางใน LocalScript หรือ Executor แล้วกดรัน

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

-- 1. สร้างหน้าจอ UI สำหรับกรอกข้อมูล (Control Panel)
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DonationControl"
screenGui.ResetOnSpawn = false
screenGui.Parent = PlayerGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 250, 0, 150)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 2
mainFrame.Active = true
mainFrame.Draggable = true -- ทำให้ลากไปมาได้
mainFrame.Parent = screenGui

local uiCorner = Instance.new("UICorner")
uiCorner.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "FAKE DONATE MENU"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.SourceSansBold
title.Parent = mainFrame

local input = Instance.new("TextBox")
input.Size = UDim2.new(0.8, 0, 0, 40)
input.Position = UDim2.new(0.1, 0, 0.3, 0)
input.PlaceholderText = "จำนวนเงิน..."
input.Text = ""
input.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
input.TextColor3 = Color3.new(1, 1, 1)
input.Parent = mainFrame

local runBtn = Instance.new("TextButton")
runBtn.Size = UDim2.new(0.8, 0, 0, 40)
runBtn.Position = UDim2.new(0.1, 0, 0.65, 0)
runBtn.Text = "RUN DONATION"
runBtn.BackgroundColor3 = Color3.fromRGB(212, 175, 55) -- สีทอง
runBtn.TextColor3 = Color3.new(1, 1, 1)
runBtn.Font = Enum.Font.SourceSansBold
runBtn.Parent = mainFrame

--- ฟังก์ชันสร้างเอฟเฟกต์ประกาศสีทอง (แบบที่คุณต้องการ) ---
local function playGrandDonation(donatorName, amount)
    local announceGui = Instance.new("ScreenGui")
    announceGui.Parent = PlayerGui

    local alert = Instance.new("Frame")
    alert.Size = UDim2.new(0, 0, 0, 120)
    alert.Position = UDim2.new(0.5, 0, 0.3, 0)
    alert.AnchorPoint = Vector2.new(0.5, 0.5)
    alert.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
    alert.BorderSizePixel = 0
    alert.ClipsDescendants = false
    alert.Parent = announceGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 15)
    corner.Parent = alert

    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 240, 100)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 215, 0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 240, 100))
    })
    gradient.Parent = alert

    local text = Instance.new("TextLabel")
    text.Size = UDim2.new(1, 0, 1, 0)
    text.BackgroundTransparency = 1
    text.Text = "🌟 " .. donatorName .. " DONATED R$ " .. amount .. " 🌟"
    text.TextColor3 = Color3.new(1, 1, 1)
    text.TextSize = 35
    text.Font = Enum.Font.LuckiestGuy
    text.TextStrokeTransparency = 0
    text.Parent = alert

    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://6341513552"
    sound.Parent = alert
    sound:Play()

    -- Animation: เด้งออกมา
    TweenService:Create(alert, TweenInfo.new(0.6, Enum.EasingStyle.Back), {Size = UDim2.new(0, 600, 0, 130)}):Play()

    -- เอฟเฟกต์เงินพุ่ง
    task.delay(0.6, function()
        local emitter = Instance.new("ParticleEmitter")
        emitter.Texture = "rbxassetid://241685484"
        emitter.Rate = 200
        emitter.Speed = NumberRange.new(150, 300)
        emitter.SpreadAngle = Vector2.new(360, 360)
        emitter.Parent = alert
        task.wait(0.3)
        emitter.Enabled = false
    end)

    task.wait(5)
    alert:Destroy()
    announceGui:Destroy()
end

-- เมื่อกดปุ่ม RUN
runBtn.MouseButton1Click:Connect(function()
    local val = input.Text
    if val ~= "" and tonumber(val) then
        -- หมายเหตุ: ถ้าใช้สคริปต์นี้รันในแมพคนอื่น คนอื่นจะไม่เห็น
        -- แต่ถ้าใส่ไว้ใน Server Script ใน Studio ทุกคนจะเห็น
        playGrandDonation(player.Name, val)
    end
end)

print("Donation Script Loaded! กรอกตัวเลขในเมนูได้เลยครับ")
