local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer

print("Carregando: Otimização Peppa 33🇱🇺")

--------------------------------------------------------------------------------
-- 1. APLICAR GRAMADO IGUAL DA PRINT E REMOVER LINHAS / PAREDES CINZAS
--------------------------------------------------------------------------------
local campoCor = Color3.fromRGB(78, 124, 65)

local keywords = {
    "line", "linha", "fieldline", "campo", "soccer", "football", "mark"
}

local function hasKeyword(name)
    name = name:lower()
    for _, word in pairs(keywords) do
        if name:find(word) then
            return true
        end
    end
    return false
end

for _, v in pairs(Workspace:GetDescendants()) do
    if v:IsA("BasePart") then
        local nome = v.Name:lower()

        -- Detecta e pinta o chão do campo
        if nome:find("grass") or nome:find("field") or nome:find("ground") or nome:find("floor") then
            v.Material = Enum.Material.Grass
            v.Color = campoCor
            
            -- Remove texturas antigas do chão do campo
            for _, x in pairs(v:GetChildren()) do
                if x:IsA("Texture") or x:IsA("Decal") then
                    x:Destroy()
                end
            end
        end

        -- Remove as linhas brancas do campo (sem mexer em placas do mapa)
        if hasKeyword(nome) and not nome:find("sign") and not nome:find("board") and not nome:find("placa") then
            v.Transparency = 1
            v.CanCollide = false
        end

        -- Remove a parede cinza específica do Brookhaven perto do campo
        local cor = v.Color
        local r, g, b = math.floor(cor.R * 255), math.floor(cor.G * 255), math.floor(cor.B * 255)
        local ehCinza = math.abs(r - g) < 10 and math.abs(g - b) < 10 and r > 80 and r < 180
        if ehCinza and (nome:find("wall") or nome:find("parede") or nome:find("fence") or nome:find("borda") or v.Size.Y > 5) then
            if not nome:find("sign") and not nome:find("board") and not nome:find("ad") and not nome:find("placa") then
                v.Transparency = 1
                v.CanCollide = false
            end
        end

        -- Desbloqueia colisões invisíveis do gol
        if nome:find("goalbar") or nome:find("invisible") or nome:find("barrier") or nome:find("bloqueio") then
            v.CanCollide = false
            v.Transparency = 1
        end

        v.CastShadow = false
    elseif v:IsA("Decal") or v:IsA("Texture") then
        local nomeDecal = v.Name:lower()
        local parentNome = v.Parent and v.Parent.Name:lower() or ""
        
        if hasKeyword(nomeDecal) or hasKeyword(parentNome) then
            if not parentNome:find("sign") and not parentNome:find("board") and not parentNome:find("placa") then
                v.Transparency = 1
            end
        end
    end
end

-- Iluminação igual solicitada
Lighting.GlobalShadows = false
Lighting.Brightness = 2
Lighting.FogEnd = 100000000

--------------------------------------------------------------------------------
-- 2. POSICIONAMENTO BASEADO NO SEU PERSONAGEM (CENTRO DO CAMPO)
--------------------------------------------------------------------------------
local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")

local baseCFrame = hrp.CFrame

--------------------------------------------------------------------------------
-- 3. ARENA VERMELHA BAIXA COM PORTA E CADEADO
--------------------------------------------------------------------------------
local pastaArena = Workspace:FindFirstChild("ArenaVermelha") or Instance.new("Folder")
pastaArena.Name = "ArenaVermelha"
pastaArena.Parent = Workspace
pastaArena:ClearAllChildren()

local corVermelha = Color3.fromRGB(220, 0, 0)

local comprimento = 160
local largura = 85
local alturaParede = 12
local espessura = 3
local larguraPorta = 14
local SENHA_CADEADO = "1234"

local paredes = {
    -- Fundo 1 (Gol 1)
    {Size = Vector3.new(largura + espessura, alturaParede, espessura), Offset = CFrame.new(0, (alturaParede/2) - 2, -comprimento/2)},
    -- Fundo 2 (Gol 2)
    {Size = Vector3.new(largura + espessura, alturaParede, espessura), Offset = CFrame.new(0, (alturaParede/2) - 2, comprimento/2)},
    -- Lateral Esquerda
    {Size = Vector3.new(espessura, alturaParede, comprimento), Offset = CFrame.new(-largura/2, (alturaParede/2) - 2, 0)},
    -- Lateral Direita (Com espaço para a porta)
    {Size = Vector3.new(espessura, alturaParede, (comprimento - larguraPorta)/2), Offset = CFrame.new(largura/2, (alturaParede/2) - 2, -(comprimento/4) - (larguraPorta/4))},
    {Size = Vector3.new(espessura, alturaParede, (comprimento - larguraPorta)/2), Offset = CFrame.new(largura/2, (alturaParede/2) - 2, (comprimento/4) + (larguraPorta/4))},
}

for _, pInfo in ipairs(paredes) do
    local parede = Instance.new("Part")
    parede.Name = "ParedeVermelha"
    parede.Size = pInfo.Size
    parede.CFrame = baseCFrame * pInfo.Offset
    parede.Anchored = true
    parede.CanCollide = true
    parede.Color = corVermelha
    parede.Material = Enum.Material.SmoothPlastic
    parede.Parent = pastaArena
end

-- PORTA DA ARENA
local porta = Instance.new("Part")
porta.Name = "PortaArena"
porta.Size = Vector3.new(espessura, alturaParede, larguraPorta)
porta.CFrame = baseCFrame * CFrame.new(largura/2, (alturaParede/2) - 2, 0)
porta.Anchored = true
porta.CanCollide = true
porta.Color = Color3.fromRGB(150, 0, 0)
porta.Material = Enum.Material.Metal
porta.Parent = pastaArena

-- CADEADO INTERATIVO
local prompt = Instance.new("ProximityPrompt")
prompt.ObjectText = "Arena Vermelha"
prompt.ActionText = "Abrir Cadeado (Senha)"
prompt.HoldDuration = 0.5
prompt.MaxActivationDistance = 10
prompt.Parent = porta

--------------------------------------------------------------------------------
-- 4. INTERFACE DO CADEADO (GUI)
--------------------------------------------------------------------------------
local playerGui = LocalPlayer:WaitForChild("PlayerGui")
local screenGui = playerGui:FindFirstChild("CadeadoGui") or Instance.new("ScreenGui")
screenGui.Name = "CadeadoGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
screenGui:ClearAllChildren()

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 250, 0, 150)
frame.Position = UDim2.new(0.5, -125, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 2
frame.BorderColor3 = corVermelha
frame.Visible = false
frame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "🔒 Otimização Peppa 33🇱🇺"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundColor3 = corVermelha
title.Font = Enum.Font.SourceSansBold
title.TextSize = 16
title.Parent = frame

local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(0.8, 0, 0, 35)
textBox.Position = UDim2.new(0.1, 0, 0.35, 0)
textBox.PlaceholderText = "Digite a Senha..."
textBox.Text = ""
textBox.TextColor3 = Color3.new(0, 0, 0)
textBox.BackgroundColor3 = Color3.new(1, 1, 1)
textBox.Font = Enum.Font.SourceSans
textBox.TextSize = 18
textBox.Parent = frame

local btnEntrar = Instance.new("TextButton")
btnEntrar.Size = UDim2.new(0.8, 0, 0, 30)
btnEntrar.Position = UDim2.new(0.1, 0, 0.7, 0)
btnEntrar.Text = "ABRIR PORTA"
btnEntrar.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
btnEntrar.TextColor3 = Color3.new(1, 1, 1)
btnEntrar.Font = Enum.Font.SourceSansBold
btnEntrar.TextSize = 16
btnEntrar.Parent = frame

prompt.Triggered:Connect(function()
    frame.Visible = true
    textBox.Text = ""
    textBox:CaptureFocus()
end)

btnEntrar.MouseButton1Click:Connect(function()
    if textBox.Text == SENHA_CADEADO then
        frame.Visible = false
        porta.Transparency = 0.8
        porta.CanCollide = false
        prompt.Enabled = false
        
        task.wait(5)
        porta.Transparency = 0
        porta.CanCollide = true
        prompt.Enabled = true
    else
        textBox.Text = ""
        textBox.PlaceholderText = "SENHA ERRADA!"
    end
end)

--------------------------------------------------------------------------------
-- 5. CONDUÇÃO DE BOLA COM 3 DEDOS (MOBILE)
--------------------------------------------------------------------------------
local conduzindo = false

UserInputService.TouchStarted:Connect(function(_, gameProcessed)
    if gameProcessed then return end
    if #UserInputService:GetTouches() >= 3 then
        conduzindo = not conduzindo
    end
end)

RunService.RenderStepped:Connect(function()
    if conduzindo then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            for _, v in pairs(Workspace:GetDescendants()) do
                if v.Name == "Football" or v.Name == "SoccerBall" or v.Name == "Bola" then
                    local targetPos = char.HumanoidRootPart.CFrame * Vector3.new(0, -1.2, -2.5)
                    v.CFrame = v.CFrame:Lerp(CFrame.new(targetPos), 0.35)
                    v.AssemblyLinearVelocity = Vector3.zero
                end
            end
        end
    end
end)

print("Otimização Peppa 33🇱🇺 aplicado com sucesso!")
