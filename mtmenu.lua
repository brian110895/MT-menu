-- =============================================
-- MT Menu | by MTmodder
-- Key: MTmodder
-- =============================================

local key = "MTmodder"

print("🔑 MT Menu carregado!")

local userKey = key

if userKey ~= key then
    game.Players.LocalPlayer:Kick("❌ Key inválida! Use: MTmodder")
    return
end

print("✅ Key correta! Iniciando MT Menu...")

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("MT Menu", "DarkTheme")

local Tab1 = Window:NewTab("Principal")
local Tab2 = Window:NewTab("Player")
local Tab3 = Window:NewTab("Combat")
local Tab4 = Window:NewTab("Visual")
local Tab5 = Window:NewTab("Diversos")

-- Principal
local Section1 = Tab1:NewSection("MT Menu - Bem-vindo!")
Section1:NewButton("Testar Menu", "Clique para testar", function()
    game.StarterGui:SetCore("SendNotification", {Title = "MT Menu"; Text = "Funcionando perfeitamente!"; Duration = 5;})
end)
Section1:NewLabel("Key: MTmodder")

-- Player
local Section2 = Tab2:NewSection("Player")
Section2:NewSlider("Velocidade", "WalkSpeed", 500, 16, 500, function(s) pcall(function() game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s end) end)
Section2:NewSlider("Pulo", "JumpPower", 200, 50, 200, function(s) pcall(function() game.Players.LocalPlayer.Character.Humanoid.JumpPower = s end) end)
Section2:NewToggle("Godmode", "Anti-Morte", false, function(state)
    pcall(function() if state then game.Players.LocalPlayer.Character.Humanoid.Health = math.huge; game.Players.LocalPlayer.Character.Humanoid.MaxHealth = math.huge end end)
end)

-- Combat
local SectionCombat = Tab3:NewSection("Combat")

local aimbotEnabled = false
local aimbotConnection = nil

local function getClosestPlayer()
    local closest, dist = nil, math.huge
    local lp = game.Players.LocalPlayer
    local root = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= lp and p.Character and p.Character:FindFirstChild("Head") then
            local d = (p.Character.Head.Position - root.Position).Magnitude
            if d < dist then dist = d; closest = p end
        end
    end
    return closest
end

SectionCombat:NewToggle("Aimbot (Visível)", "Mira automática na câmera", false, function(state)
    aimbotEnabled = state
    if state then
        aimbotConnection = game:GetService("RunService").RenderStepped:Connect(function()
            if aimbotEnabled then
                local target = getClosestPlayer()
                if target and target.Character and target.Character.Head then
                    workspace.CurrentCamera.CFrame = CFrame.lookAt(workspace.CurrentCamera.CFrame.Position, target.Character.Head.Position)
                end
            end
        end)
    else
        if aimbotConnection then aimbotConnection:Disconnect() end
    end
end)

SectionCombat:NewToggle("Silent Aim", "Atira sem mover mira", false, function(state)
    print("Silent Aim " .. (state and "ON" or "OFF"))
end)

SectionCombat:NewSlider("FOV", "Campo de Visão", 120, 70, 120, function(s)
    pcall(function() workspace.CurrentCamera.FieldOfView = s end)
end)

-- Visual
local Section3 = Tab4:NewSection("Visual")
Section3:NewButton("Full Bright", "Iluminação máxima", function()
    game.Lighting.Brightness = 2
    game.Lighting.ClockTime = 14
    game.Lighting.FogEnd = 100000
end)

-- Diversos
local Section4 = Tab5:NewSection("Diversos")
Section4:NewButton("Rejoin", "Voltar ao servidor", function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
end)
Section4:NewButton("Destruir Menu", "Fechar menu", function()
    pcall(function() game.CoreGui["MT Menu"]:Destroy() end)
end)

print("🎉 MT Menu carregado com sucesso!")
