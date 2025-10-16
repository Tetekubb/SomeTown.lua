--###################################################################################
--# ค่าคงที่สำหรับ Teleport และ Part
--###################################################################################

-- CFrame เป้าหมาย: พิกัดเก่า (Y-Offset: -10, Part Y-Offset: -15)
local TargetCFrame_Old = CFrame.new(
    724.393555, 62.6801376, 1901.39771,
    -0.957089126, -6.17381843e-08, 0.28979376,
    -8.66029453e-08, 1, -7.29779401e-08,
    -0.28979376, -9.49433883e-08, -0.957089126
)

-- CFrame เป้าหมาย: พิกัด "ฟามแร่" (ไม่ลง Y-Offset)
local TargetCFrame_Farm = CFrame.new(
    -41.5633392, 29.1136894, -2473.74438
)

-- CFrame เป้าหมาย: พิกัด "เบอกรถแลนฟ้า" (ไม่ลง Y-Offset)
local TargetCFrame_BlueLand = CFrame.new(
    643.35498, 14.0387993, 3537.69922,
    0.710202157, 8.94103902e-09, 0.703997791,
    7.74575071e-09, 1, -2.05143937e-08,
    -0.703997791, 2.00223571e-08, 0.710202157
)

-- CFrame เป้าหมาย: พิกัด "เบลฟ้า" (ไม่ลง Y-Offset)
local TargetCFrame_BellLand = CFrame.new(
    2005.4425, 14.0649662, 2658.17847,
    0.968953848, -3.06509529e-09, -0.24724175,
    -5.13256904e-09, 1, -3.25119771e-08,
    0.24724175, 3.27715881e-08, 0.968953848
)

-- CFrame เป้าหมาย: พิกัด "เบิกรถโพหิน" (ไม่ลง Y-Offset)
local TargetCFrame_StoneLand = CFrame.new(
    5468.83594, 63.6300659, -3577.27319,
    -0.997944832, -2.59640807e-08, 0.0640791059,
    -2.11583906e-08, 1, 7.56748193e-08,
    -0.0640791059, 7.41634878e-08, -0.997944832
)

-- CFrame เป้าหมาย: พิกัด "โพหิน" (ไม่ลง Y-Offset)
local TargetCFrame_StoneOnly = CFrame.new(
    6146.77832, 48.7627831, -4196.55225,
    0.0105238901, -1.32986188e-05, -0.999944627,
    6.10958568e-06, 1, -1.32350551e-05,
    0.999944627, -5.96996324e-06, 0.0105238901
)

-- ค่าชดเชย Y สำหรับพิกัดเก่า
local FinalCharacterYOffset_Old = -10 
local PartYOffset_Old = -15

-- ค่าชดเชย Y สำหรับพิกัดอื่น (Part เท่านั้น)
local PartYOffset_Other = -10 -- Part จะถูกสร้างที่ Y-10 จากจุดวาป

local PartHeight = 5 
local PartSize = Vector3.new(5, PartHeight, 5) 

--###################################################################################
--# บริการและฟังก์ชันพื้นฐาน
--###################################################################################

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local TweenService = game:GetService("TweenService") 
local UserInputService = game:GetService("UserInputService")

local Color_DarkGrey = Color3.fromRGB(35, 35, 35)
local Color_RedPrimary = Color3.fromRGB(255, 30, 30)
local Color_GreenPrimary = Color3.fromRGB(0, 150, 0)
local Color_BluePrimary = Color3.fromRGB(50, 100, 255) 
local Color_YellowPrimary = Color3.fromRGB(255, 180, 0) 
local Color_PurplePrimary = Color3.fromRGB(150, 50, 255) 
local Color_OrangePrimary = Color3.fromRGB(255, 100, 0) 
local Color_StonePrimary = Color3.fromRGB(150, 150, 150) 
local CornerRadius = UDim.new(0, 8) 
local SmallCornerRadius = UDim.new(0, 5) 

local ToggleKey = Enum.KeyCode.RightControl 

-- ฟังก์ชัน Teleport ทั้ง 6 ฟังก์ชัน (ไม่เปลี่ยนแปลง)
local function TeleportAndCreateOldPart()
    local Character = Player.Character or Player.CharacterAdded:Wait()
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
    if not HumanoidRootPart then warn("HumanoidRootPart not found!"); return end
    local NewCharacterCFrame = TargetCFrame_Old + Vector3.new(0, FinalCharacterYOffset_Old, 0)
    HumanoidRootPart.CFrame = NewCharacterCFrame
    local ExistingPart = game.Workspace:FindFirstChild("ExecutorPart")
    if ExistingPart then ExistingPart:Destroy() end
    local NewPart = Instance.new("Part")
    NewPart.Name = "ExecutorPart"
    NewPart.Anchored = true
    NewPart.CanCollide = true 
    NewPart.Size = PartSize 
    NewPart.BrickColor = BrickColor.new("Bright yellow")
    NewPart.Material = Enum.Material.Neon
    local NewPartCFrame = TargetCFrame_Old + Vector3.new(0, PartYOffset_Old, 0)
    NewPart.CFrame = NewPartCFrame
    NewPart.Parent = game.Workspace
end

local function TeleportAndCreateFarmPart()
    local Character = Player.Character or Player.CharacterAdded:Wait()
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
    if not HumanoidRootPart then warn("HumanoidRootPart not found!"); return end
    local NewCharacterCFrame = TargetCFrame_Farm 
    HumanoidRootPart.CFrame = NewCharacterCFrame
    local ExistingPart = game.Workspace:FindFirstChild("ExecutorPart")
    if ExistingPart then ExistingPart:Destroy() end
    local NewPart = Instance.new("Part")
    NewPart.Name = "ExecutorPart"
    NewPart.Anchored = true
    NewPart.CanCollide = true 
    NewPart.Size = PartSize 
    NewPart.BrickColor = BrickColor.new("Bright red")
    NewPart.Material = Enum.Material.Neon
    local NewPartCFrame = TargetCFrame_Farm + Vector3.new(0, PartYOffset_Other, 0)
    NewPart.CFrame = NewPartCFrame
    NewPart.Parent = game.Workspace
end

local function TeleportAndCreateBlueLandPart()
    local Character = Player.Character or Player.CharacterAdded:Wait()
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
    if not HumanoidRootPart then warn("HumanoidRootPart not found!"); return end
    local NewCharacterCFrame = TargetCFrame_BlueLand 
    HumanoidRootPart.CFrame = NewCharacterCFrame
    local ExistingPart = game.Workspace:FindFirstChild("ExecutorPart")
    if ExistingPart then ExistingPart:Destroy() end
    local NewPart = Instance.new("Part")
    NewPart.Name = "ExecutorPart"
    NewPart.Anchored = true
    NewPart.CanCollide = true 
    NewPart.Size = PartSize 
    NewPart.BrickColor = BrickColor.new("Really blue") 
    NewPart.Material = Enum.Material.Neon
    local NewPartCFrame = TargetCFrame_BlueLand + Vector3.new(0, PartYOffset_Other, 0)
    NewPart.CFrame = NewPartCFrame
    NewPart.Parent = game.Workspace
end

local function TeleportAndCreateBellLandPart()
    local Character = Player.Character or Player.CharacterAdded:Wait()
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
    if not HumanoidRootPart then warn("HumanoidRootPart not found!"); return end
    local NewCharacterCFrame = TargetCFrame_BellLand 
    HumanoidRootPart.CFrame = NewCharacterCFrame
    local ExistingPart = game.Workspace:FindFirstChild("ExecutorPart")
    if ExistingPart then ExistingPart:Destroy() end
    local NewPart = Instance.new("Part")
    NewPart.Name = "ExecutorPart"
    NewPart.Anchored = true
    NewPart.CanCollide = true 
    NewPart.Size = PartSize 
    NewPart.BrickColor = BrickColor.new("Dark violet")
    NewPart.Material = Enum.Material.Neon
    local NewPartCFrame = TargetCFrame_BellLand + Vector3.new(0, PartYOffset_Other, 0)
    NewPart.CFrame = NewPartCFrame
    NewPart.Parent = game.Workspace
end

local function TeleportAndCreateStoneLandPart()
    local Character = Player.Character or Player.CharacterAdded:Wait()
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
    if not HumanoidRootPart then warn("HumanoidRootPart not found!"); return end
    local NewCharacterCFrame = TargetCFrame_StoneLand 
    HumanoidRootPart.CFrame = NewCharacterCFrame
    local ExistingPart = game.Workspace:FindFirstChild("ExecutorPart")
    if ExistingPart then ExistingPart:Destroy() end
    local NewPart = Instance.new("Part")
    NewPart.Name = "ExecutorPart"
    NewPart.Anchored = true
    NewPart.CanCollide = true 
    NewPart.Size = PartSize 
    NewPart.BrickColor = BrickColor.new("Lava")
    NewPart.Material = Enum.Material.Neon
    local NewPartCFrame = TargetCFrame_StoneLand + Vector3.new(0, PartYOffset_Other, 0)
    NewPart.CFrame = NewPartCFrame
    NewPart.Parent = game.Workspace
end

local function TeleportAndCreateStoneOnlyPart()
    local Character = Player.Character or Player.CharacterAdded:Wait()
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
    if not HumanoidRootPart then warn("HumanoidRootPart not found!"); return end
    local NewCharacterCFrame = TargetCFrame_StoneOnly 
    HumanoidRootPart.CFrame = NewCharacterCFrame
    local ExistingPart = game.Workspace:FindFirstChild("ExecutorPart")
    if ExistingPart then ExistingPart:Destroy() end
    local NewPart = Instance.new("Part")
    NewPart.Name = "ExecutorPart"
    NewPart.Anchored = true
    NewPart.CanCollide = true 
    NewPart.Size = PartSize 
    NewPart.BrickColor = BrickColor.new("Medium stone grey") -- สีเทาหิน
    NewPart.Material = Enum.Material.Neon
    local NewPartCFrame = TargetCFrame_StoneOnly + Vector3.new(0, PartYOffset_Other, 0)
    NewPart.CFrame = NewPartCFrame
    NewPart.Parent = game.Workspace
end

--###################################################################################
--# การสร้าง GUI
--###################################################################################

local OldGui = Player.PlayerGui:FindFirstChild("TeteGUI")
if OldGui then OldGui:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TeteGUI"
ScreenGui.Parent = Player.PlayerGui
ScreenGui.DisplayOrder = 999 

-- กำหนดความสูงคงที่ของ GUI ที่มองเห็นได้
local UI_WIDTH = 200
local UI_HEIGHT = 200 -- กำหนดความสูงที่มองเห็นได้

-- 1. สร้าง Shadow Frame (ขนาดตาม UI_HEIGHT ที่จำกัด)
local ShadowFrame = Instance.new("Frame")
ShadowFrame.Size = UDim2.new(0, UI_WIDTH + 4, 0, UI_HEIGHT + 4 + 30) -- +4 สำหรับขอบ, +30 สำหรับ Title Bar
ShadowFrame.Position = UDim2.new(0.5, -(UI_WIDTH/2) - 2, 0.5, -(UI_HEIGHT/2) - 2 - 15) -- ปรับตำแหน่งกลางจอ
ShadowFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ShadowFrame.BackgroundTransparency = 0.5
ShadowFrame.Parent = ScreenGui

local UICorner_Shadow = Instance.new("UICorner")
UICorner_Shadow.CornerRadius = CornerRadius
UICorner_Shadow.Parent = ShadowFrame

-- 2. สร้าง Frame หลัก (Main UI)
local MainFrame = Instance.new("Frame") 
MainFrame.Size = UDim2.new(0, UI_WIDTH, 0, UI_HEIGHT + 30) -- +30 สำหรับ Title Bar
MainFrame.Position = UDim2.new(0.5, -(UI_WIDTH/2), 0.5, -(UI_HEIGHT/2) - 15)
MainFrame.BackgroundColor3 = Color_DarkGrey 
MainFrame.Parent = ScreenGui
MainFrame.Visible = false 

local UICorner_Main = Instance.new("UICorner")
UICorner_Main.CornerRadius = CornerRadius
UICorner_Main.Parent = MainFrame

-- 3. สร้างหัวข้อ (Title Bar)
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundColor3 = Color_RedPrimary
Title.Text = "ระบบวาป By Tete" 
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18 
Title.Parent = MainFrame

-- 4. สร้าง ScrollingFrame สำหรับปุ่มวาป
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Name = "TeleportScrollFrame"
ScrollFrame.Size = UDim2.new(1, 0, 1, -30) -- กินพื้นที่ทั้งหมด ยกเว้น Title Bar
ScrollFrame.Position = UDim2.new(0, 0, 0, 30)
ScrollFrame.BackgroundColor3 = Color_DarkGrey
ScrollFrame.ScrollBarThickness = 6
ScrollFrame.BackgroundTransparency = 1 -- ทำให้พื้นหลังเป็นสีเดียวกับ MainFrame
-- การคำนวณ CanvasSize: (จำนวนปุ่ม * ความสูงปุ่ม) + (จำนวนปุ่ม * Padding)
local NUM_BUTTONS = 6
local BUTTON_HEIGHT = 35
local PADDING_Y = 5
local TOTAL_CONTENT_HEIGHT = (NUM_BUTTONS * BUTTON_HEIGHT) + (NUM_BUTTONS * PADDING_Y) + 5
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, TOTAL_CONTENT_HEIGHT) 
ScrollFrame.Parent = MainFrame

-- 5. เพิ่ม UIListLayout เพื่อจัดเรียงปุ่มอัตโนมัติ
local ListLayout = Instance.new("UIListLayout")
ListLayout.FillDirection = Enum.FillDirection.Vertical
ListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
ListLayout.Padding = UDim.new(0, PADDING_Y) -- ระยะห่างระหว่างปุ่ม
ListLayout.Parent = ScrollFrame

-- 6. สร้างปุ่มทั้งหมด
-- ฟังก์ชันย่อเพื่อสร้างปุ่ม
local function createButton(name, text, color, clickFunction, parent)
    local Button = Instance.new("TextButton")
    Button.Name = name
    -- ใช้ Scale X=1 และ Offset Y ที่กำหนด
    Button.Size = UDim2.new(1, -20, 0, BUTTON_HEIGHT) -- ใช้ 1,-20 เพื่อให้มีขอบซ้ายขวา 10px
    Button.BackgroundColor3 = color
    Button.Text = text
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Font = Enum.Font.SourceSansSemibold
    Button.TextSize = 16
    Button.Parent = parent
    
    local UICorner_Button = Instance.new("UICorner")
    UICorner_Button.CornerRadius = CornerRadius
    UICorner_Button.Parent = Button
    
    Button.MouseButton1Click:Connect(clickFunction)
    
    return Button
end

local TeleportButton_Old = createButton("OldTeleport", "⚡ ปากัวธรรมดา ⚡", Color_GreenPrimary, TeleportAndCreateOldPart, ScrollFrame)
local TeleportButton_Farm = createButton("FarmTeleport", "⛏️ วาปฟามแร่ ⛏️", Color_BluePrimary, TeleportAndCreateFarmPart, ScrollFrame)
local TeleportButton_BlueLand = createButton("BlueLandTeleport", "✨ เบิกรถแลนฟ้า ✨", Color_YellowPrimary, TeleportAndCreateBlueLandPart, ScrollFrame)
local TeleportButton_BellLand = createButton("BellLandTeleport", "🔔 วาปเบลฟ้า 🔔", Color_PurplePrimary, TeleportAndCreateBellLandPart, ScrollFrame)
local TeleportButton_StoneLand = createButton("StoneLandTeleport", "🧱 เบิกรถโพหิน 🧱", Color_OrangePrimary, TeleportAndCreateStoneLandPart, ScrollFrame)
local TeleportButton_StoneOnly = createButton("StoneOnlyTeleport", "🗿 วาปโพหิน 🗿", Color_StonePrimary, TeleportAndCreateStoneOnlyPart, ScrollFrame)


-- GUI ปุ่มเล็กสำหรับสลับการมองเห็น (Toggle Button)
local SmallToggleButton = Instance.new("TextButton")
SmallToggleButton.Name = "SmallToggle"
SmallToggleButton.Size = UDim2.new(0, 70, 0, 30) 
SmallToggleButton.Position = UDim2.new(1, -75, 0, 5) 
SmallToggleButton.BackgroundColor3 = Color_DarkGrey 
SmallToggleButton.Text = "Tete (Open)"
SmallToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SmallToggleButton.Font = Enum.Font.SourceSansBold
SmallToggleButton.TextSize = 14
SmallToggleButton.Parent = ScreenGui

local UICorner_Small = Instance.new("UICorner")
UICorner_Small.CornerRadius = SmallCornerRadius
UICorner_Small.Parent = SmallToggleButton

--###################################################################################
--# การเชื่อมต่อและระบบเปิด/ปิด
--###################################################################################

-- ฟังก์ชันสำหรับสลับการมองเห็น UI หลัก
local function toggleMainUI()
    local currentVisible = MainFrame.Visible
    local newVisible = not currentVisible
    
    MainFrame.Visible = newVisible
    ShadowFrame.Visible = newVisible
    
    if newVisible then
        SmallToggleButton.Text = "Tete (Close)"
    else
        SmallToggleButton.Text = "Tete (Open)"
    end
end

-- เชื่อมต่อปุ่มเล็กกับการคลิก
SmallToggleButton.MouseButton1Click:Connect(toggleMainUI)

-- เชื่อมต่อปุ่มคีย์บอร์ด (RightControl)
UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if input.KeyCode == ToggleKey and not gameProcessedEvent then
        toggleMainUI() 
    end
end)

-- เอฟเฟกต์ Hover
local function setupHover(button, originalColor, hoverColor)
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.15), {BackgroundColor3 = hoverColor}):Play()
    end)
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = originalColor}):Play()
    end)
end

setupHover(TeleportButton_Old, Color_GreenPrimary, Color3.fromRGB(0, 200, 0))
setupHover(TeleportButton_Farm, Color_BluePrimary, Color3.fromRGB(80, 130, 255)) 
setupHover(TeleportButton_BlueLand, Color_YellowPrimary, Color3.fromRGB(255, 210, 50)) 
setupHover(TeleportButton_BellLand, Color_PurplePrimary, Color3.fromRGB(180, 80, 255))
setupHover(TeleportButton_StoneLand, Color_OrangePrimary, Color3.fromRGB(255, 140, 50))
setupHover(TeleportButton_StoneOnly, Color_StonePrimary, Color3.fromRGB(180, 180, 180)) 

--###################################################################################
--# 🖱️ ระบบลาก UI (ใช้ Title ใน MainFrame ลาก)
--###################################################################################

local dragging = false
local dragStartPos = nil
local frameStartPos = nil

Title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStartPos = input.Position
        frameStartPos = MainFrame.Position
        
        ScreenGui.DisplayOrder = 1000 
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStartPos
        local newX = frameStartPos.X.Scale + delta.X / MainFrame.Parent.AbsoluteSize.X
        local newY = frameStartPos.Y.Scale + delta.Y / MainFrame.Parent.AbsoluteSize.Y
        
        MainFrame.Position = UDim2.new(newX, 0, newY, 0)
        ShadowFrame.Position = UDim2.new(newX, 2, newY, 2) 
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
        ScreenGui.DisplayOrder = 999 
    end
end)
