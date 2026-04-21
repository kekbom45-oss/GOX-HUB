-- [[ GOX HUB V19 - FINAL GITHUB EDITION ]] --
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local ts = game:GetService("TweenService")
local runService = game:GetService("RunService")
local sg = Instance.new("ScreenGui", player.PlayerGui)
sg.ResetOnSpawn = false

-- ระบบสีรุ้ง (Global)
local rainbowColor = Color3.new(1,1,1)
spawn(function()
    local h = 0
    while wait() do
        h = h + 1/255
        if h > 1 then h = 0 end
        rainbowColor = Color3.fromHSV(h, 1, 1)
    end
end)

-- แจ้งเตือนแบบไม่ซ้อน
local lastN
local function notify(msg)
    if lastN then lastN:Destroy() end
    local n = Instance.new("TextLabel", sg)
    lastN = n
    n.Size = UDim2.new(0, 400, 0, 40)
    n.Position = UDim2.new(0.5, -200, 0.25, 0)
    n.BackgroundTransparency = 1; n.Text = msg; n.Font = "GothamBold"; n.TextSize = 25
    spawn(function() while n.Parent do n.TextColor3 = rainbowColor wait() end end)
    ts:Create(n, TweenInfo.new(0.5, Enum.EasingStyle.Back), {Position = UDim2.new(0.5, -200, 0.2, 0)}):Play()
    delay(2, function() if n then n:Destroy() end end)
end

-- UI Main
local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 260, 0, 320)
main.Position = UDim2.new(0.5, -130, 0.5, -160)
main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
main.Active = true; main.Draggable = true
Instance.new("UICorner", main)

-- ตัวจัดการปุ่ม (เลื่อนได้ยาวๆ)
local scroll = Instance.new("ScrollingFrame", main)
scroll.Size = UDim2.new(1, -15, 1, -60)
scroll.Position = UDim2.new(0, 7, 0, 50)
scroll.BackgroundTransparency = 1
scroll.CanvasSize = UDim2.new(0, 0, 0, 850) -- พื้นที่ยาวพอสำหรับ 10+ ปุ่ม
scroll.ScrollBarThickness = 3
local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0, 8); layout.HorizontalAlignment = "Center"

local function createBtn(text, func, isWarning)
    local b = Instance.new("TextButton", scroll)
    b.Size = UDim2.new(0, 230, 0, 40)
    b.BackgroundColor3 = isWarning and Color3.fromRGB(80, 20, 20) or Color3.fromRGB(30, 30, 30)
    b.Text = text; b.Font = "GothamBold"; b.TextSize = 12; b.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(func)
end

-- [[ รายการปุ่ม 1-10 จัดเต็ม ]] --
createBtn("1. สุ่มวาปหาคน 🌀", function()
    local p2 = game.Players:GetPlayers()
    local t = p2[math.random(#p2)]
    if t.Character then player.Character.HumanoidRootPart.CFrame = t.Character.HumanoidRootPart.CFrame notify("Warped to "..t.Name) end
end)

createBtn("2. วิ่งเร็ว👽 (120)", function() player.Character.Humanoid.WalkSpeed = 120 notify("Speed Max!") end)

createBtn("3. กระโดดสูง 🚀", function() player.Character.Humanoid.JumpPower = 150 notify("Jump Max!") end)

createBtn("4. Spin Fling (ดีดคน) 🌪️", function() 
    loadstring(game:HttpGet("https://raw.githubusercontent.com/1220-128bit/1220/refs/heads/main/script"))() 
    notify("Spin Active!") 
end)

createBtn("5. เมนูบิน ✈️", function() 
    loadstring(game:HttpGet("https://pastebin.com/raw/Q735jr8m"))() 
    notify("Fly Menu Loaded") 
end)

createBtn("6. ยูทูป Music 🎵", function() 
    loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-YouTube-Music-Player-72222"))() 
end)

createBtn("7. เพลง Brookhaven 🏠", function() 
    loadstring(game:HttpGet('https://raw.githubusercontent.com/imc72s/LaztDex/refs/heads/main/BROOKHAVEN_CUSTOM_ID_BOOMBOX'))() 
end)

createBtn("8. วาปปล้นบ้าน 💰", function() 
    loadstring(game:HttpGet("https://raw.githubusercontent.com/GhostPlayer352/Test4/main/Brookhaven%20Obby"))() 
end)

createBtn("9. ทะลุประตู (On/Off) 🚪", function() 
    _G.nc = not _G.nc
    runService.Stepped:Connect(function() 
        if _G.nc and player.Character then 
            for _,v in pairs(player.Character:GetDescendants()) do 
                if v:IsA("BasePart") then v.CanCollide = false end 
            end 
        end 
    end)
    notify(_G.nc and "Noclip: ON" or "Noclip: OFF")
end)

local cpOn = false
createBtn("10. ก๊อปชุด (Identity Swap) 👕", function()
    cpOn = not cpOn
    notify(cpOn and "คลิกตัวละครเพื่อก๊อปชุด!" or "ปิดระบบก๊อปชุด")
end)

mouse.Button1Down:Connect(function()
    if cpOn and mouse.Target then
        local t = mouse.Target.Parent
        if not t:FindFirstChild("Humanoid") then t = t.Parent end
        local tp = game.Players:GetPlayerFromCharacter(t)
        if tp then
            notify("กำลังเปลี่ยนร่างเป็น: " .. tp.Name)
            player.CharacterAppearanceId = tp.UserId
            player.Character:BreakJoints() -- รีเซ็ตเพื่อโหลดชุดใหม่
        end
    end
end)

createBtn("ปิดสคริปต์", function() sg:Destroy() end, true)

-- Header
local h = Instance.new("TextLabel", main)
h.Size = UDim2.new(1,0,0,50); h.Text = "GOX HUB FINAL"; h.Font = "GothamBold"; h.TextSize = 20; h.BackgroundTransparency = 1
spawn(function() while wait() do h.TextColor3 = rainbowColor end end)
