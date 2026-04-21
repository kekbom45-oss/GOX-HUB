--[[
    BAMBOO BOLT-X HUB (MM2 EDITION)
    Created by: Bamboo_3NgU
    GitHub: https://github.com/kekbom45-oss/GOX-HUB
    **Update: Page Navigation System (Main <-> Warp Menu)**
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- [0] Setup & Anti-Duplicate
if playerGui:FindFirstChild("Bamboo_BoltX_UI") then
    playerGui:FindFirstChild("Bamboo_BoltX_UI"):Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "Bamboo_BoltX_UI"
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false

-- ระบบแจ้งเตือน (Notification)
local function notify(title, text, duration)
    local notifFrame = Instance.new("Frame", screenGui)
    notifFrame.Size = UDim2.new(0, 250, 0, 60)
    notifFrame.Position = UDim2.new(1, 10, 0.8, 0)
    notifFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    notifFrame.BorderSizePixel = 0
    Instance.new("UICorner", notifFrame).CornerRadius = UDim.new(0, 10)
    local stroke = Instance.new("UIStroke", notifFrame)
    stroke.Thickness = 2
    stroke.Color = Color3.fromRGB(0, 255, 150)

    local t = Instance.new("TextLabel", notifFrame)
    t.Text = title; t.Size = UDim2.new(1, 0, 0, 25); t.BackgroundTransparency = 1;
    t.TextColor3 = Color3.fromRGB(0, 255, 150); t.Font = Enum.Font.GothamBold; t.TextSize = 14

    local d = Instance.new("TextLabel", notifFrame)
    d.Text = text; d.Size = UDim2.new(1, 0, 0, 30); d.Position = UDim2.new(0, 0, 0, 25); d.BackgroundTransparency = 1;
    d.TextColor3 = Color3.fromRGB(255, 255, 255); d.Font = Enum.Font.Gotham; d.TextSize = 12

    notifFrame:TweenPosition(UDim2.new(1, -260, 0.8, 0), "Out", "Quart", 0.5, true)
    task.delay(duration or 3, function()
        notifFrame:TweenPosition(UDim2.new(1, 10, 0.8, 0), "In", "Quart", 0.5, true)
        task.wait(0.5); notifFrame:Destroy()
    end)
end

-- ระบบสีรุ้ง (Rainbow System)
local function applyRainbow(object)
    task.spawn(function()
        local hue = 0
        while object and object.Parent do
            hue = hue + (1/400)
            if hue > 1 then hue = 0 end
            local color = Color3.fromHSV(hue, 0.7, 1)
            if object:IsA("TextLabel") or object:IsA("TextButton") then
                object.TextColor3 = color
            elseif object:IsA("UIStroke") then
                object.Color = color
            end
            task.wait()
        end
    end)
end

-- [1] Intro Animations
local introLabel = Instance.new("TextLabel", screenGui)
introLabel.Size = UDim2.new(0, 400, 0, 100); introLabel.Position = UDim2.new(0.5, -200, 0.4, 0);
introLabel.BackgroundTransparency = 1; introLabel.Text = "MM2"; introLabel.TextSize = 1;
introLabel.Font = Enum.Font.LuckiestGuy; introLabel.TextTransparency = 1; applyRainbow(introLabel)
TweenService:Create(introLabel, TweenInfo.new(1.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextSize = 120, TextTransparency = 0}):Play()
task.wait(1.8)
TweenService:Create(introLabel, TweenInfo.new(0.8, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {TextSize = 250, TextTransparency = 1}):Play()
task.wait(0.8); introLabel:Destroy()

local loadFrame = Instance.new("Frame", screenGui)
loadFrame.Size = UDim2.new(0, 300, 0, 8); loadFrame.Position = UDim2.new(0.5, -150, 0.5, 0);
loadFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30); Instance.new("UICorner", loadFrame).CornerRadius = UDim.new(1, 0)
local bar = Instance.new("Frame", loadFrame); bar.Size = UDim2.new(0, 0, 1, 0);
bar.BackgroundColor3 = Color3.fromRGB(0, 255, 120); Instance.new("UICorner", bar).CornerRadius = UDim.new(1, 0)
bar:TweenSize(UDim2.new(1, 0, 1, 0), "Out", "Quart", 1.5, true)
task.wait(1.7); loadFrame:Destroy()

-- [2] Main UI Structure
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 300, 0, 450)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -225)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
mainFrame.Active = true; mainFrame.Draggable = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 15)
local mainStroke = Instance.new("UIStroke", mainFrame); mainStroke.Thickness = 3; applyRainbow(mainStroke)

-- Page 1: Main Menu
local mainPage = Instance.new("ScrollingFrame", mainFrame)
mainPage.Size = UDim2.new(1, -20, 1, -70); mainPage.Position = UDim2.new(0, 10, 0, 60)
mainPage.BackgroundTransparency = 1; mainPage.ScrollBarThickness = 0
mainPage.CanvasSize = UDim2.new(0, 0, 0, 500)
Instance.new("UIListLayout", mainPage).Padding = UDim.new(0, 10)

-- Page 2: Warp Selector Menu (ซ่อนไว้ก่อน)
local warpPage = Instance.new("Frame", mainFrame)
warpPage.Size = UDim2.new(1, -20, 1, -70); warpPage.Position = UDim2.new(0, 10, 0, 60)
warpPage.BackgroundTransparency = 1; warpPage.Visible = false

local playerScroll = Instance.new("ScrollingFrame", warpPage)
playerScroll.Size = UDim2.new(1, 0, 0.85, 0); playerScroll.BackgroundTransparency = 1
playerScroll.ScrollBarThickness = 2; playerScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
local pList = Instance.new("UIListLayout", playerScroll); pList.Padding = UDim.new(0, 5)

local backBtn = Instance.new("TextButton", warpPage)
backBtn.Size = UDim2.new(1, 0, 0.12, 0); backBtn.Position = UDim2.new(0, 0, 0.88, 0)
backBtn.Text = "ยกเลิก / กลับหน้าหลัก"; backBtn.BackgroundColor3 = Color3.fromRGB(50, 20, 20)
backBtn.TextColor3 = Color3.fromRGB(255, 100, 100); Instance.new("UICorner", backBtn)

-- Header Title
local title = Instance.new("TextLabel", mainFrame)
title.Text = "BAMBOO BOLT-X"; title.Size = UDim2.new(1, 0, 0, 50); title.BackgroundTransparency = 1;
title.Font = Enum.Font.FredokaOne; title.TextSize = 24; applyRainbow(title)

-- [3] Warp & Logic Variables
local warpActive = false
local selectedPlayer = nil

-- ฟังก์ชันสลับหน้า
local function showMain() warpPage.Visible = false; mainPage.Visible = true end
local function showWarp() mainPage.Visible = false; warpPage.Visible = true end

-- อัปเดตรายชื่อผู้เล่น
local function updatePlayers()
    for _, child in pairs(playerScroll:GetChildren()) do if child:IsA("TextButton") then child:Destroy() end end
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= player then
            local pBtn = Instance.new("TextButton", playerScroll)
            pBtn.Size = UDim2.new(1, -10, 0, 35); pBtn.Text = v.DisplayName .. " (@" .. v.Name .. ")"
            pBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30); pBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            pBtn.Font = Enum.Font.Gotham; pBtn.TextSize = 13; Instance.new("UICorner", pBtn)
            
            pBtn.MouseButton1Click:Connect(function()
                selectedPlayer = v
                warpActive = true
                notify("Target Locked", "กำลังวาร์ปไปหา: " .. v.DisplayName)
                showMain() -- กลับหน้าหลักทันทีเมื่อเลือกเสร็จ
            end)
        end
    end
    playerScroll.CanvasSize = UDim2.new(0, 0, 0, pList.AbsoluteContentSize.Y)
end

backBtn.MouseButton1Click:Connect(showMain)

-- [4] Main Menu Buttons
-- 4.1 ปุ่มเข้าเมนูวาร์ป
local openWarpBtn = Instance.new("TextButton", mainPage)
openWarpBtn.Size = UDim2.new(1, 0, 0, 50); openWarpBtn.Text = "🌀 เปิดเมนูเลือกผู้เล่น (Warp)";
openWarpBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30); openWarpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", openWarpBtn).CornerRadius = UDim.new(0, 12)

openWarpBtn.MouseButton1Click:Connect(function()
    updatePlayers()
    showWarp()
end)

-- 4.2 ปุ่มหยุดวาร์ป
local stopWarpBtn = Instance.new("TextButton", mainPage)
stopWarpBtn.Size = UDim2.new(1, 0, 0, 45); stopWarpBtn.Text = "❌ หยุดวาร์ป (Stop Warp)";
stopWarpBtn.BackgroundColor3 = Color3.fromRGB(45, 25, 25); stopWarpBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
Instance.new("UICorner", stopWarpBtn)
stopWarpBtn.MouseButton1Click:Connect(function()
    warpActive = false; selectedPlayer = nil
    notify("System", "หยุดการวาร์ปทั้งหมดแล้ว")
end)

-- 4.3 ระบบหายตัว (Invisibility Loop)
local invActive = false
local invBtn = Instance.new("TextButton", mainPage)
invBtn.Size = UDim2.new(1, 0, 0, 50); invBtn.Text = "Invisibility: OFF";
invBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30); Instance.new("UICorner", invBtn)
invBtn.MouseButton1Click:Connect(function()
    invActive = not invActive; invBtn.Text = invActive and "Invisibility: ON" or "Invisibility: OFF"
    invBtn.TextColor3 = invActive and Color3.fromRGB(255, 0, 255) or Color3.fromRGB(255, 255, 255)
    task.spawn(function()
        while invActive do
            if player.Character then for _, p in pairs(player.Character:GetDescendants()) do if (p:IsA("BasePart") or p:IsA("Decal")) and p.Name ~= "HumanoidRootPart" then p.Transparency = 1 end end end
            task.wait(0.1)
        end
        if player.Character then for _, p in pairs(player.Character:GetDescendants()) do if (p:IsA("BasePart") or p:IsA("Decal")) and p.Name ~= "HumanoidRootPart" then p.Transparency = 0 end end end
    end)
end)

-- 4.4 ระบบส่องบทบาท (ESP)
local espActive = false
local espBtn = Instance.new("TextButton", mainPage)
espBtn.Size = UDim2.new(1, 0, 0, 50); espBtn.Text = "Show Roles (ESP): OFF";
espBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30); Instance.new("UICorner", espBtn)
espBtn.MouseButton1Click:Connect(function()
    espActive = not espActive; espBtn.Text = espActive and "ESP: ON" or "Show Roles (ESP): OFF"
    task.spawn(function()
        while espActive do
            for _, v in pairs(Players:GetPlayers()) do
                if v ~= player and v.Character then
                    local color = Color3.fromRGB(0, 255, 0)
                    if v.Backpack:FindFirstChild("Knife") or v.Character:FindFirstChild("Knife") then color = Color3.fromRGB(255, 0, 0)
                    elseif v.Backpack:FindFirstChild("Gun") or v.Character:FindFirstChild("Gun") then color = Color3.fromRGB(0, 0, 255) end
                    local h = v.Character:FindFirstChild("RoleESP") or Instance.new("Highlight", v.Character); h.Name = "RoleESP"
                    h.FillColor = color; h.OutlineColor = color; h.Enabled = espActive
                end
            end
            task.wait(1)
        end
    end)
end)

-- [5] Warp Loop (ทำงานอยู่เบื้องหลัง)
task.spawn(function()
    while true do
        if warpActive and selectedPlayer and selectedPlayer.Parent and selectedPlayer.Character then
            local hrp = selectedPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                player.Character.HumanoidRootPart.CFrame = hrp.CFrame * CFrame.new(0, 0, 2.5)
            end
        end
        task.wait(0.01)
    end
end)

-- [6] Exit
local exitBtn = Instance.new("TextButton", mainPage)
exitBtn.Size = UDim2.new(1, 0, 0, 45); exitBtn.Text = "ปิดสคริปต์ (Exit)";
exitBtn.BackgroundColor3 = Color3.fromRGB(50, 20, 20); Instance.new("UICorner", exitBtn)
exitBtn.MouseButton1Click:Connect(function()
    invActive = false; espActive = false; warpActive = false
    mainFrame:TweenSize(UDim2.new(0, 300, 0, 0), "In", "Quart", 0.5, true); task.wait(0.5); screenGui:Destroy()
end)

-- แจ้งเตือนเมื่อพร้อม
notify("Bamboo Bolt-X", "สคริปต์พร้อมใช้งานแล้ว!")
