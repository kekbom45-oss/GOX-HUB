--[[
    BAMBOO BOLT-X: ULTIMATE EDITION
    Created by: Bamboo_3NgU
    Features: X to Minimize, Custom Kick Script, External Warp, ESP, Anti-Kick
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- [0] Setup & Anti-Duplicate
if playerGui:FindFirstChild("Bamboo_Final_UI") then
    playerGui:FindFirstChild("Bamboo_Final_UI"):Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "Bamboo_Final_UI"
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false

-- ระบบสีรุ้ง (Rainbow System)
local function applyRainbow(object)
    task.spawn(function()
        local hue = 0
        while object and object.Parent do
            hue = hue + (1/400)
            if hue > 1 then hue = 0 end
            local color = Color3.fromHSV(hue, 0.7, 1)
            if object:IsA("TextLabel") then
                object.TextColor3 = color
            elseif object:IsA("UIStroke") then
                object.Color = color
            end
            task.wait()
        end
    end)
end

-- [1] INTRO ANIMATIONS
local introLabel = Instance.new("TextLabel", screenGui)
introLabel.Size = UDim2.new(0, 400, 0, 100); introLabel.Position = UDim2.new(0.5, -200, 0.4, 0);
introLabel.BackgroundTransparency = 1; introLabel.Text = "MM2"; introLabel.TextSize = 1;
introLabel.Font = Enum.Font.LuckiestGuy; introLabel.TextTransparency = 1; applyRainbow(introLabel)
TweenService:Create(introLabel, TweenInfo.new(1.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextSize = 120, TextTransparency = 0}):Play()
task.wait(1.8)
TweenService:Create(introLabel, TweenInfo.new(0.8, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {TextSize = 250, TextTransparency = 1}):Play()
task.wait(0.8); introLabel:Destroy()

-- [2] MAIN UI STRUCTURE
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 300, 0, 450)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -225)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
mainFrame.Active = true; mainFrame.Draggable = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 15)
local mainStroke = Instance.new("UIStroke", mainFrame); mainStroke.Thickness = 3; applyRainbow(mainStroke)

-- [Open Button] ปุ่มวงกลมตอนย่อเมนู
local openBtn = Instance.new("TextButton", screenGui)
openBtn.Size = UDim2.new(0, 50, 0, 50); openBtn.Position = UDim2.new(0, 20, 0.5, -25)
openBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20); openBtn.Text = "B"; openBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
openBtn.Font = Enum.Font.FredokaOne; openBtn.TextSize = 25; openBtn.Visible = false
Instance.new("UICorner", openBtn).CornerRadius = UDim.new(1, 0)
local openStroke = Instance.new("UIStroke", openBtn); openStroke.Thickness = 2; applyRainbow(openStroke)

local function toggleMinimize(state)
    mainFrame.Visible = not state
    openBtn.Visible = state
end

openBtn.MouseButton1Click:Connect(function() toggleMinimize(false) end)

-- [X] ปุ่มขวาบน สำหรับย่อเมนู
local closeBtn = Instance.new("TextButton", mainFrame)
closeBtn.Size = UDim2.new(0, 35, 0, 35); closeBtn.Position = UDim2.new(1, -40, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(40, 10, 10); closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255); closeBtn.Font = Enum.Font.GothamBold; closeBtn.TextSize = 18
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 8)
closeBtn.MouseButton1Click:Connect(function() toggleMinimize(true) end)

local title = Instance.new("TextLabel", mainFrame)
title.Text = "BAMBOO BOLT-X"; title.Size = UDim2.new(1, -50, 0, 50); title.Position = UDim2.new(0, 15, 0, 0);
title.BackgroundTransparency = 1; title.Font = Enum.Font.FredokaOne; title.TextSize = 22; applyRainbow(title); title.TextXAlignment = Enum.TextXAlignment.Left

local scroll = Instance.new("ScrollingFrame", mainFrame)
scroll.Size = UDim2.new(1, -20, 1, -70); scroll.Position = UDim2.new(0, 10, 0, 60)
scroll.BackgroundTransparency = 1; scroll.ScrollBarThickness = 0; scroll.CanvasSize = UDim2.new(0, 0, 0, 550)
local layout = Instance.new("UIListLayout", scroll); layout.Padding = UDim.new(0, 10)

local function createBtn(text, color)
    local btn = Instance.new("TextButton", scroll)
    btn.Size = UDim2.new(1, 0, 0, 50); btn.Text = text; btn.BackgroundColor3 = color;
    btn.TextColor3 = Color3.fromRGB(255, 255, 255); btn.Font = Enum.Font.GothamBold; btn.TextSize = 14;
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 12)
    return btn
end

-- [3] ฟังก์ชันหลัก
-- ปุ่มเตะผู้เล่น (รันสคริปต์จาก Pastebin)
local kickBtn = createBtn("⭐ เตะผู้เล่นคนอื่น (Kick Script)", Color3.fromRGB(60, 20, 20))
kickBtn.MouseButton1Click:Connect(function()
    kickBtn.Text = "กำลังโหลดสคริปต์เตะ..."
    task.spawn(function()
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://pastebin.com/raw/8n5Ptfqn"))()
        end)
        if success then
            kickBtn.Text = "รันสคริปต์สำเร็จ!"
        else
            kickBtn.Text = "โหลดล้มเหลว!"
            warn("Kick Script Error: " .. tostring(err))
        end
        task.wait(2)
        kickBtn.Text = "⭐ เตะผู้เล่นคนอื่น (Kick Script)"
    end)
end)

local warpBtn = createBtn("🌀 เปิดระบบวาร์ป (External)", Color3.fromRGB(0, 50, 100))
warpBtn.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/kekbom45-oss/GOX-HUB/main/Wa.lua"))()
end)

local aimBtn = createBtn("🎯 ล็อกเป้าหัว (Silent Aim)", Color3.fromRGB(30, 30, 30))
local espBtn = createBtn("👁️ ส่องบทบาท (ESP)", Color3.fromRGB(30, 30, 30))
local akBtn = createBtn("🛡️ กันโดนเตะ (Anti-Kick)", Color3.fromRGB(30, 30, 30))

local exitBtn = createBtn("❌ ปิดสคริปต์ถาวร", Color3.fromRGB(10, 10, 10))
exitBtn.MouseButton1Click:Connect(function() screenGui:Destroy() end)

-- [4] ระบบกันโดนเตะ (Auto Active)
local mt = getrawmetatable(game)
setreadonly(mt, false)
local old = mt.__namecall
mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if method == "Kick" or method == "kick" then return nil end
    return old(self, ...)
end)
setreadonly(mt, true)
