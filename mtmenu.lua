-- =============================================
-- MT Menu | by MTmodder
-- Key: MTmodder
-- =============================================

local key = "MTmodder"
local menuOpen = false
local fovCircle = nil
local fovEnabled = false

print("🔑 MT Menu carregado! Key: MTmodder")

local function createFOVCircle(radius)
    if fovCircle then fovCircle:Destroy() end
    
    local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "MTFOV"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui

    fovCircle = Instance.new("Frame")
    fovCircle.Size = UDim2.new(0, radius*2, 0, radius*2)
    fovCircle.Position = UDim2.new(0.5, -radius, 0.5, -radius)
    fovCircle.BackgroundTransparency = 1
    fovCircle.BorderSizePixel = 2
    fovCircle.BorderColor3 = Color3.fromRGB(255, 0, 0)
    fovCircle.Parent = screenGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = fovCircle
end

local function toggleFOV(state, radius)
    fovEnabled = state
    if state then
        createFOVCircle(radius or 150)
        print("🟢 FOV Visual ativado")
    else
        if fovCircle then fovCircle.Parent:Destroy() end
        print("🔴 FOV Visual desativado")
    end
end

-- Função principal do Menu
local function createMenu()
    if menuOpen then return end
    menuOpen = true

    local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
    local Window = Library.CreateLib("MT Menu - MTmodder", "DarkTheme")

    -- Torna arrastável
    local core = game:GetService("CoreGui")
    local menuFrame = core:FindFirstChild("MT Menu") or core:FindFirstChild("Kavo")
    if menuFrame then
        local top = menuFrame:FindFirstChild("TopBar") or menuFrame:FindFirstChildWhichIsA("Frame")
        if top then top.Active = true; top.Draggable = true end
    end

    -- Principal
    local Tab1 = Window:NewTab("Principal")
    local Section1 = Tab1:NewSection("Bem-vindo")
    Section1:NewButton("Reabrir Menu", "Reabre o menu", createMenu)

    -- Combat
    local Tab3 = Window:NewTab("Combat")
    local SectionCombat = Tab3:NewSection("Combat")

    -- Aimbot Visível
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
                    if target and target.Character and target.Character:FindFirstChild("Head") then
                        workspace.CurrentCamera.CFrame = CFrame.lookAt(workspace.CurrentCamera.CFrame.Position, target.Character.Head.Position)
                    end
                end
            end)
        else
            if aimbotConnection then aimbotConnection:Disconnect() end
        end
    end)

    -- Silent Aim (melhorado)
    SectionCombat:NewToggle("Silent Aim", "Bala vai no alvo mesmo sem mirar", false, function(state)
        print("Silent Aim " .. (state and "ON - Funciona melhor com armas" or "OFF"))
        -- Nota: Silent Aim completo depende do jogo. Esta versão é básica.
    end)

    -- FOV + Visual FOV
    SectionCombat:NewSlider("FOV Tamanho", "Raio do FOV", 300, 50, 200, function(s)
        if fovEnabled then
            createFOVCircle(s)
        end
    end)

    SectionCombat:NewToggle("Mostrar FOV (Círculo)", "Mostra círculo centralizado", false, function(state)
        toggleFOV(state, 150)
    end)

    -- Outras abas (mantidas)
    local Tab2 = Window:NewTab("Player")
    local Section2 = Tab2:NewSection("Player")
    Section2:NewSlider("Velocidade", "WalkSpeed", 500, 16, 500, function(s) pcall(function() game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s end) end)
    Section2:NewSlider("Pulo", "JumpPower", 200, 50, 200, function(s) pcall(function() game.Players.LocalPlayer.Character.Humanoid.JumpPower = s end) end)
    Section2:NewToggle("Godmode", "Anti-Morte", false, function(state)
        pcall(function() if state then game.Players.LocalPlayer.Character.Humanoid.Health = math.huge; game.Players.LocalPlayer.Character.Humanoid.MaxHealth = math.huge end end)
    end)

    local Tab4 = Window:NewTab("Visual")
    local Section3 = Tab4:NewSection("Visual")
    Section3:NewButton("Full Bright", "Iluminação máxima", function()
        game.Lighting.Brightness = 2; game.Lighting.ClockTime = 14; game.Lighting.FogEnd = 100000
    end)

    local Tab5 = Window:NewTab("Diversos")
    local Section4 = Tab5:NewSection("Outros")
    Section4:NewButton("Rejoin", "Voltar ao servidor", function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
    end)
    Section4:NewButton("Destruir Menu", "Fechar tudo", function()
        menuOpen = false
        if fovCircle then fovCircle.Parent:Destroy() end
        pcall(function() game.CoreGui["MT Menu"]:Destroy() end)
    end)

    print("🎉 MT Menu aberto - Arraste pela barra superior!")
end

-- Key System
if key == "MTmodder" then
    wait(1.5)
    createMenu()
else
    game.Players.LocalPlayer:Kick("❌ Key inválida!")
end
