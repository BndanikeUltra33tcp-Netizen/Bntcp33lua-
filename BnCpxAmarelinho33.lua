local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer

-- Compatibilidade de GUI para executores Mobile/PC
local parentGui = LocalPlayer:WaitForChild("PlayerGui")
if gethui then
    parentGui = gethui()
elseif game:GetService("CoreGui"):FindFirstChild("RobloxGui") then
    parentGui = game:GetService("CoreGui")
end

-- Limpeza de interfaces antigas
if parentGui:FindFirstChild("ArenaPainelFix") then
    parentGui.ArenaPainelFix:Destroy()
end

--------------------------------------------------------------------------------
-- 1. LIMPEZA DO CAMPO DE FUTEBOL
--------------------------------------------------------------------------------
local campoCor = Color3.fromRGB(78, 124, 65)
local keywords = {"line", "linha", "fieldline", "campo", "soccer", "football", "mark"}

local function hasKeyword(name)
    name = name:lower()
    for _, word in pairs(keywords) do
        if name:find(word) then return true end
    end
    return false
end

for _, v in pairs(Workspace:GetDescendants()) do
    if v:IsA("BasePart") then
        local nome = v.Name:lower()
        if nome:find("grass") or nome:find("field") or nome:find("ground") or nome:find("floor") then
            v.Material = Enum.Material.Grass
            v.Color = campoCor
            for _, x in pairs(v:GetChildren()) do
                if x:IsA("Texture") or x:IsA("Decal") then x:Destroy() end
            end
        end

        if hasKeyword(nome) and not nome:find("sign") and not nome:find("board") and not nome:find("placa") then
            v.Transparency = 1
            v.CanCollide = false
        end

        local cor = v.Color
        local r, g, b = math.floor(cor.R * 255), math.floor(cor.G * 255), math.floor(cor.B * 255)
        local ehCinza = math.abs(r - g) < 10 and math.abs(g - b) < 10 and r > 80 and r < 180
        if ehCinza and (nome:find("wall") or nome:find("parede") or nome:find("fence") or nome:find("borda") or v.Size.Y > 5) then
            if not nome:find("sign") and not nome:find("board") and not nome:find("ad") and not nome:find("placa") then
                v.Transparency = 1
                v.CanCollide = false
            end
        end
        v.CastShadow = false
    end
end

Lighting.GlobalShadows = false
Lighting.Brightness = 2

--------------------------------------------------------------------------------
-- 2. CRIAÇÃO DA ARENA VERMELHA
--------------------------------------------------------------------------------
local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")
local baseCFrame = hrp.CFrame

local pastaArena = Workspace:FindFirstChild("ArenaVermelha") or Instance.new("Folder")
pastaArena.Name = "ArenaVermelha"
pastaArena.Parent = Workspace
pastaArena:ClearAllChildren()

local corVermelha = Color3.fromRGB(220, 0, 0)
local comprimento, largura, alturaParede, espessura = 154, 84, 8, 2.5
local larguraGol = 24
local pedacoFundo = (largura - larguraGol) / 2

local paredesConfig = {
    {Size = Vector3.new(pedacoFundo, alturaParede, espessura), Offset = CFrame.new(-largura/2 + pedacoFundo/2 - 1, (alturaParede/2) - 2, -comprimento/2 + 0.5)},
    {Size = Vector3.new(pedacoFundo, alturaParede, espessura), Offset = CFrame.new(largura/2 - pedacoFundo/2 - 1, (alturaParede/2) - 2, -comprimento/2 + 0.5)},
    {Size = Vector3.new(pedacoFundo, alturaParede, espessura), Offset = CFrame.new(-largura/2 + pedacoFundo/2 - 1, (alturaParede/2) - 2, comprimento/2 + 0.5)},
    {Size = Vector3.new(pedacoFundo, alturaParede, espessura), Offset = CFrame.new(largura/2 - pedacoFundo/2 - 1, (alturaParede/2) - 2, comprimento/2 + 0.5)},
    {Size = Vector3.new(espessura, alturaParede, comprimento), Offset = CFrame.new(-largura/2 - 1, (alturaParede/2) - 2, 0.5)},
    {Size = Vector3.new(espessura, alturaParede, comprimento), Offset = CFrame.new(largura/2 - 1, (alturaParede/2) - 2, 0.5)},
}

for i, pInfo in ipairs(paredesConfig) do
    local parede = Instance.new("Part")
    parede.Name = "ParedeVermelha_" .. i
    parede.Size = pInfo.Size
    parede.CFrame = baseCFrame * pInfo.Offset
    parede.Anchored = true
    parede.CanCollide = true
    parede.Color = corVermelha
    parede.Material = Enum.Material.SmoothPlastic
    parede.Parent = pastaArena
end

--------------------------------------------------------------------------------
-- 3. INTERFACE COM EDICÃO AVANÇADA DE PAREDES
--------------------------------------------------------------------------------
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ArenaPainelFix"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = parentGui

local paredeSelecionada = nil

local selectionBox = Instance.new("SelectionBox")
selectionBox.Color3 = Color3.fromRGB(0, 255, 0)
selectionBox.LineThickness = 0.15
selectionBox.Parent = screenGui

-- Botão Flutuante quando Minimizado
local miniBtn = Instance.new("TextButton")
miniBtn.Size = UDim2.new(0, 170, 0, 35)
miniBtn.Position = UDim2.new(0.02, 0, 0.15, 0)
miniBtn.Text = "🛠️ EDIÇÃO DE PAREDES"
miniBtn.BackgroundColor3 = Color3.fromRGB(220, 0, 0)
miniBtn.TextColor3 = Color3.new(1, 1, 1)
miniBtn.Font = Enum.Font.SourceSansBold
miniBtn.TextSize = 14
miniBtn.Visible = false
miniBtn.Active = true
miniBtn.Draggable = true
miniBtn.Parent = screenGui

local miniCorner = Instance.new("UICorner")
miniCorner.CornerRadius = UDim.new(0, 8)
miniCorner.Parent = miniBtn

-- Janela Principal
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 220, 0, 480)
frame.Position = UDim2.new(0.02, 0, 0.15, 0)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -35, 0, 35)
title.Text = "🛠️ EDIÇÃO DE PAREDES"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 15
title.BackgroundColor3 = Color3.fromRGB(220, 0, 0)
title.Parent = frame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 10)
titleCorner.Parent = title

local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 30, 0, 35)
minimizeBtn.Position = UDim2.new(1, -30, 0, 0)
minimizeBtn.Text = "➖"
minimizeBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
minimizeBtn.TextColor3 = Color3.new(1, 1, 1)
minimizeBtn.Font = Enum.Font.SourceSansBold
minimizeBtn.TextSize = 16
minimizeBtn.Parent = frame

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0, 8)
minCorner.Parent = minimizeBtn

minimizeBtn.MouseButton1Click:Connect(function()
    frame.Visible = false
    miniBtn.Visible = true
end)

miniBtn.MouseButton1Click:Connect(function()
    miniBtn.Visible = false
    frame.Visible = true
end)

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -10, 0, 25)
statusLabel.Position = UDim2.new(0, 5, 0, 40)
statusLabel.Text = "Nenhuma parede selecionada"
statusLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
statusLabel.Font = Enum.Font.SourceSans
statusLabel.TextSize = 13
statusLabel.BackgroundTransparency = 1
statusLabel.Parent = frame

local function addBtn(text, pos, size, color, callback)
    local b = Instance.new("TextButton")
    b.Size = size
    b.Position = pos
    b.Text = text
    b.BackgroundColor3 = color
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.SourceSansBold
    b.TextSize = 12
    b.Parent = frame
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = b
    b.MouseButton1Click:Connect(callback)
    return b
end

-- Selecionar Parede Próxima
addBtn("🎯 SELECCIONAR PRÓXIMA", UDim2.new(0.05, 0, 0.14, 0), UDim2.new(0.9, 0, 0, 30), Color3.fromRGB(0, 140, 255), function()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local myPos = char.HumanoidRootPart.Position
    local mehorDist = math.huge
    local alvo = nil
    
    for _, p in pairs(pastaArena:GetChildren()) do
        if p:IsA("BasePart") then
            local dist = (p.Position - myPos).Magnitude
            if dist < mehorDist then
                mehorDist = dist
                alvo = p
            end
        end
    end
    
    if alvo then
        paredeSelecionada = alvo
        selectionBox.Adornee = alvo
        statusLabel.Text = "Selecionado: " .. alvo.Name
    end
end)

-- Movimentação Vertical
addBtn("⬆️ Subir", UDim2.new(0.05, 0, 0.22, 0), UDim2.new(0.42, 0, 0, 26), Color3.fromRGB(50, 50, 50), function()
    if paredeSelecionada then paredeSelecionada.CFrame = paredeSelecionada.CFrame * CFrame.new(0, 1, 0) end
end)

addBtn("⬇️ Descer", UDim2.new(0.53, 0, 0.22, 0), UDim2.new(0.42, 0, 0, 26), Color3.fromRGB(50, 50, 50), function()
    if paredeSelecionada then paredeSelecionada.CFrame = paredeSelecionada.CFrame * CFrame.new(0, -1, 0) end
end)

-- Movimentação Horizontal (4 Direções)
addBtn("⬅️ Esquerda", UDim2.new(0.05, 0, 0.29, 0), UDim2.new(0.42, 0, 0, 26), Color3.fromRGB(50, 50, 50), function()
    if paredeSelecionada then paredeSelecionada.CFrame = paredeSelecionada.CFrame * CFrame.new(-2, 0, 0) end
end)

addBtn("➡️ Direita", UDim2.new(0.53, 0, 0.29, 0), UDim2.new(0.42, 0, 0, 26), Color3.fromRGB(50, 50, 50), function()
    if paredeSelecionada then paredeSelecionada.CFrame = paredeSelecionada.CFrame * CFrame.new(2, 0, 0) end
end)

addBtn("⬆️ Frente", UDim2.new(0.05, 0, 0.36, 0), UDim2.new(0.42, 0, 0, 26), Color3.fromRGB(50, 50, 50), function()
    if paredeSelecionada then paredeSelecionada.CFrame = paredeSelecionada.CFrame * CFrame.new(0, 0, -2) end
end)

addBtn("⬇️ Trás", UDim2.new(0.53, 0, 0.36, 0), UDim2.new(0.42, 0, 0, 26), Color3.fromRGB(50, 50, 50), function()
    if paredeSelecionada then paredeSelecionada.CFrame = paredeSelecionada.CFrame * CFrame.new(0, 0, 2) end
end)

-- Rotação
addBtn("🔄 Rodar (Esq)", UDim2.new(0.05, 0, 0.43, 0), UDim2.new(0.42, 0, 0, 26), Color3.fromRGB(50, 50, 50), function()
    if paredeSelecionada then paredeSelecionada.CFrame = paredeSelecionada.CFrame * CFrame.Angles(0, math.rad(15), 0) end
end)

addBtn("🔄 Rodar (Dir)", UDim2.new(0.53, 0, 0.43, 0), UDim2.new(0.42, 0, 0, 26), Color3.fromRGB(50, 50, 50), function()
    if paredeSelecionada then paredeSelecionada.CFrame = paredeSelecionada.CFrame * CFrame.Angles(0, math.rad(-15), 0) end
end)

-- Ajuste de Dimensões (Tamanho / Largura das Placas)
addBtn("➕ Comprimento", UDim2.new(0.05, 0, 0.51, 0), UDim2.new(0.42, 0, 0, 26), Color3.fromRGB(80, 80, 0), function()
    if paredeSelecionada then paredeSelecionada.Size = paredeSelecionada.Size + Vector3.new(0, 0, 2) end
end)

addBtn("➖ Comprimento", UDim2.new(0.53, 0, 0.51, 0), UDim2.new(0.42, 0, 0, 26), Color3.fromRGB(80, 80, 0), function()
    if paredeSelecionada and paredeSelecionada.Size.Z > 2 then paredeSelecionada.Size = paredeSelecionada.Size - Vector3.new(0, 0, 2) end
end)

addBtn("➕ Largura/Espessura", UDim2.new(0.05, 0, 0.58, 0), UDim2.new(0.42, 0, 0, 26), Color3.fromRGB(80, 80, 0), function()
    if paredeSelecionada then paredeSelecionada.Size = paredeSelecionada.Size + Vector3.new(1, 0, 0) end
end)

addBtn("➖ Largura/Espessura", UDim2.new(0.53, 0, 0.58, 0), UDim2.new(0.42, 0, 0, 26), Color3.fromRGB(80, 80, 0), function()
    if paredeSelecionada and paredeSelecionada.Size.X > 0.5 then paredeSelecionada.Size = paredeSelecionada.Size - Vector3.new(1, 0, 0) end
end)

-- Outros Utilitários
addBtn("📋 Duplicar", UDim2.new(0.05, 0, 0.67, 0), UDim2.new(0.42, 0, 0, 28), Color3.fromRGB(0, 160, 70), function()
    if paredeSelecionada then
        local dup = paredeSelecionada:Clone()
        dup.CFrame = paredeSelecionada.CFrame * CFrame.new(3, 0, 0)
        dup.Parent = pastaArena
        paredeSelecionada = dup
        selectionBox.Adornee = dup
        statusLabel.Text = "Selecionado: " .. dup.Name
    end
end)

addBtn("🎨 Trocar Cor", UDim2.new(0.53, 0, 0.67, 0), UDim2.new(0.42, 0, 0, 28), Color3.fromRGB(180, 100, 0), function()
    if paredeSelecionada then
        paredeSelecionada.Color = Color3.fromRGB(math.random(50,255), math.random(50,255), math.random(50,255))
    end
end)

addBtn("🗑️ Eliminar Parede", UDim2.new(0.05, 0, 0.88, 0), UDim2.new(0.9, 0, 0, 30), Color3.fromRGB(200, 40, 40), function()
    if paredeSelecionada then
        paredeSelecionada:Destroy()
        paredeSelecionada = nil
        selectionBox.Adornee = nil
        statusLabel.Text = "Nenhuma parede selecionada"
    end
end)

--------------------------------------------------------------------------------
-- 4. CONDUÇÃO DA BOLA (3 TOQUES NO ECRÃ)
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
