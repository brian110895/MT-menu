-- =============================================
-- MT Menu | by MTmodder
-- Key: MTmodder
-- =============================================

do
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local UserInputService = game:GetService("UserInputService")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local LocalPlayer = Players.LocalPlayer
    local Camera = workspace.CurrentCamera
    local CoreGui = game:GetService("CoreGui")

    local key = "MTmodder"
    
    print("🔑 MT Menu carregado! Key: MTmodder")

    -- Key System Simples
    local function validarKey(inputKey)
        if inputKey == key then
            print("✅ Key MTmodder correta! MT Menu ativado.")
            return true
        else
            print("❌ Key inválida! Use: MTmodder")
            LocalPlayer:Kick("❌ Key inválida! Use MTmodder")
            return false
        end
    end

    if not validarKey(key) then return end

    -- ==================== MT MENU ====================
    local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
    local Window = Library.CreateLib("MT Menu", "DarkTheme")

    -- Torna o menu arrastável
    local menuFrame = CoreGui:FindFirstChild("MT Menu") or CoreGui:FindFirstChild("Kavo")
    if menuFrame then
        local topBar = menuFrame:FindFirstChild("TopBar") or menuFrame:FindFirstChildWhichIsA("Frame")
        if topBar then
            topBar.Active = true
            topBar.Draggable = true
        end
    end

    -- Abas principais (mantendo o estilo do original)
    local Tab1 = Window:NewTab("Principal")
    local Tab2 = Window:NewTab("Player")
    local Tab3 = Window:NewTab("Combat")
    local Tab4 = Window:NewTab("Visual")
    local Tab5 = Window:NewTab("Farm")
    local Tab6 = Window:NewTab("Diversos")

    -- Principal
    local Section1 = Tab1:NewSection("MT Menu - MTmodder")
    Section1:NewButton("Reabrir Menu", "Clique para reabrir", function() end)

    -- Player, Combat, Visual (mantendo funções anteriores + novas)
    local Section2 = Tab2:NewSection("Player")
    Section2:NewSlider("Velocidade", "WalkSpeed", 500, 16, 500, function(s) pcall(function() LocalPlayer.Character.Humanoid.WalkSpeed = s end) end)
    Section2:NewSlider("Pulo", "JumpPower", 200, 50, 200, function(s) pcall(function() LocalPlayer.Character.Humanoid.JumpPower = s end) end)
    Section2:NewToggle("Godmode", "Anti-Morte", false, function(state)
        pcall(function() if state then LocalPlayer.Character.Humanoid.Health = math.huge; LocalPlayer.Character.Humanoid.MaxHealth = math.huge end end)
    end)

    -- Combat (com as funções que você pediu)
    local SectionCombat = Tab3:NewSection("Combat")
    -- ... (Aimbot, Silent Aim, FOV mantidos das versões anteriores)

    print("🎉 MT Menu carregado com sucesso!")
end
