-- [[ Anti-Fling Reflect with Rainbow UI & Welcome Text ]]
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local lp = Players.LocalPlayer

-- 1. สร้าง UI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local ToggleButton = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")
local TitleLabel = Instance.new("TextLabel")
local UICornerMain = Instance.new("UICorner")
local UICornerToggle = Instance.new("UICorner")
local UIGradient = Instance.new("UIGradient") -- สำหรับเอฟเฟกต์สีรุ้ง

ScreenGui.Name = "BambooAntiFling"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

-- 2. ตั้งค่า Main Frame
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- พื้นหลังสีขาว (แต่จะโดน Gradient ทับ)
MainFrame.Position = UDim2.new(0.05, 0, 0.4, 0)
MainFrame.Size = UDim2.new(0, 200, 0, 100)
MainFrame.Active = true
MainFrame.Draggable = true

UICornerMain.Parent = MainFrame

-- 3. ระบบสีรุ้ง (Rainbow Effect)
UIGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
    ColorSequenceKeypoint.new(0.2, Color3.fromRGB(255, 255, 0)),
    ColorSequenceKeypoint.new(0.4, Color3.fromRGB(0, 255, 0)),
    ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0, 255, 255)),
    ColorSequenceKeypoint.new(0.8, Color3.fromRGB(0, 0, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 255))
})
UIGradient.Parent = MainFrame

task.spawn(function()
    local counter = 0
    while MainFrame.Parent do
        UIGradient.Rotation = counter
        counter = counter + 1
        task.wait(0.02)
    end
end)

-- 4. หัวข้อเมนู
TitleLabel.Parent = MainFrame
TitleLabel.Size = UDim2.new(1, 0, 0, 30)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.Text = "AUTO ANTI BY Bamboo_3NgU"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 14
TitleLabel.TextStrokeTransparency = 0.5

-- 5. ปุ่มเปิด/ปิด
ToggleButton.Parent = MainFrame
ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ToggleButton.BackgroundTransparency = 0.3
ToggleButton.Position = UDim2.new(0.1, 0, 0.45, 0)
ToggleButton.Size = UDim2.new(0, 160, 0, 35)
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.Text = "Anti-Fling: OFF"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 18

UICornerToggle.CornerRadius = UDim.new(0, 8)
UICornerToggle.Parent = ToggleButton

-- 6. ปุ่มปิด [X]
CloseButton.Parent = MainFrame
CloseButton.BackgroundTransparency = 1
CloseButton.Position = UDim2.new(0.85, 0, 0, 0)
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 20

-- 7. ตัวแปรและตรรกะสคริปต์
local AntiFlingEnabled = false

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

ToggleButton.MouseButton1Click:Connect(function()
    AntiFlingEnabled = not AntiFlingEnabled
    if AntiFlingEnabled then
        ToggleButton.Text = "Anti-Fling: ON"
        ToggleButton.TextColor3 = Color3.fromRGB(0, 255, 150) -- สีเขียวสว่าง
    else
        ToggleButton.Text = "Anti-Fling: OFF"
        ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
end)

-- แจ้งเตือนเมื่อเริ่มรัน
print("AUTO ANTI BY Bamboo_3NgU Loaded!")

-- Main Logic
task.spawn(function()
    while ScreenGui.Parent do
        if AntiFlingEnabled then
            local char = lp.Character
            local root = char and (char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso"))
            
            if root then
                for _, p in pairs(Players:GetPlayers()) do
                    if p ~= lp and p.Character then
                        local pRoot = p.Character:FindFirstChild("HumanoidRootPart") or p.Character:FindFirstChild("Torso")
                        if pRoot then
                            local dist = (root.Position - pRoot.Position).Magnitude
                            -- ตรวจจับความเร็วที่ผิดปกติ
                            if dist < 8 and pRoot.Velocity.Magnitude > 50 then
                                pRoot.Velocity = Vector3.new(0, 2500, 0) -- ดีดแรงขึ้น
                                warn("Bamboo-Reflected: " .. p.Name)
                            end
                        end
                    end
                end
            end
        end
        RunService.Heartbeat:Wait()
    end
end)
