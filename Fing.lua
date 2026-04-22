-- [[ Anti-Fling Reflect Logic ]]
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local lp = Players.LocalPlayer

task.spawn(function()
    while true do
        local char = lp.Character
        local root = char and (char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso"))
        
        if root then
            -- 1. ล็อกความเร็วตัวเองไว้ (กันเรากระเด็น)
            root.Velocity = Vector3.new(0, 0, 0)
            root.RotVelocity = Vector3.new(0, 0, 0)

            -- 2. ตรวจสอบคนรอบข้าง
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= lp and p.Character then
                    local pRoot = p.Character:FindFirstChild("HumanoidRootPart") or p.Character:FindFirstChild("Torso")
                    
                    if pRoot then
                        local dist = (root.Position - pRoot.Position).Magnitude
                        
                        -- ถ้ามีคนเข้าใกล้ (ระยะ 8 เมตร) และมีความเร็วผิดปกติ (พวกใช้สคริปต์ปั่น)
                        if dist < 8 and pRoot.Velocity.Magnitude > 45 then
                            -- สะท้อนกลับ: ดีดคนนั้นขึ้นฟ้าหรือส่งแรงกลับไปมหาศาล
                            pRoot.Velocity = Vector3.new(0, 1500, 0) 
                            
                            -- บล็อกการชนชั่วคราวเพื่อให้เขาทะลุเราไปกระเด็นเอง
                            for _, part in pairs(p.Character:GetChildren()) do
                                if part:IsA("BasePart") then
                                    part.CanCollide = false
                                end
                            end
                            
                            warn("GOX-HUB: สะท้อนการ Fling จาก " .. p.Name)
                        end
                    end
                end
            end
        end
        RunService.Stepped:Wait() -- ทำงานให้ไวเท่ากับเฟรมเรตเกม
    end
end)
