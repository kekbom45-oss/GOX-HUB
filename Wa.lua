--[[
    BAMBOO BOLT-X: ULTIMATE WARP (X BUTTON UPDATE)
    Created by: Bamboo_3NgU
    Features: Intro Anim, Loading Bar, Manual Select, Random Warp, Quick Close [X]
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- [0] Setup & Anti-Duplicate
if playerGui:FindFirstChild("Bamboo_WarpMaster_UI") then
    playerGui:FindFirstChild("Bamboo_WarpMaster_UI"):Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "Bamboo_WarpMaster_UI"
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
            if object:IsA("TextLabel") or object:IsA("TextButton") then
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
readyLabel.Text = "ระบบพร้อมแล้ว"; readyLabel.TextColor3 = Color3.fromRGB(255, 0, 0);
readyLabel.TextSize = 50; readyLabel.Font = Enum.Font.GothamBold; readyLabel.Position = UDim2.new(0.5, -200, 0.5, -25);
readyLabel.Size = UDim2.new(0, 400, 0, 50); readyLabel.BackgroundTransparency = 1;
task.wait(0.2)
TweenService:Create(readyLabel, TweenInfo.new(0.8, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {Size = UDim2.new(0, 1200, 0, 300), Position = UDim2.new(0.5, -600, 0.5, -150), TextTransparency = 1}):Play()
task.wait(0.8); readyLabel:Destroy()

-- [2] MAIN UI STRUCTURE
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 300, 0, 420)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -210)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
mainFrame.Active = true; mainFrame.Draggable = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 15)
local mainStroke = Instance.new("UIStroke", mainFrame); mainStroke.Thickness = 3; applyRainbow(mainStroke)

-- [X] ปุ่มปิดขวาบน
local closeBtn = Instance.new("TextButton", mainFrame)
closeBtn.Size = UDim2.new(0, 35, 0, 35)
closeBtn.Position = UDim2.new(1, -40, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(40, 10, 10)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 18
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 8)
closeBtn.MouseButton1Click:Connect(function()
    mainFrame:TweenSize(UDim2.new(0, 300, 0, 0), "In", "Quart", 0.3, true)
    task.wait(0.3)
    screenGui:Destroy()
end)

local title = Instance.new("TextLabel", mainFrame)
title.Text = "WARP MASTER"; title.Size = UDim2.new(1, -50, 0, 50); title.Position = UDim2.new(0, 10, 0, 0);
title.BackgroundTransparency = 1; title.Font = Enum.Font.FredokaOne; title.TextSize = 24; applyRainbow(title); title.TextXAlignment = Enum.TextXAlignment.Left

-- [Page Manager]
local mainMenu = Instance.new("Frame", mainFrame)
mainMenu.Size = UDim2.new(1, -20, 1, -60); mainMenu.Position = UDim2.new(0, 10, 0, 55); mainMenu.BackgroundTransparency = 1

local selectPage = Instance.new("Frame", mainFrame)
selectPage.Size = UDim2.new(1, -20, 1, -60); selectPage.Position = UDim2.new(0, 10, 0, 55); selectPage.BackgroundTransparency = 1; selectPage.Visible = false

-- [3] Helper Functions
local function createBtn(text, color, parent)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(1, 0, 0, 45)
    btn.Text = text; btn.BackgroundColor3 = color;
    btn.TextColor3 = Color3.fromRGB(255, 255, 255); btn.Font = Enum.Font.GothamBold; btn.TextSize = 14;
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
    return btn
end

-- [4] Logic & Variables
local warpMode = "None"
local selectedPlayer = nil

local statusText = Instance.new("TextLabel", mainMenu)
statusText.Size = UDim2.new(1, 0, 0, 30); statusText.Text = "สถานะ: รอคำสั่ง...";
statusText.TextColor3 = Color3.fromRGB(200, 200, 200); statusText.BackgroundTransparency = 1; statusText.Font = Enum.Font.GothamBold

-- [5] Main Menu Buttons
local btnSelect = createBtn("🎯 เลือกผู้เล่นเอง (Manual)", Color3.fromRGB(30, 30, 30), mainMenu)
btnSelect.Position = UDim2.new(0, 0, 0.15, 0)

local btnRandom = createBtn("🎲 สุ่มวาร์ป (Random Cycle)", Color3.fromRGB(30, 30, 30), mainMenu)
btnRandom.Position = UDim2.new(0, 0, 0.30, 0)

local btnStop = createBtn("❌ หยุดการวาร์ปทั้งหมด", Color3.fromRGB(50, 20, 20), mainMenu)
btnStop.Position = UDim2.new(0, 0, 0.55, 0); btnStop.TextColor3 = Color3.fromRGB(255, 100, 100)

-- [6] Select Page Setup
local pScroll = Instance.new("ScrollingFrame", selectPage)
pScroll.Size = UDim2.new(1, 0, 0.8, 0); pScroll.BackgroundTransparency = 1; pScroll.ScrollBarThickness = 2
local pList = Instance.new("UIListLayout", pScroll); pList.Padding = UDim.new(0, 5)

local backBtn = createBtn("⬅️ กลับหน้าหลัก", Color3.fromRGB(40, 40, 40), selectPage)
backBtn.Position = UDim2.new(0, 0, 0.85, 0)

local function updatePlayerList()
    for _, c in pairs(pScroll:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= player then
            local b = createBtn(v.DisplayName, Color3.fromRGB(25, 25, 25), pScroll)
            b.Size = UDim2.new(1, -10, 0, 35)
            b.MouseButton1Click:Connect(function()
                selectedPlayer = v; warpMode = "Select"
                statusText.Text = "วาร์ปหา: " .. v.DisplayName; statusText.TextColor3 = Color3.fromRGB(0, 255, 150)
                selectPage.Visible = false; mainMenu.Visible = true
            end)
        end
    end
    pScroll.CanvasSize = UDim2.new(0, 0, 0, pList.AbsoluteContentSize.Y)
end

-- [7] Button Events
btnSelect.MouseButton1Click:Connect(function() updatePlayerList(); mainMenu.Visible = false; selectPage.Visible = true end)
backBtn.MouseButton1Click:Connect(function() selectPage.Visible = false; mainMenu.Visible = true end)

btnRandom.MouseButton1Click:Connect(function()
    warpMode = "Random"
    statusText.Text = "สถานะ: กำลังสุ่มวาร์ป..."; statusText.TextColor3 = Color3.fromRGB(255, 150, 0)
end)

btnStop.MouseButton1Click:Connect(function()
    warpMode = "None"; selectedPlayer = nil
    statusText.Text = "สถานะ: หยุดวาร์ปแล้ว"; statusText.TextColor3 = Color3.fromRGB(255, 100, 100)
end)

-- [8] Background Warp Loop
task.spawn(function()
    while true do
        if warpMode == "Select" and selectedPlayer and selectedPlayer.Parent and selectedPlayer.Character then
            local hrp = selectedPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then player.Character.HumanoidRootPart.CFrame = hrp.CFrame * CFrame.new(0, 0, 2.5) end
        
        elseif warpMode == "Random" then
            local targets = {}
            for _, v in pairs(Players:GetPlayers()) do if v ~= player and v.Character then table.insert(targets, v) end end
            if #targets > 0 then
                local target = targets[math.random(1, #targets)]
                statusText.Text = "🎲 สุ่มเจอ: " .. target.DisplayName
                local start = tick()
                while warpMode == "Random" and target and target.Parent and (tick() - start) < 3 do
                    if target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                        player.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 2.5)
                    end
                    task.wait(0.01)
                end
            end
        end
        task.wait(0.01)
    end
end)
