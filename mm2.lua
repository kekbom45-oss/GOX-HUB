--[[
    BAMBOO BOLT-X HUB (MM2 EDITION)
    Created by: Bamboo_3NgU
    GitHub: https://github.com/kekbom45-oss/GOX-HUB
    **Update: Player Selector & Random Warp**
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

-- [1] Intro Animations (MM2 Rainbow + Loading Bar + Ready Alert)
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
readyLabel.Text = "ระบบพร้อมแล้ว"; readyLabel.TextColor3 = Color3.fromRGB(255, 0, 0);
readyLabel.TextSize = 50; readyLabel.Font = Enum.Font.GothamBold; readyLabel.Position = UDim2.new(0.5, -200, 0.5, -25);
readyLabel.Size = UDim2.new(0, 400, 0, 50); readyLabel.BackgroundTransparency = 1;
task.wait(0.2)
TweenService:Create(readyLabel, TweenInfo.new(0.8, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {Size = UDim2.new(0, 1200, 0, 300), Position = UDim2.new(0.5, -600, 0.5, -150), TextTransparency = 1}):Play()
task.wait(0.8); readyLabel:Destroy()

-- [2] Main UI Design
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 300, 0, 550) 
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -275)
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10); mainFrame.Active = true; mainFrame.Draggable = true;
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 20)
local mainStroke = Instance.new("UIStroke", mainFrame); mainStroke.Thickness = 3; applyRainbow(mainStroke)

local title = Instance.new("TextLabel", mainFrame)
title.Text = "BAMBOO BOLT-X"; title.Size = UDim2.new(1, 0, 0, 50); title.BackgroundTransparency = 1;
title.Font = Enum.Font.FredokaOne; title.TextSize = 24; applyRainbow(title)

local container = Instance.new("ScrollingFrame", mainFrame)
container.Size = UDim2.new(1, -20, 1, -80); container.Position = UDim2.new(0, 10, 0, 65);
container.BackgroundTransparency = 1; container.ScrollBarThickness = 0; container.CanvasSize = UDim2.new(0, 0, 0, 800)
Instance.new("UIListLayout", container).Padding = UDim.new(0, 10)

-- [3] ระบบเลือกผู้เล่นเพื่อวาร์ป (Player Selector)
local selectedPlayer = nil
local warpActive = false

local selectTitle = Instance.new("TextLabel", container)
selectTitle.Size = UDim2.new(1, 0, 0, 20); selectTitle.Text = "--- เลือกผู้เล่นที่ต้องการวาร์ป ---";
selectTitle.TextColor3 = Color3.fromRGB(200, 200, 200); selectTitle.BackgroundTransparency = 1; selectTitle.Font = Enum.Font.GothamBold; selectTitle.TextSize = 12

local playerScroll = Instance.new("ScrollingFrame", container)
playerScroll.Size = UDim2.new(0.95, 0, 0, 120); playerScroll.BackgroundColor3 = Color3.fromRGB(20, 20, 20);
playerScroll.CanvasSize = UDim2.new(0, 0, 0, 0); playerScroll.ScrollBarThickness = 2;
Instance.new("UICorner", playerScroll).CornerRadius = UDim.new(0, 8)
local playerList = Instance.new("UIListLayout", playerScroll); playerList.Padding = UDim.new(0, 5)

local function updatePlayerList()
    for _, child in pairs(playerScroll:GetChildren()) do if child:IsA("TextButton") then child:Destroy() end end
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= player then
            local pBtn = Instance.new("TextButton", playerScroll)
            pBtn.Size = UDim2.new(1, -5, 0, 30); pBtn.Text = v.DisplayName;
            pBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30); pBtn.TextColor3 = Color3.fromRGB(255, 255, 255);
            pBtn.Font = Enum.Font.Gotham; pBtn.TextSize = 12; Instance.new("UICorner", pBtn)
            pBtn.MouseButton1Click:Connect(function()
                selectedPlayer = v
                notify("Target Selected", "คุณเลือกวาร์ปหา: " .. v.Name)
            end)
        end
    end
    playerScroll.CanvasSize = UDim2.new(0, 0, 0, playerList.AbsoluteContentSize.Y)
end
updatePlayerList()
Players.PlayerAdded:Connect(updatePlayerList); Players.PlayerRemoving:Connect(updatePlayerList)

-- [4] ปุ่มวาร์ปหาคนที่เลือก (Toggle)
local warpBtn = Instance.new("TextButton", container)
warpBtn.Size = UDim2.new(0.95, 0, 0, 45); warpBtn.Text = "Warp to Selected: OFF";
warpBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35); warpBtn.TextColor3 = Color3.fromRGB(255, 255, 255);
Instance.new("UICorner", warpBtn).CornerRadius = UDim.new(0, 12)

warpBtn.MouseButton1Click:Connect(function()
    if not selectedPlayer then notify("Error", "กรุณาเลือกผู้เล่นก่อน!"); return end
    warpActive = not warpActive
    warpBtn.Text = warpActive and "Warping: ON" or "Warp to Selected: OFF"
    warpBtn.TextColor3 = warpActive and Color3.fromRGB(0, 255, 150) or Color3.fromRGB(255, 255, 255)
    
    task.spawn(function()
        while warpActive and selectedPlayer and selectedPlayer.Parent do
            if selectedPlayer.Character and selectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame = selectedPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 2.5)
            end
            task.wait(0.01)
        end
    end)
end)

-- [5] ปุ่มสุ่มวาร์ป (Random Warp Toggle)
local randomActive = false
local randBtn = Instance.new("TextButton", container)
randBtn.Size = UDim2.new(0.95, 0, 0, 45); randBtn.Text = "Random Warp (Cycle): OFF";
randBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35); randBtn.TextColor3 = Color3.fromRGB(255, 255, 255);
Instance.new("UICorner", randBtn).CornerRadius = UDim.new(0, 12)

randBtn.MouseButton1Click:Connect(function()
    randomActive = not randomActive
    randBtn.Text = randomActive and "Random: ON" or "Random Warp (Cycle): OFF"
    randBtn.TextColor3 = randomActive and Color3.fromRGB(255, 150, 0) or Color3.fromRGB(255, 255, 255)
    
    task.spawn(function()
        while randomActive do
            local allPlayers = Players:GetPlayers()
            local target = allPlayers[math.random(1, #allPlayers)]
            if target ~= player and target.Character then
                notify("Random Warp", "กำลังไปหา: " .. target.Name, 1.5)
                local start = tick()
                while randomActive and (tick() - start) < 3 do -- เกาะคนละ 3 วินาทีแล้วเปลี่ยน
                    if target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                        player.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 2.5)
                    end
                    task.wait(0.05)
                end
            end
            task.wait(0.1)
        end
    end)
end)

-- [6] ฟังก์ชันเดิม (ESP, Invisibility, Anti-Fling, Extra)
local espBtn = Instance.new("TextButton", container); espBtn.Size = UDim2.new(0.95, 0, 0, 45); espBtn.Text = "Show Roles (ESP): OFF";
espBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25); Instance.new("UICorner", espBtn);
local espActive = false
espBtn.MouseButton1Click:Connect(function()
    espActive = not espActive; espBtn.Text = espActive and "ESP: ON" or "Show Roles (ESP): OFF"
    task.spawn(function()
        while espActive do
            for _, v in pairs(Players:GetPlayers()) do
                if v ~= player and v.Character then
                    local roleColor = Color3.fromRGB(0, 255, 0)
                    if v.Backpack:FindFirstChild("Knife") or v.Character:FindFirstChild("Knife") then roleColor = Color3.fromRGB(255,0,0)
                    elseif v.Backpack:FindFirstChild("Gun") or v.Character:FindFirstChild("Gun") then roleColor = Color3.fromRGB(0,0,255) end
                    local h = v.Character:FindFirstChild("RoleESP") or Instance.new("Highlight", v.Character); h.Name = "RoleESP";
                    h.FillColor = roleColor; h.OutlineColor = roleColor; h.Enabled = espActive
                end
            end
            task.wait(1)
        end
    end)
end)

local invActive = false
local invBtn = Instance.new("TextButton", container); invBtn.Size = UDim2.new(0.95, 0, 0, 45); invBtn.Text = "Invisibility: OFF";
invBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25); Instance.new("UICorner", invBtn);
invBtn.MouseButton1Click:Connect(function()
    invActive = not invActive; invBtn.Text = invActive and "Invis: ON" or "Invisibility: OFF"
    task.spawn(function()
        while invActive do
            if player.Character then for _, p in pairs(player.Character:GetDescendants()) do if (p:IsA("BasePart") or p:IsA("Decal")) and p.Name ~= "HumanoidRootPart" then p.Transparency = 1 end end end
            task.wait(0.1)
        end
        if player.Character then for _, p in pairs(player.Character:GetDescendants()) do if (p:IsA("BasePart") or p:IsA("Decal")) and p.Name ~= "HumanoidRootPart" then p.Transparency = 0 end end end
    end)
end)

local afActive = false
local afBtn = Instance.new("TextButton", container); afBtn.Size = UDim2.new(0.95, 0, 0, 45); afBtn.Text = "Anti-Fling: OFF";
afBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25); Instance.new("UICorner", afBtn);
afBtn.MouseButton1Click:Connect(function()
    afActive = not afActive; afBtn.Text = afActive and "Anti-Fling: ON" or "Anti-Fling: OFF"
    task.spawn(function()
        while afActive do
            if player.Character then for _, p in pairs(player.Character:GetDescendants()) do if p:IsA("BasePart") then p.Velocity = Vector3.zero; p.RotVelocity = Vector3.zero end end end
            RunService.Stepped:Wait()
        end
    end)
end)

local exitBtn = Instance.new("TextButton", container); exitBtn.Size = UDim2.new(0.95, 0, 0, 45); exitBtn.Text = "Exit Script";
exitBtn.BackgroundColor3 = Color3.fromRGB(50, 20, 20); Instance.new("UICorner", exitBtn);
exitBtn.MouseButton1Click:Connect(function()
    warpActive = false; randomActive = false; espActive = false; invActive = false; afActive = false;
    mainFrame:TweenSize(UDim2.new(0, 300, 0, 0), "In", "Quart", 0.5, true); task.wait(0.5); screenGui:Destroy()
end)
