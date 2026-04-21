-- [[ Gox hub by KekBom - Extreme Morph V15 ]] --
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local ts = game:GetService("TweenService")
local sg = Instance.new("ScreenGui", player.PlayerGui)
sg.ResetOnSpawn = false

-- ระบบสีรุ้ง
local rainbowColor = Color3.new(1,1,1)
spawn(function()
    local h = 0
    while wait() do
        h = h + 1/255
        if h > 1 then h = 0 end
        rainbowColor = Color3.fromHSV(h, 1, 1)
    end
end)

-- ฟังก์ชันแจ้งเตือน (แก้บั๊กซ้อนกัน)
local lastNotify
local function notify(msg)
    if lastNotify then lastNotify:Destroy() end
    local n = Instance.new("TextLabel", sg)
    lastNotify = n
    n.Size = UDim2.new(0, 400, 0, 40)
    n.Position = UDim2.new(0.5, -200, 0.2, -50)
    n.BackgroundTransparency = 1
    n.Text = msg
    n.Font = "GothamBold"
    n.TextSize = 25
    n.TextColor3 = rainbowColor
    ts:Create(n, TweenInfo.new(0.4, Enum.EasingStyle.Back), {Position = UDim2.new(0.5, -200, 0.2, 0)}):Play()
    delay(2, function()
        if n then ts:Create(n, TweenInfo.new(0.5), {TextTransparency = 1}):Play() wait(0.5) n:Destroy() end
    end)
end

-- UI Main
local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 260, 0, 320)
main.Position = UDim2.new(0.5, -130, 0.5, -160)
main.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
main.Active = true
main.Draggable = true
Instance.new("UICorner", main)

local scroll = Instance.new("ScrollingFrame", main)
scroll.Size = UDim2.new(1, -10, 1, -60)
scroll.Position = UDim2.new(0, 5, 0, 50)
scroll.BackgroundTransparency = 1
scroll.CanvasSize = UDim2.new(0, 0, 0, 800)
scroll.ScrollBarThickness = 2
local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0, 5)
layout.HorizontalAlignment = "Center"

local function createBtn(text, func)
    local b = Instance.new("TextButton", scroll)
    b.Size = UDim2.new(0, 230, 0, 38)
    b.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    b.Text = text
    b.Font = "GothamBold"
    b.TextColor3 = Color3.new(1,1,1)
    b.TextSize = 12
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(func)
end

-- ฟังก์ชันรายการอื่นๆ
createBtn("1. สุ่มวาป", function() 
    local p2 = game.Players:GetPlayers()
    player.Character.HumanoidRootPart.CFrame = p2[math.random(#p2)].Character.HumanoidRootPart.CFrame 
end)
createBtn("2. วิ่งเร็ว👽", function() player.Character.Humanoid.WalkSpeed = 120 end)
createBtn("9. ทะลุประตู 🚪", function() 
    _G.nc = not _G.nc
    game:GetService("RunService").Stepped:Connect(function() 
        if _G.nc then for _,v in pairs(player.Character:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end end 
    end)
end)

-- [[ ปุ่ม 10: ระบบก๊อปทุกอย่าง (Perfect Morph) ]] --
local morphMode = false
createBtn("10. ก๊อปทุกอย่าง (Fix) 👕", function()
    morphMode = not morphMode
    notify(morphMode and "โหมดก๊อปเปิด: คลิกที่ตัวละคร!" or "ปิดโหมดก๊อป")
end)

mouse.Button1Down:Connect(function()
    if not morphMode or not mouse.Target then return end
    local target = mouse.Target.Parent
    if not target:FindFirstChild("Humanoid") then target = target.Parent end
    
    if target:FindFirstChild("Humanoid") then
        local targetPlayer = game.Players:GetPlayerFromCharacter(target)
        notify("กำลังซิงค์ร่าง: " .. target.Name)
        
        local myChar = player.Character
        if not myChar then return end

        -- 1. ล้างร่างเดิม
        for _, v in pairs(myChar:GetChildren()) do
            if v:IsA("Accessory") or v:IsA("Shirt") or v:IsA("Pants") or v:IsA("ShirtGraphic") or v:IsA("BodyColors") then
                v:Destroy()
            end
        end

        -- 2. ก๊อปปี้แบบเจาะลึก (Deep Clone)
        for _, v in pairs(target:GetChildren()) do
            if v:IsA("Shirt") or v:IsA("Pants") or v:IsA("BodyColors") or v:IsA("ShirtGraphic") then
                v:Clone().Parent = myChar
            elseif v:IsA("Accessory") then
                local clone = v:Clone()
                myChar.Humanoid:AddAccessory(clone)
            end
        end

        -- 3. เจาะระบบ Brookhaven (บางครั้งผมซ่อนในโฟลเดอร์)
        for _, v in pairs(target:GetDescendants()) do
            if v:IsA("Accessory") and not myChar:FindFirstChild(v.Name) then
                local clone = v:Clone()
                myChar.Humanoid:AddAccessory(clone)
            end
        end

        -- 4. เปลี่ยนใบหน้า
        if target:FindFirstChild("Head") and target.Head:FindFirstChild("face") then
            if myChar.Head:FindFirstChild("face") then myChar.Head.face:Destroy() end
            target.Head.face:Clone().Parent = myChar.Head
        end

        notify("ก๊อปปี้ร่างเสร็จสมบูรณ์!")
    end
end)

createBtn("ปิดสคริปต์", function() sg:Destroy() end)

-- UI Header
local hText = Instance.new("TextLabel", main)
hText.Size = UDim2.new(1,0,0,50)
hText.Text = "GOX HUB V15"
hText.Font = "GothamBold"
hText.TextSize = 20
hText.BackgroundTransparency = 1
spawn(function() while wait() do hText.TextColor3 = rainbowColor end end)
