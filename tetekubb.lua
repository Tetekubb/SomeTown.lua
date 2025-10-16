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

-- 🌟 [เพิ่ม] CFrame เป้าหมาย: พิกัด "โพหิน" (ไม่ลง Y-Offset)
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
local Color_StonePrimary = Color3.fromRGB(150, 150, 150) -- 🌟 สีใหม่สำหรับปุ่มโพหิน
local CornerRadius = UDim.new(0, 8) 
local SmallCornerRadius = UDim.new(0, 5) 

local ToggleKey = Enum.KeyCode.RightControl 

-- ฟังก์ชันสำหรับ Teleport และสร้าง Part (สำหรับพิกัดเก่า: ลง Y-10)
local function TeleportAndCreateOldPart()
    local Character = Player.Character or Player.CharacterAdded:Wait()
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

    if not HumanoidRootPart then 
        warn("HumanoidRootPart not found!")
        return 
    end

    -- 1. วาปตัวละคร: ใช้ FinalCharacterYOffset_Old (-10)
    local NewCharacterCFrame = TargetCFrame_Old + Vector3.new(0, FinalCharacterYOffset_Old, 0)
    HumanoidRootPart.CFrame = NewCharacterCFrame

    -- 2. สร้าง Part 
    local ExistingPart = game.Workspace:FindFirstChild("ExecutorPart")
    if ExistingPart then ExistingPart:Destroy() end
    
    local NewPart = Instance.new("Part")
    NewPart.Name = "ExecutorPart"
    NewPart.Anchored = true
    NewPart.CanCollide = true 
    NewPart.Size = PartSize 
    NewPart.BrickColor = BrickColor.new("Bright yellow")
    NewPart.Material = Enum.Material.Neon
    
    -- ใช้ PartYOffset_Old (-15)
    local NewPartCFrame = TargetCFrame_Old + Vector3.new(0, PartYOffset_Old, 0)
    NewPart.CFrame = NewPartCFrame
    NewPart.Parent = game.Workspace
end

-- ฟังก์ชันสำหรับ Teleport และสร้าง Part (สำหรับพิกัด "ฟามแร่": ไม่ลง Y)
local function TeleportAndCreateFarmPart()
    local Character = Player.Character or Player.CharacterAdded:Wait()
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

    if not HumanoidRootPart then 
        warn("HumanoidRootPart not found!")
        return 
    end

    -- 1. วาปตัวละคร: วาปตรงพิกัด Y (ไม่มีการชดเชย)
    local NewCharacterCFrame = TargetCFrame_Farm 
    HumanoidRootPart.CFrame = NewCharacterCFrame

    -- 2. สร้าง Part 
    local ExistingPart = game.Workspace:FindFirstChild("ExecutorPart")
    if ExistingPart then ExistingPart:Destroy() end
    
    local NewPart = Instance.new("Part")
    NewPart.Name = "ExecutorPart"
    NewPart.Anchored = true
    NewPart.CanCollide = true 
    NewPart.Size = PartSize 
    NewPart.BrickColor = BrickColor.new("Bright red")
    NewPart.Material = Enum.Material.Neon
    
    -- Part ฟามแร่ ใช้ Y-Offset -10
    local NewPartCFrame = TargetCFrame_Farm + Vector3.new(0, PartYOffset_Other, 0)
    NewPart.CFrame = NewPartCFrame
    NewPart.Parent = game.Workspace
end

-- ฟังก์ชันสำหรับ Teleport และสร้าง Part (สำหรับพิกัด "เบอกรถแลนฟ้า": ไม่ลง Y)
local function TeleportAndCreateBlueLandPart()
    local Character = Player.Character or Player.CharacterAdded:Wait()
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

    if not HumanoidRootPart then 
        warn("HumanoidRootPart not found!")
        return 
    end

    -- 1. วาปตัวละคร: วาปตรงพิกัด Y (ไม่มีการชดเชย)
    local NewCharacterCFrame = TargetCFrame_BlueLand 
    HumanoidRootPart.CFrame = NewCharacterCFrame

    -- 2. สร้าง Part 
    local ExistingPart = game.Workspace:FindFirstChild("ExecutorPart")
    if ExistingPart then ExistingPart:Destroy() end
    
    local NewPart = Instance.new("Part")
    NewPart.Name = "ExecutorPart"
    NewPart.Anchored = true
    NewPart.CanCollide = true 
    NewPart.Size = PartSize 
    NewPart.BrickColor = BrickColor.new("Really blue") 
    NewPart.Material = Enum.Material.Neon
    
    -- Part เบอกรถแลนฟ้า ใช้ Y-Offset -10
    local NewPartCFrame = TargetCFrame_BlueLand + Vector3.new(0, PartYOffset_Other, 0)
    NewPart.CFrame = NewPartCFrame
    NewPart.Parent = game.Workspace
end

-- ฟังก์ชันสำหรับ Teleport และสร้าง Part (สำหรับพิกัด "เบลฟ้า": ไม่ลง Y)
local function TeleportAndCreateBellLandPart()
    local Character = Player.Character or Player.CharacterAdded:Wait()
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

    if not HumanoidRootPart then 
        warn("HumanoidRootPart not found!")
        return 
    end

    -- 1. วาปตัวละคร: วาปตรงพิกัด Y (ไม่มีการชดเชย)
    local NewCharacterCFrame = TargetCFrame_BellLand 
    HumanoidRootPart.CFrame = NewCharacterCFrame

    -- 2. สร้าง Part 
    local ExistingPart = game.Workspace:FindFirstChild("ExecutorPart")
    if ExistingPart then ExistingPart:Destroy() end
    
    local NewPart = Instance.new("Part")
    NewPart.Name = "ExecutorPart"
    NewPart.Anchored = true
    NewPart.CanCollide = true 
    NewPart.Size = PartSize 
    NewPart.BrickColor = BrickColor.new("Dark violet") -- สีม่วงเข้ม
    NewPart.Material = Enum.Material.Neon
    
    -- Part เบลฟ้า ใช้ Y-Offset -10
    local NewPartCFrame = TargetCFrame_BellLand + Vector3.new(0, PartYOffset_Other, 0)
    NewPart.CFrame = NewPartCFrame
    NewPart.Parent = game.Workspace
end

-- ฟังก์ชันสำหรับ Teleport และสร้าง Part (สำหรับพิกัด "เบิกรถโพหิน": ไม่ลง Y)
local function TeleportAndCreateStoneLandPart()
    local Character = Player.Character or Player.CharacterAdded:Wait()
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

    if not HumanoidRootPart then 
        warn("HumanoidRootPart not found!")
        return 
    end

    -- 1. วาปตัวละคร: วาปตรงพิกัด Y (ไม่มีการชดเชย)
    local NewCharacterCFrame = TargetCFrame_StoneLand 
    HumanoidRootPart.CFrame = NewCharacterCFrame

    -- 2. สร้าง Part 
    local ExistingPart = game.Workspace:FindFirstChild("ExecutorPart")
    if ExistingPart then ExistingPart:Destroy() end
    
    local NewPart = Instance.new("Part")
    NewPart.Name = "ExecutorPart"
    NewPart.Anchored = true
    NewPart.CanCollide = true 
    NewPart.Size = PartSize 
    NewPart.BrickColor = BrickColor.new("Lava") -- สีส้ม/หิน
    NewPart.Material = Enum.Material.Neon
    
    -- Part เบิกรถโพหิน ใช้ Y-Offset -10
    local NewPartCFrame = TargetCFrame_StoneLand + Vector3.new(0, PartYOffset_Other, 0)
    NewPart.CFrame = NewPartCFrame
    NewPart.Parent = game.Workspace
end

-- 🌟 [เพิ่ม] ฟังก์ชันสำหรับ Teleport และสร้าง Part (สำหรับพิกัด "โพหิน": ไม่ลง Y)
local function TeleportAndCreateStoneOnlyPart()
    local Character = Player.Character or Player.CharacterAdded:Wait()
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

    if not HumanoidRootPart then 
        warn("HumanoidRootPart not found!")
        return 
    end

    -- 1. วาปตัวละคร: วาปตรงพิกัด Y (ไม่มีการชดเชย)
    local NewCharacterCFrame = TargetCFrame_StoneOnly 
    HumanoidRootPart.CFrame = NewCharacterCFrame

    -- 2. สร้าง Part 
    local ExistingPart = game.Workspace:FindFirstChild("ExecutorPart")
    if ExistingPart then ExistingPart:Destroy() end
    
    local NewPart = Instance.new("Part")
    NewPart.Name = "ExecutorPart"
    NewPart.Anchored = true
    NewPart.CanCollide = true 
    NewPart.Size = PartSize 
    NewPart.BrickColor = BrickColor.new("Medium stone grey") -- สีเทาหิน
    NewPart.Material = Enum.Material.Neon
    
    -- Part โพหิน ใช้ Y-Offset -10
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

-- 1. สร้าง Shadow Frame
-- 📐 ปรับความสูง: จาก 264 เป็น 304 (เพิ่มพื้นที่สำหรับปุ่มที่ 6)
local ShadowFrame = Instance.new("Frame")
ShadowFrame.Size = UDim2.new(0, 204, 0, 304) 
ShadowFrame.Position = UDim2.new(0.5, -102, 0.5, -153.5) -- ปรับตำแหน่งกลางจอ
ShadowFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ShadowFrame.BackgroundTransparency = 0.5
ShadowFrame.Parent = ScreenGui

local UICorner_Shadow = Instance.new("UICorner")
UICorner_Shadow.CornerRadius = CornerRadius
UICorner_Shadow.Parent = ShadowFrame

-- 2. สร้าง Frame หลัก (Main UI)
-- 📐 ปรับความสูง: จาก 260 เป็น 300
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 200, 0, 300) 
MainFrame.Position = UDim2.new(0.5, -100, 0.5, -150) -- ปรับตำแหน่งกลางจอ
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

-- 4. สร้างปุ่มทั้งหมด
local ButtonHeightScale = 0.12 -- ปรับสเกลปุ่มเพื่อรองรับ 6 ปุ่ม (ประมาณ 12%)

-- สร้างปุ่มสำหรับ Teleport (เก่า)
local TeleportButton_Old = Instance.new("TextButton")
TeleportButton_Old.Name = "OldTeleport"
TeleportButton_Old.Size = UDim2.new(0.8, 0, ButtonHeightScale, 0) 
TeleportButton_Old.Position = UDim2.new(0.1, 0, 0.15, 0) -- ตำแหน่ง 1 (ปรับใหม่)
TeleportButton_Old.BackgroundColor3 = Color_GreenPrimary
TeleportButton_Old.Text = "⚡ ปากัวธรรมดา ⚡" 
TeleportButton_Old.TextColor3 = Color3.fromRGB(255, 255, 255)
TeleportButton_Old.Font = Enum.Font.SourceSansSemibold
TeleportButton_Old.TextSize = 13 
TeleportButton_Old.Parent = MainFrame

local UICorner_Button_Old = Instance.new("UICorner")
UICorner_Button_Old.CornerRadius = CornerRadius
UICorner_Button_Old.Parent = TeleportButton_Old

-- สร้างปุ่มสำหรับ Teleport (ฟามแร่)
local TeleportButton_Farm = Instance.new("TextButton")
TeleportButton_Farm.Name = "FarmTeleport"
TeleportButton_Farm.Size = UDim2.new(0.8, 0, ButtonHeightScale, 0)
TeleportButton_Farm.Position = UDim2.new(0.1, 0, 0.29, 0) -- ตำแหน่ง 2
TeleportButton_Farm.BackgroundColor3 = Color_BluePrimary
TeleportButton_Farm.Text = "⛏️ วาปฟามแร่ ⛏️" 
TeleportButton_Farm.TextColor3 = Color3.fromRGB(255, 255, 255)
TeleportButton_Farm.Font = Enum.Font.SourceSansSemibold
TeleportButton_Farm.TextSize = 16
TeleportButton_Farm.Parent = MainFrame

local UICorner_Button_Farm = Instance.new("UICorner")
UICorner_Button_Farm.CornerRadius = CornerRadius
UICorner_Button_Farm.Parent = TeleportButton_Farm

-- สร้างปุ่มสำหรับ Teleport (เบอกรถแลนฟ้า)
local TeleportButton_BlueLand = Instance.new("TextButton")
TeleportButton_BlueLand.Name = "BlueLandTeleport"
TeleportButton_BlueLand.Size = UDim2.new(0.8, 0, ButtonHeightScale, 0)
TeleportButton_BlueLand.Position = UDim2.new(0.1, 0, 0.43, 0) -- ตำแหน่ง 3
TeleportButton_BlueLand.BackgroundColor3 = Color_YellowPrimary
TeleportButton_BlueLand.Text = "✨ เบิกรถแลนฟ้า ✨" 
TeleportButton_BlueLand.TextColor3 = Color3.fromRGB(255, 255, 255)
TeleportButton_BlueLand.Font = Enum.Font.SourceSansSemibold
TeleportButton_BlueLand.TextSize = 15
TeleportButton_BlueLand.Parent = MainFrame

local UICorner_Button_BlueLand = Instance.new("UICorner")
UICorner_Button_BlueLand.CornerRadius = CornerRadius
UICorner_Button_BlueLand.Parent = TeleportButton_BlueLand

-- สร้างปุ่มสำหรับ Teleport (เบลฟ้า)
local TeleportButton_BellLand = Instance.new("TextButton")
TeleportButton_BellLand.Name = "BellLandTeleport"
TeleportButton_BellLand.Size = UDim2.new(0.8, 0, ButtonHeightScale, 0)
TeleportButton_BellLand.Position = UDim2.new(0.1, 0, 0.57, 0) -- ตำแหน่ง 4
TeleportButton_BellLand.BackgroundColor3 = Color_PurplePrimary
TeleportButton_BellLand.Text = "🔔 วาปเบลฟ้า 🔔" 
TeleportButton_BellLand.TextColor3 = Color3.fromRGB(255, 255, 255)
TeleportButton_BellLand.Font = Enum.Font.SourceSansSemibold
TeleportButton_BellLand.TextSize = 16
TeleportButton_BellLand.Parent = MainFrame

local UICorner_Button_BellLand = Instance.new("UICorner")
UICorner_Button_BellLand.CornerRadius = CornerRadius
UICorner_Button_BellLand.Parent = TeleportButton_BellLand

-- สร้างปุ่มสำหรับ Teleport (เบิกรถโพหิน)
local TeleportButton_StoneLand = Instance.new("TextButton")
TeleportButton_StoneLand.Name = "StoneLandTeleport"
TeleportButton_StoneLand.Size = UDim2.new(0.8, 0, ButtonHeightScale, 0)
TeleportButton_StoneLand.Position = UDim2.new(0.1, 0, 0.71, 0) -- ตำแหน่ง 5
TeleportButton_StoneLand.BackgroundColor3 = Color_OrangePrimary
TeleportButton_StoneLand.Text = "🧱 เบิกรถโพหิน 🧱" 
TeleportButton_StoneLand.TextColor3 = Color3.fromRGB(255, 255, 255)
TeleportButton_StoneLand.Font = Enum.Font.SourceSansSemibold
TeleportButton_StoneLand.TextSize = 16
TeleportButton_StoneLand.Parent = MainFrame

local UICorner_Button_StoneLand = Instance.new("UICorner")
UICorner_Button_StoneLand.CornerRadius = CornerRadius
UICorner_Button_StoneLand.Parent = TeleportButton_StoneLand

-- 🌟 [เพิ่ม] สร้างปุ่มสำหรับ Teleport (โพหิน)
local TeleportButton_StoneOnly = Instance.new("TextButton")
TeleportButton_StoneOnly.Name = "StoneOnlyTeleport"
TeleportButton_StoneOnly.Size = UDim2.new(0.8, 0, ButtonHeightScale, 0)
TeleportButton_StoneOnly.Position = UDim2.new(0.1, 0, 0.85, 0) -- ตำแหน่ง 6
TeleportButton_StoneOnly.BackgroundColor3 = Color_StonePrimary
TeleportButton_StoneOnly.Text = "🗿 วาปโพหิน 🗿" 
TeleportButton_StoneOnly.TextColor3 = Color3.fromRGB(255, 255, 255)
TeleportButton_StoneOnly.Font = Enum.Font.SourceSansSemibold
TeleportButton_StoneOnly.TextSize = 16
TeleportButton_StoneOnly.Parent = MainFrame

local UICorner_Button_StoneOnly = Instance.new("UICorner")
UICorner_Button_StoneOnly.CornerRadius = CornerRadius
UICorner_Button_StoneOnly.Parent = TeleportButton_StoneOnly


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

-- 🌟 เชื่อมต่อฟังก์ชัน Teleport ทั้งหมด
TeleportButton_Old.MouseButton1Click:Connect(TeleportAndCreateOldPart)
TeleportButton_Farm.MouseButton1Click:Connect(TeleportAndCreateFarmPart) 
TeleportButton_BlueLand.MouseButton1Click:Connect(TeleportAndCreateBlueLandPart) 
TeleportButton_BellLand.MouseButton1Click:Connect(TeleportAndCreateBellLandPart)
TeleportButton_StoneLand.MouseButton1Click:Connect(TeleportAndCreateStoneLandPart)
TeleportButton_StoneOnly.MouseButton1Click:Connect(TeleportAndCreateStoneOnlyPart) -- ปุ่มใหม่

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
setupHover(TeleportButton_StoneOnly, Color_StonePrimary, Color3.fromRGB(180, 180, 180)) -- Hover สีใหม่

--###################################################################################
--# 🖱️ ระบบลาก UI 
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
