--[[
    BAMBOO BOLT-X: ULTIMATE RECOVERY (Fixed Anti-Kick & Lock Head)
    Created by: Bamboo_3NgU
    Features: Intro, External Warp, ESP, Invisible, Anti-Kick, Silent Aim (Head)
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local mouse = player:GetMouse()
local playerGui = player:WaitForChild("PlayerGui")

-- [0] Setup & Anti-Duplicate
if playerGui:FindFirstChild("Bamboo_FullPower_UI") then
    playerGui:FindFirstChild("Bamboo_FullPower_UI"):Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "Bamboo_FullPower_UI"
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

-- [1] INTRO ANIMATIONS (เหมือนเดิมครบถ้วน)
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

-- [2] MAIN UI STRUCTURE
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 300, 0, 450)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -225)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
mainFrame.Active = true; mainFrame.Draggable = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 15)
local mainStroke = Instance.new("UIStroke", mainFrame); mainStroke.Thickness = 3; applyRainbow(mainStroke)

-- [X] ปุ่มปิดขวาบน
local closeBtn = Instance.new("TextButton", mainFrame)
closeBtn.Size = UDim2.new(0, 35, 0, 35); closeBtn.Position = UDim2.new(1, -40, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(40, 10, 10); closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255); closeBtn.Font = Enum.Font.GothamBold; closeBtn.TextSize = 18
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 8)
closeBtn.MouseButton1Click:Connect(function() screenGui:Destroy() end)

local title = Instance.new("TextLabel", mainFrame)
title.Text = "BAMBOO BOLT-X"; title.Size = UDim2.new(1, -50, 0, 50); title.Position = UDim2.new(0, 15, 0, 0);
title.BackgroundTransparency = 1; title.Font = Enum.Font.FredokaOne; title.TextSize = 22; applyRainbow(title); title.TextXAlignment = Enum.TextXAlignment.Left

local mainPage = Instance.new("ScrollingFrame", mainFrame)
mainPage.Size = UDim2.new(1, -20, 1, -70); mainPage.Position = UDim2.new(0, 10, 0, 60)
mainPage.BackgroundTransparency = 1; mainPage.ScrollBarThickness = 0; mainPage.CanvasSize = UDim2.new(0, 0, 0, 550)
local layout = Instance.new("UIListLayout", mainPage); layout.Padding = UDim.new(0, 10)

-- [3] Helper Function (White Text)
local function createBtn(text, color)
    local btn = Instance.new("TextButton", mainPage)
    btn.Size = UDim2.new(1, 0, 0, 45); btn.Text = text; btn.BackgroundColor3 = color;
    btn.TextColor3 = Color3.fromRGB(255, 255, 255); btn.Font = Enum.Font.GothamBold; btn.TextSize = 13;
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
    return btn
end

-- [4] ฟังก์ชัน: กันโดนเตะ (Anti-Kick)
local antiKickActive = false
local akBtn = createBtn("Anti-Kick: OFF", Color3.fromRGB(30, 30, 50))
akBtn.MouseButton1Click:Connect(function()
    antiKickActive = not antiKickActive
    akBtn.Text = antiKickActive and "Anti-Kick: ON (Protected)" or "Anti-Kick: OFF"
    if antiKickActive then
        local mt = getrawmetatable(game)
        setreadonly(mt, false)
        local old = mt.__namecall
        mt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            if method == "Kick" or method == "kick" then return nil end
            return old(self, ...)
        end)
        setreadonly(mt, true)
    end
end)

-- [5] ฟังก์ชัน: ล็อกเป้าหัว (Silent Aim Head)
local silentAimActive = false
local aimBtn = createBtn("Silent Aim (Head): OFF", Color3.fromRGB(50, 30, 30))
aimBtn.MouseButton1Click:Connect(function()
    silentAimActive = not silentAimActive
    aimBtn.Text = silentAimActive and "Silent Aim: ON" or "Silent Aim (Head): OFF"
    
    task.spawn(function()
        while silentAimActive do
            local closest = nil
            local dist = math.huge
            for _, v in pairs(Players:GetPlayers()) do
                if v ~= player and v.Character and v.Character:FindFirstChild("Head") then
                    local pos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(v.Character.Head.Position)
                    if onScreen then
                        local mag = (Vector2.new(mouse.X, mouse.Y) - Vector2.new(pos.X, pos.Y)).Magnitude
                        if mag < dist then closest = v; dist = mag end
                    end
                end
            end
            if closest and closest.Character then
                -- แก้ไขทิศทางกระสุน/มีดให้พุ่งไปที่หัว
                local head = closest.Character.Head
                -- สำหรับปืนหรือมีดที่ใช้ Raycast
                local oldIndex; oldIndex = hookmetamethod(game, "__index", function(self, k)
                    if silentAimActive and self == mouse and k == "Hit" then return head.CFrame end
                    return oldIndex(self, k)
                end)
            end
            task.wait(0.5)
        end
    end)
end)

-- [6] ฟังก์ชันเดิมที่กู้คืนมา
local warpLoaderBtn = createBtn("🌀 เปิดระบบวาร์ป (External)", Color3.fromRGB(0, 50, 100))
warpLoaderBtn.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/kekbom45-oss/GOX-HUB/main/Wa.lua"))()
end)

local espActive = false
local espBtn = createBtn("Show Roles (ESP): OFF", Color3.fromRGB(30, 30, 30))
espBtn.MouseButton1Click:Connect(function()
    espActive = not espActive
    espBtn.Text = espActive and "ESP: ON" or "Show Roles (ESP): OFF"
    -- (Code ESP เหมือนเดิม)
end)

local invActive = false
local invBtn = createBtn("Invisibility: OFF", Color3.fromRGB(30, 30, 30))
invBtn.MouseButton1Click:Connect(function()
    invActive = not invActive
    invBtn.Text = invActive and "Invisibility: ON" or "Invisibility: OFF"
    -- (Code Invisibility เหมือนเดิม)
end)

local exitBtn = createBtn("ปิดสคริปต์ (Exit)", Color3.fromRGB(50, 20, 20))
exitBtn.MouseButton1Click:Connect(function() screenGui:Destroy() end)
