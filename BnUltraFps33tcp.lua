--// ULTRA FPS BOOST EXTREMO (CORRIGIDO)

local Lighting = game:GetService("Lighting")
local Terrain = workspace:FindFirstChildOfClass("Terrain")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Configurações básicas de renderização
pcall(function()
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
end)

pcall(function()
    sethiddenproperty(Lighting, "Technology", Enum.Technology.Compatibility)
end)

Lighting.GlobalShadows = false
Lighting.Brightness = 0
Lighting.EnvironmentDiffuseScale = 0
Lighting.EnvironmentSpecularScale = 0
Lighting.FogStart = 999999
Lighting.FogEnd = 999999999
Lighting.ClockTime = 12

-- Modificação do Terrain (Água)
if Terrain then
    Terrain.WaterWaveSize = 0
    Terrain.WaterWaveSpeed = 0
    Terrain.WaterReflectance = 0
    Terrain.WaterTransparency = 1
end

-- Destrava FPS
pcall(function()
    setfpscap(99999999999999999999999999999999999999999999)
end)

-- Processamento otimizado para não congelar o boneco
local function cleanDescendants()
    local descendants = game:GetDescendants()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

    for i, v in ipairs(descendants) do
        -- Ignora totalmente o seu personagem para preservar física e velocidade
        if not v:IsDescendantOf(character) then
            
            -- Remove efeitos visuais e partículas do mapa
            if v:IsA("ParticleEmitter")
            or v:IsA("Trail")
            or v:IsA("Smoke")
            or v:IsA("Fire")
            or v:IsA("Sparkles")
            or v:IsA("Explosion")
            or v:IsA("Beam")
            or v:IsA("BlurEffect")
            or v:IsA("BloomEffect")
            or v:IsA("SunRaysEffect")
            or v:IsA("DepthOfFieldEffect")
            or v:IsA("ColorCorrectionEffect")
            or v:IsA("Atmosphere")
            or v:IsA("Sky")
            or v:IsA("SurfaceAppearance") then
                v:Destroy()
                
            -- Esconde texturas e decalques
            elseif v:IsA("Texture") or v:IsA("Decal") then
                v.Transparency = 1
                
            -- Simplifica peças sem remover colisão/física
            elseif v:IsA("BasePart") then
                v.Material = Enum.Material.SmoothPlastic
                v.Reflectance = 0
                v.CastShadow = false
            end
        end

        -- Pausa a cada 300 itens para permitir que a CPU processe o movimento
        if i % 300 == 0 then
            task.wait()
        end
    end
end

-- Executa a limpeza
cleanDescendants()

print("⚡ ULTRA FPS BOOST ATIVADO SEM TRAVAR MOVIMENTO")
