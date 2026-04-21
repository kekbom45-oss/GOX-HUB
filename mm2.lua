--[[
    BAMBOO BOLT-X HUB (MM2 EDITION)
    Created by: Bamboo_3NgU
    GitHub: https://github.com/kekbom45-oss/GOX-HUB
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

-- ระบบสีรุ้ง
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

-- [Main UI]
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 280, 0, 440) 
mainFrame.Position = UDim2.new(0.5, -140, 0.5, -220)
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
mainFrame.Active = true; mainFrame.Draggable = true;
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 20)
local mainStroke = Instance.new("UIStroke", mainFrame)
mainStroke.Thickness = 3
applyRainbow(mainStroke)

local title = Instance.new("TextLabel", mainFrame)
title.Text = "BAMBOO BOLT-X"; title.Size = UDim2.new(1, 0, 0, 50); title.BackgroundTransparency = 1;
title.Font = Enum.Font.FredokaOne; title.TextSize = 24; applyRainbow(title)

local devName = Instance.new("TextLabel", mainFrame)
devName.Text = "By Bamboo_3NgU"; devName.Position = UDim2.new(0, 0, 0, 42); devName.Size = UDim2.new(1, 0, 0, 20);
devName.BackgroundTransparency = 1; devName.Font = Enum.Font.SourceSansBold; devName.TextSize = 14; applyRainbow(devName)

local container = Instance.new("ScrollingFrame", mainFrame)
container.Size = UDim2.new(1, -20, 1, -80); container.Position = UDim2.new(0, 10, 0, 70);
container.BackgroundTransparency = 1; container.ScrollBarThickness = 0;
container.CanvasSize = UDim2.new(0, 0, 0, 450)
Instance.new("UIListLayout", container).Padding = UDim.new(0, 10)

-- [1] Auto Warp เกาะติด (Sticky Loop)
local tpActive = false
local tpBtn = Instance.new("TextButton", container)
tpBtn.Size = UDim2.new(0.95, 0, 0, 50); tpBtn.Text = "Auto Warp: OFF";
tpBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25); tpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", tpBtn).CornerRadius = UDim.new(0, 12)

tpBtn.MouseButton1Click:Connect(function()
    tpActive = not tpActive
    tpBtn.Text = tpActive and "Auto Warp: ON" or "Auto Warp: OFF"
    tpBtn.TextColor3 = tpActive and Color3.fromRGB(0, 255, 150) or Color3.fromRGB(255, 255, 255)
    notify(tpActive and "ระบบทำงาน" or "ระบบปิด", tpActive and "เริ่มการวาร์ปเกาะติด" or "หยุดวาร์ปแล้ว")
    
    task.spawn(function()
        while tpActive do
            for _, v in pairs(Players:GetPlayers()) do
                if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and tpActive then
                    notify("Sticky Warp", "กำลังเกาะติด: " .. v.Name, 1.5)
                    local start = tick()
                    while tpActive and (tick() - start) < 5 do
                        if v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                            player.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 2.5)
                        end
                        task.wait(0.05)
                    end
                end
                if not tpActive then break end
            end
            task.wait(0.1)
        end
    end)
end)

-- [2] หายตัว (Invisibility Loop) - ปรับกลไกให้เหมือนฟังก์ชันแรก
local invisibleActive = false
local invBtn = Instance.new("TextButton", container)
invBtn.Size = UDim2.new(0.95, 0, 0, 50); invBtn.Text = "Invisibility: OFF";
invBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25); invBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", invBtn).CornerRadius = UDim.new(0, 12)

invBtn.MouseButton1Click:Connect(function()
    invisibleActive = not invisibleActive
    invBtn.Text = invisibleActive and "Invisibility: ON" or "Invisibility: OFF"
    invBtn.TextColor3 = invisibleActive and Color3.fromRGB(255, 0, 255) or Color3.fromRGB(255, 255, 255)
    notify(invisibleActive and "Invisibility" or "Invisibility", invisibleActive and "เปิดการใช้งานหายตัว" or "ปิดการใช้งานหายตัว")

    task.spawn(function()
        while invisibleActive do
            local char = player.Character
            if char then
                for _, part in pairs(char:GetDescendants()) do
                    if (part:IsA("BasePart") or part:IsA("Decal")) and part.Name ~= "HumanoidRootPart" then
                        part.Transparency = 1
                    end
                end
            end
            task.wait(0.1) -- เช็คซ้ำเรื่อยๆ กันตัวละครกลับมาเห็น
        end
        -- เมื่อปิด ให้กลับมามองเห็น
        if not invisibleActive and player.Character then
            for _, part in pairs(player.Character:GetDescendants()) do
                if (part:IsA("BasePart") or part:IsA("Decal")) and part.Name ~= "HumanoidRootPart" then
                    part.Transparency = 0
                end
            end
        end
    end)
end)

-- [3] Anti-Fling
local antiFlingActive = false
local afBtn = Instance.new("TextButton", container)
afBtn.Size = UDim2.new(0.95, 0, 0, 50); afBtn.Text = "Anti-Fling: OFF";
afBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25); afBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", afBtn).CornerRadius = UDim.new(0, 12)

afBtn.MouseButton1Click:Connect(function()
    antiFlingActive = not antiFlingActive
    afBtn.Text = antiFlingActive and "Anti-Fling: ON" or "Anti-Fling: OFF"
    afBtn.TextColor3 = antiFlingActive and Color3.fromRGB(0, 255, 255) or Color3.fromRGB(255, 255, 255)
    notify("Anti-Fling", antiFlingActive and "เปิดใช้งานกันกระเด็น" or "ปิดใช้งานกันกระเด็น")
    
    task.spawn(function()
        while antiFlingActive do
            if player.Character then
                for _, p in pairs(player.Character:GetDescendants()) do
                    if p:IsA("BasePart") then p.Velocity = Vector3.new(0,0,0); p.RotVelocity = Vector3.new(0,0,0) end
                end
            end
            RunService.Stepped:Wait()
        end
    end)
end)

-- [4] Extra Script (Toggle)
local exActive = false
local exBtn = Instance.new("TextButton", container)
exBtn.Size = UDim2.new(0.95, 0, 0, 50); exBtn.Text = "Extra Script: OFF";
exBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25); exBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", exBtn).CornerRadius = UDim.new(0, 12)

exBtn.MouseButton1Click:Connect(function()
    exActive = not exActive
    exBtn.Text = exActive and "Extra Script: ON" or "Extra Script: OFF"
    notify("Extra Script", exActive and "รันสคริปต์ Pastebin..." or "ปิดการรันสคริปต์")
    if exActive then 
        loadstring(game:HttpGet("https://pastebin.com/raw/8n5Ptfqn"))() 
    end
end)

-- [5] Exit
local exitBtn = Instance.new("TextButton", container)
exitBtn.Size = UDim2.new(0.95, 0, 0, 50); exitBtn.Text = "ปิดสคริปต์ (Exit)";
exitBtn.BackgroundColor3 = Color3.fromRGB(45, 20, 20); exitBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
Instance.new("UICorner", exitBtn).CornerRadius = UDim.new(0, 12)

exitBtn.MouseButton1Click:Connect(function()
    notify("Exit", "ปิดการทำงาน BAMBOO BOLT-X")
    tpActive = false; invisibleActive = false; antiFlingActive = false;
    mainFrame:TweenSize(UDim2.new(0, 280, 0, 0), "In", "Quart", 0.5, true)
    task.wait(0.5); screenGui:Destroy()
end)
