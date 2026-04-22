-- [[ GOLDEN FAKE DONATION - ALL-IN-ONE SCRIPT ]] --
-- Copy and run this in your Executor or LocalScript

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local PlayerGui = lp:WaitForChild("PlayerGui")

-- สร้าง Main UI สำหรับกรอกตัวเลข
local MainGui = Instance.new("ScreenGui")
MainGui.Name = "FakeDonateHub"
MainGui.Parent = PlayerGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 260, 0, 160)
Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true
Frame.Parent = MainGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 10)
Corner.Parent = Frame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "DONATION COMMANDER"
Title.TextColor3 = Color3.fromRGB(212, 175, 55)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.Parent = Frame

local Input = Instance.new("TextBox")
Input.Size = UDim2.new(0.8, 0, 0, 35)
Input.Position = UDim2.new(0.1, 0, 0.35, 0)
Input.PlaceholderText = "Enter Amount (Robux)..."
Input.Text = ""
Input.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Input.TextColor3 = Color3.new(1, 1, 1)
Input.Font = Enum.Font.Gotham
Input.Parent = Frame

local RunBtn = Instance.new("TextButton")
RunBtn.Size = UDim2.new(0.8, 0, 0, 40)
RunBtn.Position = UDim2.new(0.1, 0, 0.65, 0)
RunBtn.Text = "RUN DONATION"
RunBtn.BackgroundColor3 = Color3.fromRGB(212, 175, 55)
RunBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
RunBtn.Font = Enum.Font.GothamBold
RunBtn.TextSize = 14
RunBtn.Parent = Frame

local BtnCorner = Instance.new("UICorner")
BtnCorner.Parent = RunBtn

--- [[ ระบบประกาศสีทองอลังการ ]] ---
local function TriggerEffect(donator, amount)
    local EffectGui = Instance.new("ScreenGui")
    EffectGui.Parent = PlayerGui

    local Alert = Instance.new("Frame")
    Alert.Size = UDim2.new(0, 0, 0, 120) -- เริ่มจาก 0 เพื่อ Tween
    Alert.Position = UDim2.new(0.5, 0, 0.3, 0)
    Alert.AnchorPoint = Vector2.new(0.5, 0.5)
    Alert.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
    Alert.BorderSizePixel = 0
    Alert.Parent = EffectGui

    local AlertCorner = Instance.new("UICorner")
    AlertCorner.CornerRadius = UDim.new(0, 20)
    AlertCorner.Parent = Alert

    local Gradient = Instance.new("UIGradient")
    Gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 250, 150)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 215, 0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 250, 150))
    })
    Gradient.Parent = Alert

    local Msg = Instance.new("TextLabel")
    Msg.Size = UDim2.new(1, 0, 1, 0)
    Msg.BackgroundTransparency = 1
    Msg.Text = "⭐ " .. donator:upper() .. " DONATED R$ " .. amount .. " ⭐"
    Msg.TextColor3 = Color3.new(1, 1, 1)
    Msg.TextSize = 35
    Msg.Font = Enum.Font.LuckiestGuy
    Msg.TextStrokeTransparency = 0
    Msg.TextStrokeColor3 = Color3.fromRGB(120, 80, 0)
    Msg.Parent = Alert

    local Sound = Instance.new("Sound")
    Sound.SoundId = "rbxassetid://6341513552"
    Sound.Parent = Alert
    Sound:Play()

    -- Animation: ขยายกรอบประกาศ
    TweenService:Create(Alert, TweenInfo.new(0.6, Enum.EasingStyle.Back), {Size = UDim2.new(0, 650, 0, 130)}):Play()

    -- สร้าง Particle เงินพุ่ง
    task.delay(0.6, function()
        local Emitter = Instance.new("ParticleEmitter")
        Emitter.Texture = "rbxassetid://241685484" -- รูปเหรียญ
        Emitter.Rate = 250
        Emitter.Speed = NumberRange.new(200, 400)
        Emitter.Lifetime = NumberRange.new(1, 2)
        Emitter.SpreadAngle = Vector2.new(360, 360)
        Emitter.Parent = Alert
        
        task.wait(0.4)
        Emitter.Enabled = false
    end)

    -- ลบประกาศเมื่อจบเวลา
    task.wait(5)
    local Close = TweenService:Create(Alert, TweenInfo.new(0.5), {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1})
    Close:Play()
    Close.Completed:Connect(function() EffectGui:Destroy() end)
end

-- เชื่อมปุ่มเข้ากับฟังก์ชัน
RunBtn.MouseButton1Click:Connect(function()
    local val = Input.Text
    if val ~= "" and tonumber(val) then
        TriggerEffect(lp.Name, val)
        -- หมายเหตุ: ถ้าใช้ในแมพคนอื่น คุณจะเห็นคนเดียว (เพราะเป็น LocalScript)
    else
        Input.Text = "Please enter number!"
        task.wait(1)
        Input.Text = ""
    end
end)

print("Golden Donation Loaded! - Use the UI to donate.")
