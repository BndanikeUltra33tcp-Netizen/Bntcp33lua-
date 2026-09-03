-- Carrega a biblioteca Fluent UI
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

-- Cria a Janela Principal - PurezaRaul
local Window = Fluent:CreateWindow({
    Title = "PurezaRaul",
    SubTitle = "By Pureza7one",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightShift
})

-- Criação das Abas
local Tabs = {
    Main = Window:AddTab({ Title = "Principal", Icon = "home" }),
    Scripts = Window:AddTab({ Title = "Scripts Externos", Icon = "code" })
}

----------------------------------------------------------------
-- OPÇÕES PRINCIPAL (FUNÇÕES BÁSICAS)
----------------------------------------------------------------
local ToggleJump = Tabs.Main:AddToggle("SuperJump", { Title = "Super Pulo", Default = false })
ToggleJump:OnChanged(function(Value)
    local character = game.Players.LocalPlayer.Character
    if character and character:FindFirstChild("Humanoid") then
        character.Humanoid.JumpPower = Value and 100 or 50
    end
end)

local ToggleSpeed = Tabs.Main:AddToggle("Speed", { Title = "Velocidade Aumentada", Default = false })
ToggleSpeed:OnChanged(function(Value)
    local character = game.Players.LocalPlayer.Character
    if character and character:FindFirstChild("Humanoid") then
        character.Humanoid.WalkSpeed = Value and 50 or 16
    end
end)

----------------------------------------------------------------
-- SCRIPTS EXTERNOS
----------------------------------------------------------------

-- Seção Lote 1
Tabs.Scripts:AddSection("Lote 1")

Tabs.Scripts:AddButton({
    Title = "Pastefy Novo (UJTfX1ao)",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/UJTfX1ao/raw"))()
        Fluent:Notify({ Title = "PurezaRaul", Content = "Script UJTfX1ao executado!", Duration = 3 })
    end
})

Tabs.Scripts:AddButton({
    Title = "Pastefy 1 (3HxetFY5)",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/3HxetFY5/raw"))()
        Fluent:Notify({ Title = "PurezaRaul", Content = "Pastefy 1 executado!", Duration = 3 })
    end
})

Tabs.Scripts:AddButton({
    Title = "Pastefy 2 (LOwLb5Bb)",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/LOwLb5Bb/raw"))()
        Fluent:Notify({ Title = "PurezaRaul", Content = "Pastefy 2 executado!", Duration = 3 })
    end
})

Tabs.Scripts:AddButton({
    Title = "Masterstrap Universal",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Masterstrap-239143"))()
        Fluent:Notify({ Title = "PurezaRaul", Content = "Masterstrap executado!", Duration = 3 })
    end
})

-- Seção Lote 2
Tabs.Scripts:AddSection("Lote 2")

Tabs.Scripts:AddButton({
    Title = "Pastefy (EXtLzlSi)",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/EXtLzlSi/raw"))()
        Fluent:Notify({ Title = "PurezaRaul", Content = "Script EXtLzlSi executado!", Duration = 3 })
    end
})

Tabs.Scripts:AddButton({
    Title = "Pastefy (FNrAbbk3)",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/FNrAbbk3/raw"))()
        Fluent:Notify({ Title = "PurezaRaul", Content = "Script FNrAbbk3 executado!", Duration = 3 })
    end
})

Tabs.Scripts:AddButton({
    Title = "Pastefy (udlg1b3D)",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/udlg1b3D/raw"))()
        Fluent:Notify({ Title = "PurezaRaul", Content = "Script udlg1b3D executado!", Duration = 3 })
    end
})

Tabs.Scripts:AddButton({
    Title = "Pastefy (LUhsO58I)",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/LUhsO58I/raw"))()
        Fluent:Notify({ Title = "PurezaRaul", Content = "Script LUhsO58I executado!", Duration = 3 })
    end
})

Tabs.Scripts:AddButton({
    Title = "UniversHub Graphics",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Uranus197/-Univers-Hub-Graphics-Script-/refs/heads/main/UniversHub"))()
        Fluent:Notify({ Title = "PurezaRaul", Content = "UniversHub executado!", Duration = 3 })
    end
})

Tabs.Scripts:AddButton({
    Title = "Louissk Testing",
    Callback = function()
        loadstring(game:HttpGet("http://raw.githubusercontent.com/Louissk/testing/main/main.lua"))()
        Fluent:Notify({ Title = "PurezaRaul", Content = "Script Louissk executado!", Duration = 3 })
    end
})

Tabs.Scripts:AddButton({
    Title = "Joshzz Panel Booster (FPS)",
    Callback = function()
        loadstring(game:HttpGet("http://raw.githubusercontent.com/JoshzzAlteregooo/FpsBoosterV2/refs/heads/main/FpsBoosterV2/JoshzzPanelBooster"))()
        Fluent:Notify({ Title = "PurezaRaul", Content = "Joshzz FPS Booster executado!", Duration = 3 })
    end
})

Tabs.Scripts:AddButton({
    Title = "Pastefy (WKjHtU53)",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/WKjHtU53/raw"))()
        Fluent:Notify({ Title = "PurezaRaul", Content = "Script WKjHtU53 executado!", Duration = 3 })
    end
})

-- Seção Lote 3
Tabs.Scripts:AddSection("Lote 3")

Tabs.Scripts:AddButton({
    Title = "Bn Hub 33",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BndanikeUltra33tcp-Netizen/Bntcp33lua-/main/BnHub33.lua"))()
        Fluent:Notify({ Title = "PurezaRaul", Content = "Bn Hub 33 executado!", Duration = 3 })
    end
})

Tabs.Scripts:AddButton({
    Title = "Bn Danike Ultra 33",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BndanikeUltra33tcp-Netizen/Bntcp33lua-/main/BnDanikeUltra33.lua"))()
        Fluent:Notify({ Title = "PurezaRaul", Content = "Bn Danike Ultra executado!", Duration = 3 })
    end
})

Tabs.Scripts:AddButton({
    Title = "Alto Poderes Bn 7",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BndanikeUltra33tcp-Netizen/Bntcp33lua-/main/Altopoderesbn7.lua"))()
        Fluent:Notify({ Title = "PurezaRaul", Content = "Alto Poderes Bn executado!", Duration = 3 })
    end
})

Tabs.Scripts:AddButton({
    Title = "Bn Ultra FPS 33",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BndanikeUltra33tcp-Netizen/Bntcp33lua-/main/BnUltraFps33tcp.lua"))()
        Fluent:Notify({ Title = "PurezaRaul", Content = "Bn Ultra FPS executado!", Duration = 3 })
    end
})

Tabs.Scripts:AddButton({
    Title = "Pastefy (7210WTuY)",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/7210WTuY/raw"))()
        Fluent:Notify({ Title = "PurezaRaul", Content = "Script 7210WTuY executado!", Duration = 3 })
    end
})

Tabs.Scripts:AddButton({
    Title = "Pastefy (kToxY03Y)",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/kToxY03Y/raw"))()
        Fluent:Notify({ Title = "PurezaRaul", Content = "Script kToxY03Y executado!", Duration = 3 })
    end
})

Tabs.Scripts:AddButton({
    Title = "Pastefy (Hc7Bc9sB)",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/Hc7Bc9sB/raw"))()
        Fluent:Notify({ Title = "PurezaRaul", Content = "Script Hc7Bc9sB executado!", Duration = 3 })
    end
})

Tabs.Scripts:AddButton({
    Title = "Pastefy (sKSc1ptd)",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/sKSc1ptd/raw"))()
        Fluent:Notify({ Title = "PurezaRaul", Content = "Script sKSc1ptd executado!", Duration = 3 })
    end
})

Tabs.Scripts:AddButton({
    Title = "Pastefy (uxqH8h3w)",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/uxqH8h3w/raw"))()
        Fluent:Notify({ Title = "PurezaRaul", Content = "Script uxqH8h3w executado!", Duration = 3 })
    end
})

Tabs.Scripts:AddButton({
    Title = "Pastefy (9L3KHvtI)",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/9L3KHvtI/raw"))()
        Fluent:Notify({ Title = "PurezaRaul", Content = "Script 9L3KHvtI executado!", Duration = 3 })
    end
})

Tabs.Scripts:AddButton({
    Title = "Pastefy (WhSUn3ow)",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/WhSUn3ow/raw"))()
        Fluent:Notify({ Title = "PurezaRaul", Content = "Script WhSUn3ow executado!", Duration = 3 })
    end
})

Tabs.Scripts:AddButton({
    Title = "Pastefy (sVZQXr9d)",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/sVZQXr9d/raw"))()
        Fluent:Notify({ Title = "PurezaRaul", Content = "Script sVZQXr9d executado!", Duration = 3 })
    end
})

Tabs.Scripts:AddButton({
    Title = "Pastefy (OyNJX8E0)",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/OyNJX8E0/raw"))()
        Fluent:Notify({ Title = "PurezaRaul", Content = "Script OyNJX8E0 executado!", Duration = 3 })
    end
})

Tabs.Scripts:AddButton({
    Title = "Pastefy (q2avMSrx)",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/q2avMSrx/raw"))()
        Fluent:Notify({ Title = "PurezaRaul", Content = "Script q2avMSrx executado!", Duration = 3 })
    end
})

Tabs.Scripts:AddButton({
    Title = "Pastefy (rtUJsZCM)",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/rtUJsZCM/raw"))()
        Fluent:Notify({ Title = "PurezaRaul", Content = "Script rtUJsZCM executado!", Duration = 3 })
    end
})

----------------------------------------------------------------
-- BOTÃO FLUTUANTE DE ABRIR/REATIVAR
----------------------------------------------------------------
local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Garante remoção de instâncias antigas se reexecutar
if PlayerGui:FindFirstChild("PurezaRaulToggleGui") then
    PlayerGui.PurezaRaulToggleGui:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PurezaRaulToggleGui"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false

local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "OpenCloseBtn"
ToggleButton.Parent = ScreenGui
ToggleButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ToggleButton.Position = UDim2.new(0, 15, 0.5, -20)
ToggleButton.Size = UDim2.new(0, 110, 0, 40)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Text = "PurezaRaul"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 14.000
ToggleButton.Active = true
ToggleButton.Draggable = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = ToggleButton

local UIStroke = Instance.new("UIStroke")
UIStroke.Parent = ToggleButton
UIStroke.Color = Color3.fromRGB(0, 170, 255)
UIStroke.Thickness = 1.5

-- Ação ao clicar no botão: usa a função nativa da biblioteca Fluent
ToggleButton.MouseButton1Click:Connect(function()
    Window:Minimize()
end)

-- Notificação Inicial
Fluent:Notify({
    Title = "PurezaRaul",
    Content = "Menu pronto! Clique no botão flutuante para abrir/fechar.",
    Duration = 5
})
