--[[
    BAMBOO BOLT-X: WHITE TEXT EDITION
    Created by: Bamboo_3NgU
    Features: Intro Anim, White Text Buttons, External Warp Loader, ESP, Invisibility
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- [0] Setup & Anti-Duplicate
if playerGui:FindFirstChild("Bamboo_WhiteText_UI") then
    playerGui:FindFirstChild("Bamboo_WhiteText_UI"):Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "Bamboo_WhiteText_UI"
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false

-- ระบบสีรุ้ง (Rainbow System สำหรับหัวข้อและขอบ)
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

local loadFrame = Instance.new("Frame", screenGui)
loadFrame.Size = UDim2.new(0, 300, 0, 8); loadFrame.Position = UDim2.new(0.5, -150, 0.5, 0);
loadFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30); Instance.new("UICorner", loadFrame).CornerRadius = UDim.new(1, 0)
local bar = Instance.new("Frame", loadFrame); bar.Size = UDim2.new(0, 0, 1, 0);
bar.BackgroundColor3 = Color3.fromRGB(0, 255, 120); Instance.new("UICorner", bar).CornerRadius = UDim.new(1, 0)
bar:TweenSize(UDim2.new(1, 0, 1, 0), "Out", "Quart", 1.5, true)
task.wait(1.7); loadFrame:Destroy()

local readyLabel = Instance.new("TextLabel", screenGui)
readyLabel.Text = "ระบบพร้อมแล้ว"; readyLabel.TextColor3 = Color3.fromRGB(255, 255, 255); -- เปลี่ยนเป็นสีขาวเพื่อความคลีน
readyLabel.TextSize = 50; readyLabel.Font = Enum.Font.GothamBold; readyLabel.Position = UDim2.new(0.5, -200, 0.5, -25);
readyLabel.Size = UDim2.new(0, 400, 0, 50); readyLabel.BackgroundTransparency = 1;
task.wait(0.2)
TweenService:Create(readyLabel, TweenInfo.new(0.8, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {Size = UDim2.new(0, 1200, 0, 300), Position = UDim2.new(0.5, -600, 0.5, -150), TextTransparency = 1}):Play()
task.wait(0.8); readyLabel:Destroy()

-- [2] MAIN UI STRUCTURE
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 300, 0, 400)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
mainFrame.Active = true; mainFrame.Draggable = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 15)
local mainStroke = Instance.new("UIStroke", mainFrame); mainStroke.Thickness = 3; applyRainbow(mainStroke)

-- [X] ปุ่มปิดขวาบน
local closeBtn = Instance.new("TextButton", mainFrame)
closeBtn.Size = UDim2.new(0, 35, 0, 35); closeBtn.Position = UDim2.new(1, -40, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(40, 10, 10); closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255); -- ตัวหนังสือ X สีขาว
closeBtn.Font = Enum.Font.GothamBold; closeBtn.TextSize = 18
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 8)
closeBtn.MouseButton1Click:Connect(function()
    mainFrame:TweenSize(UDim2.new(0, 300, 0, 0), "In", "Quart", 0.3, true)
    task.wait(0.3); screenGui:Destroy()
end)

local title = Instance.new("TextLabel", mainFrame)
title.Text = "BAMBOO BOLT-X"; title.Size = UDim2.new(1, -50, 0, 50); title.Position = UDim2.new(0, 15, 0, 0);
title.BackgroundTransparency = 1; title.Font = Enum.Font.FredokaOne; title.TextSize = 22; applyRainbow(title); title.TextXAlignment = Enum.TextXAlignment.Left

-- [Main Page Layout]
local mainPage = Instance.new("ScrollingFrame", mainFrame)
mainPage.Size = UDim2.new(1, -20, 1, -70); mainPage.Position = UDim2.new(0, 10, 0, 60)
mainPage.BackgroundTransparency = 1; mainPage.ScrollBarThickness = 0; mainPage.CanvasSize = UDim2.new(0, 0, 0, 450)
local layout = Instance.new("UIListLayout", mainPage); layout.Padding = UDim.new(0, 10)

-- [3] Helper Functions (ปรับสีตัวหนังสือเป็นสีขาว)
local function createBtn(text, color)
    local btn = Instance.new("TextButton", mainPage)
    btn.Size = UDim2.new(1, 0, 0, 50)
    btn.Text = text; btn.BackgroundColor3 = color;
    btn.TextColor3 = Color3.fromRGB(255, 255, 255); -- **ตัวหนังสือสีขาว**
    btn.Font = Enum.Font.GothamBold; btn.TextSize = 14;
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 12)
    return btn
end

-- [4] ปุ่มเปิดระบบวาร์ป (EXTERNAL LOADER)
local warpLoaderBtn = createBtn("🌀 เปิดระบบวาร์ป (External Warp)", Color3.fromRGB(0, 50, 100))
warpLoaderBtn.MouseButton1Click:Connect(function()
    warpLoaderBtn.Text = "กำลังโหลดวาร์ป..."
    task.spawn(function()
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/kekbom45-oss/GOX-HUB/main/Wa.lua"))()
        end)
        if success then
            warpLoaderBtn.Text = "โหลดวาร์ปสำเร็จ!"
        else
            warpLoaderBtn.Text = "โหลดล้มเหลว!"
            warn("Warp Script Error: " .. tostring(err))
        end
        task.wait(2)
        warpLoaderBtn.Text = "🌀 เปิดระบบวาร์ป (External Warp)"
    end)
end)

-- [5] ฟังก์ชัน ESP Roles
local espActive = false
local espBtn = createBtn("Show Roles (ESP): OFF", Color3.fromRGB(30, 30, 30))
espBtn.MouseButton1Click:Connect(function()
    espActive = not espActive
    espBtn.Text = espActive and "ESP: ON" or "Show Roles (ESP): OFF"
    
    task.spawn(function()
        while espActive do
            for _, v in pairs(Players:GetPlayers()) do
                if v ~= player and v.Character then
                    local color = Color3.fromRGB(0, 255, 0)
                    if v.Backpack:FindFirstChild("Knife") or v.Character:FindFirstChild("Knife") then
                        color = Color3.fromRGB(255, 0, 0)
                    elseif v.Backpack:FindFirstChild("Gun") or v.Character:FindFirstChild("Gun") then
                        color = Color3.fromRGB(0, 0, 255)
                    end
                    local h = v.Character:FindFirstChild("RoleESP") or Instance.new("Highlight", v.Character)
                    h.Name = "RoleESP"; h.FillColor = color; h.OutlineColor = color; h.Enabled = espActive
                end
            end
            task.wait(1)
        end
        for _, v in pairs(Players:GetPlayers()) do
            if v.Character and v.Character:FindFirstChild("RoleESP") then v.Character.RoleESP:Destroy() end
        end
    end)
end)

-- [6] ฟังก์ชัน Invisibility
local invActive = false
local invBtn = createBtn("Invisibility: OFF", Color3.fromRGB(30, 30, 30))
invBtn.MouseButton1Click:Connect(function()
    invActive = not invActive
    invBtn.Text = invActive and "Invisibility: ON" or "Invisibility: OFF"
    
    task.spawn(function()
        while invActive do
            if player.Character then
                for _, p in pairs(player.Character:GetDescendants()) do
                    if (p:IsA("BasePart") or p:IsA("Decal")) and p.Name ~= "HumanoidRootPart" then p.Transparency = 1 end
                end
            end
            task.wait(0.1)
        end
        if player.Character then
            for _, p in pairs(player.Character:GetDescendants()) do
                if (p:IsA("BasePart") or p:IsA("Decal")) and p.Name ~= "HumanoidRootPart" then p.Transparency = 0 end
            end
        end
    end)
end)

-- [7] ฟังก์ชัน Exit
local exitBtn = createBtn("ปิดสคริปต์ (Exit All)", Color3.fromRGB(50, 20, 20))
exitBtn.MouseButton1Click:Connect(function()
    espActive = false; invActive = false
    mainFrame:TweenSize(UDim2.new(0, 300, 0, 0), "In", "Quart", 0.5, true)
    task.wait(0.5); screenGui:Destroy()
end)
