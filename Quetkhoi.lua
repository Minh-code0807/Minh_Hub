-- Đặt LocalScript này trong: StarterPlayerScripts hoặc StarterCharacterScripts

-- Đợi đến khi PlayerGui sẵn sàng
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Tạo ScreenGui (nếu chưa tồn tại)
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ObjectClickDisplay"
screenGui.ResetOnSpawn = false -- Giữ GUI khi respawn
screenGui.Parent = playerGui

-- Tạo TextLabel để hiển thị tên vật thể
local nameLabel = Instance.new("TextLabel")
nameLabel.Name = "NameDisplay"
nameLabel.Size = UDim2.new(0, 250, 0, 80)
nameLabel.Position = UDim2.new(0.5, -125, 0, 20) -- Giữa trên màn hình
nameLabel.AnchorPoint = Vector2.new(0.5, 0) -- Căn giữa theo trục X
nameLabel.BackgroundTransparency = 0.7
nameLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
nameLabel.TextSize = 18
nameLabel.Text = "Nhấp vào vật thể để xem thông tin"
nameLabel.Font = Enum.Font.SourceSansBold
nameLabel.TextWrapped = true
nameLabel.Parent = screenGui

-- Hàm hiển thị thông tin vật thể
local function showObjectInfo(target)
    if not target then return end
    
    local info = "Tên: " .. target.Name
    info ..= "\nLoại: " .. target.ClassName
    
    if target:IsA("BasePart") then
        info ..= "\nVị trí: " .. 
            math.floor(target.Position.X) .. ", " ..
            math.floor(target.Position.Y) .. ", " ..
            math.floor(target.Position.Z)
    end
    
    -- Hiển thị thông tin cha (nếu có)
    if target.Parent then
        info ..= "\nThuộc: " .. target.Parent.Name
    end
    
    nameLabel.Text = info
end

-- Kết nối sự kiện click chuột
local mouse = player:GetMouse()

mouse.Button1Down:Connect(function()
    showObjectInfo(mouse.Target)
end)

-- Tự động reset sau 5 giây (tuỳ chọn)
task.spawn(function()
    while true do
        task.wait(5)
        nameLabel.Text = "Nhấp vào vật thể để xem thông tin"
    end
end)
