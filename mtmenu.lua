-- =============================================
-- MT MENU - VERSÃO COMPLETA 2026
-- Key: MTmodder1 até MTmodder1000
-- =============================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- ==================== KEY SYSTEM ====================
local keys = {}
for i = 1, 1000 do
    keys["MTmodder" .. i] = {tipo = "permanente", deviceId = nil}
end

local function validarKey(inputKey)
    local data = keys[inputKey]
    if not data then return false, "❌ Key inválida!" end
    local deviceId = tostring(LocalPlayer.UserId)
    if data.deviceId and data.deviceId ~= deviceId then
        return false, "❌ Key já usada em outro dispositivo!"
    end
    if not data.deviceId then data.deviceId = deviceId end
    return true, "✅ Acesso Liberado!"
end

-- ==================== NOTIFICAÇÃO ====================
local function notificar(titulo, mensagem, duracao)
    duracao = duracao or 3
    local gui = Instance.new("ScreenGui", CoreGui)
    local frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(0, 280, 0, 100)
    frame.Position = UDim2.new(0, 10, 0, 10)
    frame.BackgroundColor3 = Color3.fromRGB(0, 45, 90)
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1,0,0,30); title.BackgroundTransparency = 1
    title.Text = titulo; title.TextColor3 = Color3.fromRGB(255,255,255)
    title.Font = Enum.Font.GothamBold; title.TextSize = 16

    local msg = Instance.new("TextLabel", frame)
    msg.Size = UDim2.new(1,0,0,70); msg.Position = UDim2.new(0,0,0,30)
    msg.BackgroundTransparency = 1; msg.TextWrapped = true
    msg.Text = mensagem; msg.TextColor3 = Color3.fromRGB(255,255,255)
    msg.Font = Enum.Font.Gotham; msg.TextSize = 14

    task.delay(duracao, function() gui:Destroy() end)
end

-- ==================== VARIÁVEIS ====================
local aimbotPC = false
local aimbotMobile = false
local aimFOV = 100
local esp = false
local hitboxExpandidaAtiva = false
local hitboxScaleValue = 5
local hitboxOriginalSizes = {}
local noclip = false
local SavedPosition = nil
local teleportAutoAtivo = false
local autoFarmGari = false
local autoFarmMineracao = false
local autoFarmFazenda = false
local autoFarmPecas = false
local autoFarmGas = false
local autoClick = false
local injetarFarms = false
local revistarToggle = false

local teleportLocations = {
    {Name="Praça", CFrame=CFrame.new(-291.58,3.26,342.19)},
    {Name="Gás", CFrame=CFrame.new(-469.96,3.25,-54.39)},
    {Name="Gari", CFrame=CFrame.new(-518.67,3.17,-1.17)},
    {Name="Mineração", CFrame=CFrame.new(201.93,2.76,145.51)},
    {Name="Fazenda", CFrame=CFrame.new(817.24,3.26,-87.32)},
    {Name="Banco", CFrame=CFrame.new(-27.27,11.57,418.20)},
}

-- ==================== KEY GUI ====================
local keyGui = Instance.new("ScreenGui", CoreGui)
keyGui.ResetOnSpawn = false

local kFrame = Instance.new("Frame", keyGui)
kFrame.Size = UDim2.new(0, 360, 0, 220)
kFrame.Position = UDim2.new(0.5, -180, 0.5, -110)
kFrame.BackgroundColor3 = Color3.fromRGB(0,40,85)
Instance.new("UICorner", kFrame).CornerRadius = UDim.new(0,10)

local title = Instance.new("TextLabel", kFrame)
title.Text = "🔑 MT MENU"; title.Size = UDim2.new(1,0,0,50)
title.BackgroundTransparency = 1; title.TextColor3 = Color3.fromRGB(255,255,255)
title.Font = Enum.Font.GothamBold; title.TextSize = 24

local textbox = Instance.new("TextBox", kFrame)
textbox.Size = UDim2.new(0.8,0,0,45); textbox.Position = UDim2.new(0.1,0,0.35,0)
textbox.PlaceholderText = "MTmodder1"; textbox.BackgroundColor3 = Color3.fromRGB(0,70,130)
Instance.new("UICorner", textbox).CornerRadius = UDim.new(0,6)

local confirm = Instance.new("TextButton", kFrame)
confirm.Text = "ENTRAR"; confirm.Size = UDim2.new(0.6,0,0,40)
confirm.Position = UDim2.new(0.2,0,0.65,0); confirm.BackgroundColor3 = Color3.fromRGB(0,120,255)
Instance.new("UICorner", confirm).CornerRadius = UDim.new(0,6)

confirm.MouseButton1Click:Connect(function()
    local success, msg = validarKey(textbox.Text)
    if success then
        notificar("✅ Sucesso", msg, 4)
        keyGui:Destroy()
        CreateMainMenu()
    else
        notificar("❌ Erro", msg, 4)
    end
end)

notificar("MT Menu", "Script carregado! Digite MTmodder1", 6)

-- ==================== MENU PRINCIPAL COM ABAS ====================
function CreateMainMenu()
    local ScreenGui = Instance.new("ScreenGui", CoreGui)
    ScreenGui.Name = "MTMenu"
    ScreenGui.ResetOnSpawn = false

    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 700, 0, 450)
    MainFrame.Position = UDim2.new(0.5, -350, 0.5, -225)
    MainFrame.BackgroundColor3 = Color3.fromRGB(0, 40, 85)
    MainFrame.Active = true
    MainFrame.Draggable = true
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

    local Title = Instance.new("TextLabel", MainFrame)
    Title.Text = "MT MENU"
    Title.Size = UDim2.new(1,0,0,50)
    Title.BackgroundTransparency = 1
    Title.TextColor3 = Color3.fromRGB(255,255,255)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 26

    -- Abas
    local tabs = {"Combate", "ESP", "Teleporte
