-- =============================================
-- SCRIPT INTEGRADO: Brayan Melhor do RP 33
-- 3 Desarmes + 3 Atravessar (Tudo automático, sem GUI, sem toggle)
-- =============================================

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

print("🔥 Brayan Melhor do RP 33 - Integrado")

-- Atualiza RootPart (necessário pros desarmes e atravessar)
local RootPart
local function UpdateRoot()
    if LocalPlayer.Character then
        RootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    end
end

UpdateRoot()
LocalPlayer.CharacterAdded:Connect(UpdateRoot)

-- =============================================
-- 3 Funções de Atravessar (sempre ativas)
-- =============================================

local function Atravessar1()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            for _, part in pairs(p.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end
end

local function Atravessar2()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            for _, part in pairs(plr.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end
end

local function Atravessar3()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            for _, part in pairs(plr.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end
end

-- =============================================
-- 3 Desarmes novos (sempre ativos)
-- =============================================

local function Desarme1()
    local ball = Workspace:FindFirstChild("Ball") or Workspace:FindFirstChild("Football") or Workspace:FindFirstChild("SoccerBall")
    if ball and RootPart and (ball.Position - RootPart.Position).Magnitude < 12 then
        ball.CFrame = RootPart.CFrame * CFrame.new(0,0,-2)
    end
end

local function Desarme2()
    if not RootPart then return end
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (plr.Character.HumanoidRootPart.Position - RootPart.Position).Magnitude
            if dist < 9 then
                local ball = Workspace:FindFirstChild("Ball") or Workspace:FindFirstChild("Football") or Workspace:FindFirstChild("SoccerBall")
                if ball then
                    ball.CFrame = RootPart.CFrame * CFrame.new(0,0,-2)
                end
            end
        end
    end
end

local function Desarme3()
    if not RootPart then return end
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (plr.Character.HumanoidRootPart.Position - RootPart.Position).Magnitude
            if dist < 8 then
                local ball = Workspace:FindFirstChild("Ball") or Workspace:FindFirstChild("Football") or Workspace:FindFirstChild("SoccerBall")
                if ball then
                    ball.CFrame = CFrame.new(RootPart.Position + Vector3.new(0, 0, 2))
                end
            end
        end
    end
end

-- =============================================
-- LOOP PRINCIPAL (tudo junto)
-- =============================================
RunService.RenderStepped:Connect(function()
    if not RootPart then return end

    -- Atravessar (as 3 versões)  
    Atravessar1()  
    Atravessar2()  
    Atravessar3()  
      
    -- Desarmes (os 3 novos)  
    Desarme1()  
    Desarme2()  
    Desarme3()
end)

print("Script integrado: Brayan Melhor do RP 33 + 3 Atravessar + 3 Desarmes - tudo automático")
