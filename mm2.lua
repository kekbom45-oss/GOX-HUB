--[[
    MM2 BY GOX HUB - VERTICAL EDITION
    - X = ปิดสคริปต์ถาวร
    - ⬜ = ย่อเมนูเป็นวงกลม MM2 สายรุ้ง
    - Intro: ตัวหนังสือลอยกลางจอ (ใส)
]]

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- [0] Setup UI & Cleanup
if playerGui:FindFirstChild("GoxHub_MM2_Vertical") then
    playerGui:FindFirstChild("GoxHub_MM2_Vertical"):Destroy()
end

local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "GoxHub_MM2_Vertical"
screenGui.ResetOnSpawn = false

-- ระบบสีรุ้ง (Rainbow)
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

-- [1] INTRO SYSTEM (ลอยบนจอ - ไม่มีพื้นหลังดำ)
local introLabel = Instance.new("TextLabel", screenGui)
introLabel.Size = UDim2.new(0, 500, 0, 100); introLabel.Position = UDim2.new(0.5, -250, 0.4, -50)
introLabel.BackgroundTransparency = 1; introLabel.Text = "MM2 BY GOX HUB"
introLabel.Font = Enum.Font.FredokaOne; introLabel.TextSize = 60; applyRainbow(introLabel)

local startBtn = Instance.new("TextButton", screenGui)
startBtn.Size = UDim2.new(0, 200, 0, 50); startBtn.Position = UDim2.new(0.5, -100, 0.55, 0)
startBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25); startBtn.Text = "กดเพื่อไปต่อ"; startBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
startBtn.Font = Enum.Font.GothamBold; startBtn.TextSize = 18; Instance.new("UICorner", startBtn)
local btnStroke = Instance.new("UIStroke", startBtn); btnStroke.Thickness = 3; applyRainbow(btnStroke)

-- [2] MAIN UI STRUCTURE (แนวตั้ง)
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 300, 0, 450) -- กลับมาเป็นแนวตั้ง
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -225)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
mainFrame.Visible = false 
mainFrame.Active = true; mainFrame.Draggable = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 15)
local mainStroke = Instance.new("UIStroke", mainFrame); mainStroke.Thickness = 2; applyRainbow(mainStroke)

-- ข้อความซ้ายบนของเมนู
local menuTitle = Instance.new("TextLabel", mainFrame)
menuTitle.Text = "Mm2 by gox hub"; menuTitle.Size = UDim2.new(0, 200, 0, 25); menuTitle.Position = UDim2.new(0, 15, 0, 15)
menuTitle.BackgroundTransparency = 1; menuTitle.Font = Enum.Font.FredokaOne; menuTitle.TextSize = 18
menuTitle.TextXAlignment = Enum.TextXAlignment.Left; applyRainbow(menuTitle)

local subTitle = Instance.new("TextLabel", mainFrame)
subTitle.Text = "แจกฟรีไม่ได้ขายต่อ"; subTitle.Size = UDim2.new(0, 200, 0, 15); subTitle.Position = UDim2.new(0, 15, 0, 35)
subTitle.BackgroundTransparency = 1; subTitle.TextColor3 = Color3.fromRGB(200, 200, 200); subTitle.Font = Enum.Font.Gotham
subTitle.TextSize = 10; subTitle.TextXAlignment = Enum.TextXAlignment.Left

-- [Control Buttons]
local miniBtn = Instance.new("TextButton", screenGui) -- วงกลม MM2 สายรุ้ง
miniBtn.Size = UDim2.new(0, 65, 0, 65); miniBtn.Position = UDim2.new(0, 20, 0.5, -32)
miniBtn.BackgroundColor3 = Color3.fromRGB(10, 10, 10); miniBtn.Text = "MM2"; miniBtn.Font = Enum.Font.FredokaOne
miniBtn.TextSize = 22; miniBtn.Visible = false; Instance.new("UICorner", miniBtn).CornerRadius = UDim.new(1, 0)
applyRainbow(miniBtn)

local closeBtn = Instance.new("TextButton", mainFrame) -- X ปิด
closeBtn.Size = UDim2.new(0, 30, 0, 30); closeBtn.Position = UDim2.new(1, -40, 0, 10)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0); closeBtn.Text = "X"; closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", closeBtn)

local miniHeaderBtn = Instance.new("TextButton", mainFrame) -- ⬜ ย่อ
miniHeaderBtn.Size = UDim2.new(0, 30, 0, 30); miniHeaderBtn.Position = UDim2.new(1, -80, 0, 10)
miniHeaderBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50); miniHeaderBtn.Text = "⬜"; miniHeaderBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", miniHeaderBtn)

-- Logic กดยืนยัน Intro
startBtn.MouseButton1Click:Connect(function()
    introLabel:Destroy()
    startBtn:Destroy()
    mainFrame.Visible = true
end)

closeBtn.MouseButton1Click:Connect(function() screenGui:Destroy() end)
miniHeaderBtn.MouseButton1Click:Connect(function() mainFrame.Visible = false; miniBtn.Visible = true end)
miniBtn.MouseButton1Click:Connect(function() mainFrame.Visible = true; miniBtn.Visible = false end)

-- [3] FUNCTIONS LIST (แนวตั้ง)
local scroll = Instance.new("ScrollingFrame", mainFrame)
scroll.Size = UDim2.new(1, -20, 1, -80); scroll.Position = UDim2.new(0, 10, 0, 70)
scroll.BackgroundTransparency = 1; scroll.ScrollBarThickness = 0; scroll.CanvasSize = UDim2.new(0, 0, 2, 0)
local layout = Instance.new("UIListLayout", scroll); layout.Padding = UDim.new(0, 10)

local function createBtn(text, color)
    local btn = Instance.new("TextButton", scroll)
    btn.Size = UDim2.new(1, 0, 0, 50); btn.Text = text; btn.BackgroundColor3 = color; btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold; btn.TextSize = 14; Instance.new("UICorner", btn)
    return btn
end

-- ฟังก์ชันการใช้งาน
createBtn("⭐ เตะผู้เล่นอื่น (Pastebin)", Color3.fromRGB(80, 20, 20)).MouseButton1Click:Connect(function()
    pcall(function() loadstring(game:HttpGet("https://pastebin.com/raw/8n5Ptfqn"))() end)
end)

local invisActive = false
local invisBtn = createBtn("👻 หายตัว (Invisibility): OFF", Color3.fromRGB(40, 40, 40))
invisBtn.MouseButton1Click:Connect(function()
    invisActive = not invisActive
    invisBtn.Text = invisActive and "👻 หายตัว (Invisibility): ON" or "👻 หายตัว (Invisibility): OFF"
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

createBtn("🌀 ระบบวาร์ป (GitHub)", Color3.fromRGB(0, 50, 100)).MouseButton1Click:Connect(function()
    pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/kekbom45-oss/GOX-HUB/main/Wa.lua"))() end)
end)

createBtn("👁️ ESP Roles", Color3.fromRGB(40, 40, 40))
createBtn("🎯 Silent Aim", Color3.fromRGB(40, 40, 40))
createBtn("🛡️ Anti-Troll Kick (Active)", Color3.fromRGB(0, 80, 50))

-- กันเตะเบื้องต้น
hookfunction(player.Kick, function() return nil end)
