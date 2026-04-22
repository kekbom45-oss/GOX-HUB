--[[
    MM2 BY GOX HUB - THE ULTIMATE EDITION
    - ทุกระบบรวมอยู่ในนี้: Intro, Notifications, Silent Aim, ESP, Invis, Anti-Kick, Warp
    - เครดิต: Mm2 by gox hub (แจกฟรีไม่ได้ขายต่อ)
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local mouse = player:GetMouse()
local playerGui = player:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")

-- [0] Setup UI & Cleanup
if playerGui:FindFirstChild("GoxHub_MM2_Ultimate") then
    playerGui:FindFirstChild("GoxHub_MM2_Ultimate"):Destroy()
end

local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "GoxHub_MM2_Ultimate"
screenGui.ResetOnSpawn = false

-- ระบบสีรุ้ง (Global Rainbow)
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

-- ระบบแจ้งเตือน (Notification)
local function Notify(title, text, duration)
    local notifyFrame = Instance.new("Frame", screenGui)
    notifyFrame.Size = UDim2.new(0, 250, 0, 70)
    notifyFrame.Position = UDim2.new(1, 10, 0, 20)
    notifyFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Instance.new("UICorner", notifyFrame)
    local stroke = Instance.new("UIStroke", notifyFrame); stroke.Thickness = 2; applyRainbow(stroke)

    local tLabel = Instance.new("TextLabel", notifyFrame)
    tLabel.Text = title; tLabel.Size = UDim2.new(1, -20, 0, 25); tLabel.Position = UDim2.new(0, 10, 0, 5)
    tLabel.BackgroundTransparency = 1; tLabel.Font = Enum.Font.FredokaOne; tLabel.TextSize = 16; applyRainbow(tLabel)

    local mLabel = Instance.new("TextLabel", notifyFrame)
    mLabel.Text = text; mLabel.Size = UDim2.new(1, -20, 0, 30); mLabel.Position = UDim2.new(0, 10, 0, 30)
    mLabel.BackgroundTransparency = 1; mLabel.TextColor3 = Color3.fromRGB(255, 255, 255); mLabel.Font = Enum.Font.Gotham; mLabel.TextSize = 14; mLabel.TextWrapped = true

    notifyFrame:TweenPosition(UDim2.new(1, -270, 0, 20), "Out", "Back", 0.5, true)
    task.delay(duration or 3, function()
        notifyFrame:TweenPosition(UDim2.new(1, 10, 0, 20), "In", "Quad", 0.5, true)
        task.wait(0.5); notifyFrame:Destroy()
    end)
end

-- [1] INTRO SYSTEM
local introLabel = Instance.new("TextLabel", screenGui)
introLabel.Size = UDim2.new(0, 500, 0, 100); introLabel.Position = UDim2.new(0.5, -250, 0.4, -50)
introLabel.BackgroundTransparency = 1; introLabel.Text = "MM2 BY GOX HUB"; introLabel.Font = Enum.Font.FredokaOne; introLabel.TextSize = 60; applyRainbow(introLabel)

local startBtn = Instance.new("TextButton", screenGui)
startBtn.Size = UDim2.new(0, 200, 0, 50); startBtn.Position = UDim2.new(0.5, -100, 0.55, 0)
startBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25); startBtn.Text = "กดเพื่อไปต่อ"; startBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
startBtn.Font = Enum.Font.GothamBold; startBtn.TextSize = 18; Instance.new("UICorner", startBtn)
local btnStroke = Instance.new("UIStroke", startBtn); btnStroke.Thickness = 3; applyRainbow(btnStroke)

-- [2] MAIN UI (แนวตั้ง)
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 300, 0, 480); mainFrame.Position = UDim2.new(0.5, -150, 0.5, -240)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15); mainFrame.Visible = false; mainFrame.Active = true; mainFrame.Draggable = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 15)
local mainStroke = Instance.new("UIStroke", mainFrame); mainStroke.Thickness = 2; applyRainbow(mainStroke)

-- เครดิตซ้ายบน
local menuTitle = Instance.new("TextLabel", mainFrame)
menuTitle.Text = "Mm2 by gox hub"; menuTitle.Size = UDim2.new(0, 200, 0, 25); menuTitle.Position = UDim2.new(0, 15, 0, 15)
menuTitle.BackgroundTransparency = 1; menuTitle.Font = Enum.Font.FredokaOne; menuTitle.TextSize = 18; menuTitle.TextXAlignment = Enum.TextXAlignment.Left; applyRainbow(menuTitle)

local subTitle = Instance.new("TextLabel", mainFrame)
subTitle.Text = "แจกฟรีไม่ได้ขายต่อ"; subTitle.Size = UDim2.new(0, 200, 0, 15); subTitle.Position = UDim2.new(0, 15, 0, 35)
subTitle.BackgroundTransparency = 1; subTitle.TextColor3 = Color3.fromRGB(200, 200, 200); subTitle.Font = Enum.Font.Gotham; subTitle.TextSize = 10; subTitle.TextXAlignment = Enum.TextXAlignment.Left

-- ปุ่มย่อ/ปิด
local miniBtn = Instance.new("TextButton", screenGui)
miniBtn.Size = UDim2.new(0, 65, 0, 65); miniBtn.Position = UDim2.new(0, 20, 0.5, -32); miniBtn.BackgroundColor3 = Color3.fromRGB(10, 10, 10); miniBtn.Text = "MM2"; miniBtn.Visible = false
Instance.new("UICorner", miniBtn).CornerRadius = UDim.new(1, 0); applyRainbow(miniBtn)

local closeBtn = Instance.new("TextButton", mainFrame)
closeBtn.Size = UDim2.new(0, 30, 0, 30); closeBtn.Position = UDim2.new(1, -40, 0, 10); closeBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0); closeBtn.Text = "X"; closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255); Instance.new("UICorner", closeBtn)

local miniHeaderBtn = Instance.new("TextButton", mainFrame)
miniHeaderBtn.Size = UDim2.new(0, 30, 0, 30); miniHeaderBtn.Position = UDim2.new(1, -80, 0, 10); miniHeaderBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50); miniHeaderBtn.Text = "⬜"; miniHeaderBtn.TextColor3 = Color3.fromRGB(255, 255, 255); Instance.new("UICorner", miniHeaderBtn)

startBtn.MouseButton1Click:Connect(function() 
    introLabel:Destroy(); startBtn:Destroy(); mainFrame.Visible = true 
    Notify("GOX HUB", "สคริปต์เริ่มทำงานแล้ว!", 3)
end)
closeBtn.MouseButton1Click:Connect(function() screenGui:Destroy() end)
miniHeaderBtn.MouseButton1Click:Connect(function() mainFrame.Visible = false; miniBtn.Visible = true end)
miniBtn.MouseButton1Click:Connect(function() mainFrame.Visible = true; miniBtn.Visible = false end)

-- [3] ฟังก์ชันระบบ
local scroll = Instance.new("ScrollingFrame", mainFrame)
scroll.Size = UDim2.new(1, -20, 1, -90); scroll.Position = UDim2.new(0, 10, 0, 80); scroll.BackgroundTransparency = 1; scroll.ScrollBarThickness = 2; scroll.CanvasSize = UDim2.new(0, 0, 1.6, 0)
local layout = Instance.new("UIListLayout", scroll); layout.Padding = UDim.new(0, 8)

local function createBtn(text, color)
    local btn = Instance.new("TextButton", scroll)
    btn.Size = UDim2.new(1, 0, 0, 45); btn.Text = text; btn.BackgroundColor3 = color; btn.TextColor3 = Color3.fromRGB(255, 255, 255); btn.Font = Enum.Font.GothamBold; btn.TextSize = 13; Instance.new("UICorner", btn)
    return btn
end

-- 1. ล็อกเป้าฆาตกร (Silent Aim)
local lockEnabled = false
local lockBtn = createBtn("🎯 ล็อกเป้าฆาตกร: OFF", Color3.fromRGB(40, 40, 40))
lockBtn.MouseButton1Click:Connect(function()
    lockEnabled = not lockEnabled
    lockBtn.Text = lockEnabled and "🎯 ล็อกเป้าฆาตกร: ON" or "🎯 ล็อกเป้าฆาตกร: OFF"
    Notify("Silent Aim", (lockEnabled and "เปิดใช้งาน (ต้องถือปืน)" or "ปิดการใช้งาน"), 2)
end)

-- 2. มองบทบาท (ESP)
local espEnabled = false
local espBtn = createBtn("👁️ มองบทบาท (ESP): OFF", Color3.fromRGB(40, 40, 40))
espBtn.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    espBtn.Text = espEnabled and "👁️ มองบทบาท (ESP): ON" or "👁️ มองบทบาท (ESP): OFF"
    Notify("ESP", (espEnabled and "เริ่มมองเห็นบทบาท" or "ปิดการมองเห็น"), 2)
    task.spawn(function()
        while espEnabled do
            for _, v in pairs(Players:GetPlayers()) do
                if v ~= player and v.Character then
                    local highlight = v.Character:FindFirstChild("GoxESP") or Instance.new("Highlight", v.Character)
                    highlight.Name = "GoxESP"
                    if v.Backpack:FindFirstChild("Knife") or v.Character:FindFirstChild("Knife") then
                        highlight.FillColor = Color3.fromRGB(255, 0, 0) -- แดง
                    elseif v.Backpack:FindFirstChild("Gun") or v.Character:FindFirstChild("Gun") then
                        highlight.FillColor = Color3.fromRGB(0, 0, 255) -- น้ำเงิน
                    else
                        highlight.FillColor = Color3.fromRGB(0, 255, 0) -- เขียว
                    end
                end
            end
            task.wait(1)
        end
        for _, v in pairs(Players:GetPlayers()) do if v.Character and v.Character:FindFirstChild("GoxESP") then v.Character.GoxESP:Destroy() end end
    end)
end)

-- 3. หายตัว (Invisibility)
local invisActive = false
local invisBtn = createBtn("👻 หายตัว (Invis): OFF", Color3.fromRGB(40, 40, 40))
invisBtn.MouseButton1Click:Connect(function()
    invisActive = not invisActive
    invisBtn.Text = invisActive and "👻 หายตัว: ON" or "👻 หายตัว: OFF"
    Notify("Invis", (invisActive and "เปิดโหมดหายตัว" or "ปิดโหมดหายตัว"), 2)
    task.spawn(function()
        while invisActive do
            if player.Character then
                for _, v in pairs(player.Character:GetDescendants()) do
                    if (v:IsA("BasePart") or v:IsA("Decal")) and v.Name ~= "HumanoidRootPart" then v.Transparency = 1 end
                end
            end
            task.wait(0.1)
        end
        if player.Character then
            for _, v in pairs(player.Character:GetDescendants()) do
                if (v:IsA("BasePart") or v:IsA("Decal")) and v.Name ~= "HumanoidRootPart" then v.Transparency = 0 end
            end
        end
    end)
end)

-- 4. เตะผู้เล่น (Pastebin)
createBtn("⭐ เตะผู้เล่นอื่น", Color3.fromRGB(80, 20, 20)).MouseButton1Click:Connect(function()
    Notify("Script", "กำลังโหลดสคริปต์เตะคน...", 2)
    pcall(function() loadstring(game:HttpGet("https://pastebin.com/raw/8n5Ptfqn"))() end)
end)

-- 5. ระบบวาร์ป (GitHub)
createBtn("🌀 ระบบวาร์ป", Color3.fromRGB(0, 50, 100)).MouseButton1Click:Connect(function()
    Notify("Warp", "กำลังโหลดระบบวาร์ป...", 2)
    pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/kekbom45-oss/GOX-HUB/main/Wa.lua"))() end)
end)

-- 6. กันโดนเตะ
createBtn("🛡️ กันโดนเตะ (Active)", Color3.fromRGB(0, 80, 50)).MouseButton1Click:Connect(function()
    Notify("Anti-Kick", "ระบบป้องกันการโดนเตะทำงานตลอดเวลา", 2)
end)

-- [4] CORE LOGIC (Silent Aim & Anti-Kick)
local oldIndex; oldIndex = hookmetamethod(game, "__index", function(self, k)
    if lockEnabled and self == mouse and k == "Hit" then
        local hasGun = player.Character and (player.Character:FindFirstChild("Gun") or player.Backpack:FindFirstChild("Gun"))
        if hasGun then
            for _, v in pairs(Players:GetPlayers()) do
                if v.Character and (v.Backpack:FindFirstChild("Knife") or v.Character:FindFirstChild("Knife")) then
                    return v.Character.Head.CFrame
                end
            end
        end
    end
    return oldIndex(self, k)
end)

local mt = getrawmetatable(game); local oldNamecall = mt.__namecall; setreadonly(mt, false)
mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if (method == "FireServer" or method == "InvokeServer") and tostring(self):find("Remote") then
        local args = {...}
        if args[1] == "KickPlayer" or args[1] == "Crash" then return nil end
    end
    return oldNamecall(self, ...)
end)
setreadonly(mt, true)
hookfunction(player.Kick, function() return nil end)
