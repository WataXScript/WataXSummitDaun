-- APA LU LIAT LIAT 😂😂😂
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local coordsList = {
    {x=-622.3467, y=250.1038, z=-384.3970},
    {x=-1203.1849, y=261.4581, z=-487.1641},
    {x=-1399.0914, y=578.1970, z=-949.7464},
    {x=-1700.6145, y=816.4534, z=-1399.3834},
    {x=-3199.8823, y=1721.9829, z=-2620.9255}
}

local active = false
local currentIndex = 1
local respawnDelay = 2 


local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 200, 0, 80)
Frame.Position = UDim2.new(0.5, -100, 0.5, -40)
Frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
Frame.Active = true
Frame.Draggable = true
local UICorner = Instance.new("UICorner", Frame)
UICorner.CornerRadius = UDim.new(0,10)

local function newBtn(txt, order)
    local btn = Instance.new("TextButton", Frame)
    btn.Size = UDim2.new(1,-20,0,30)
    btn.Position = UDim2.new(0,10,0,10+(order-1)*35)
    btn.Text = txt
    btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    local c = Instance.new("UICorner", btn)
    c.CornerRadius = UDim.new(0,8)
    return btn
end

local startBtn = newBtn("▶ Start",1)
local stopBtn = newBtn("⏹ Stop",2)


local function onRespawn(char)
    if not active then return end
    local hrp = char:WaitForChild("HumanoidRootPart")
    task.wait(0.1) 
    
    local c = coordsList[currentIndex]
    hrp.CFrame = CFrame.new(c.x, c.y, c.z)
    
    if char:FindFirstChild("Humanoid") then
        char.Humanoid.Health = 0
    end
    
    currentIndex = currentIndex + 1
    if currentIndex > #coordsList then
        currentIndex = 1
    end
    task.wait(respawnDelay) 
end


startBtn.MouseButton1Click:Connect(function()
    if not active then
        active = true
        startBtn.Text = "▶ Running..."
        currentIndex = 1
        
        if LocalPlayer.Character then
            LocalPlayer.Character:BreakJoints()
        end
        
        LocalPlayer.CharacterAdded:Connect(onRespawn)
    end
end)


stopBtn.MouseButton1Click:Connect(function()
    active = false
    startBtn.Text = "▶ Start"
end)
