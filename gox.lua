-- [[ Gox hub by KekBom - Identity Rewrite V16 ]] --
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

-- แจ้งเตือน (ลบของเก่าก่อนเสมอ)
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
        if n then n:Destroy() end
    end)
end

-- UI Main
local main = Instance.new("Frame", sg)
main.Size = UDim2.size(260, 320)
main.Position = UDim2.new(0.5, -130, 0.5, -160)
main.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
main.Active = true
main.Draggable = true
Instance.new("UICorner", main)

local scroll = Instance.new("ScrollingFrame", main)
scroll.Size = UDim2.new(1, -10, 1, -60)
scroll.Position = UDim2.new(0, 5, 0, 50)
scroll.BackgroundTransparency = 1
scroll.CanvasSize = UDim2.new(0, 0, 0, 600)
local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0, 8)
layout.HorizontalAlignment = "Center"

local function createBtn(text, func)
    local b = Instance.new("TextButton", scroll)
    b.Size = UDim2.new(0, 220, 0, 40)
    b.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    b.Text = text
    b.Font = "GothamBold"
    b.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(func)
end

-- [[ ฟังก์ชันเด็ด: 10. ก๊อปชุดแบบเขียนทับ ID (Identity Swap) ]] --
local idSwapMode = false
createBtn("10. ก๊อปทุกอย่าง (ID Swap) 👕", function()
    idSwapMode = not idSwapMode
    notify(idSwapMode and "ID Swap ON: คลิกที่ตัวละคร!" or "ID Swap OFF")
end)

mouse.Button1Down:Connect(function()
    if not idSwapMode or not mouse.Target then return end
    local target = mouse.Target.Parent
    if not target:FindFirstChild("Humanoid") then target = target.Parent end
    
    local targetPlayer = game.Players:GetPlayerFromCharacter(target)
    if targetPlayer then
        notify("กำลังขโมยตัวตน: " .. targetPlayer.Name)
        
        -- ใช้คำสั่งดึงข้อมูลชุดจากเซิร์ฟเวอร์ Roblox โดยตรง
        local userId = targetPlayer.UserId
        local hum = player.Character:FindFirstChildOfClass("Humanoid")
        
        if hum then
            local success, description = pcall(function()
                return game.Players:GetHumanoidDescriptionFromUserId(userId)
            end)
            
            if success and description then
                -- บังคับใช้ชุด (ApplyDescription)
                hum:ApplyDescription(description)
                notify("ซิงค์ร่างสำเร็จ (รวมผม/หมวก)!")
            else
                -- ถ้า Apply ไม่ติด (เพราะแมพบล็อก) ให้ใช้วิธีเปลี่ยน ID แล้วรีตัว
                player.CharacterAppearanceId = userId
                player.Character:BreakJoints()
                notify("กำลังรีโหลดร่างใหม่...")
            end
        end
    end
end)

-- ปุ่มอื่นๆ
createBtn("1. วิ่งเร็ว👽", function() player.Character.Humanoid.WalkSpeed = 120 end)
createBtn("9. ทะลุประตู 🚪", function() 
    _G.nc = not _G.nc
    game:GetService("RunService").Stepped:Connect(function() 
        if _G.nc then for _,v in pairs(player.Character:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end end 
    end)
end)
createBtn("ปิดสคริปต์", function() sg:Destroy() end)

local hText = Instance.new("TextLabel", main)
hText.Size = UDim2.new(1,0,0,50)
hText.Text = "GOX HUB V16"
hText.Font = "GothamBold"
hText.TextSize = 20
hText.BackgroundTransparency = 1
spawn(function() while wait() do hText.TextColor3 = rainbowColor end end)
