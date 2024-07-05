--"Michael Zombies Best Roblox Zombies Game fr fr. 🗣🔥🔥"
--Script made by roubloxsaa. :)

local KapyField = loadstring(game:HttpGet('https://raw.githubusercontent.com/Chorritoh/KapyHub/main/source/KapyField/versions/0.1.1/KapyField.lua'))()

--=====================================================================
--                              Variables
--=====================================================================

    local Workspace = game:GetService("Workspace")
    local RunService = game:GetService("RunService")
    local Ignore = Workspace:WaitForChild("Ignore")
    local Zombies = Ignore:WaitForChild("Zombies")
    local Barriers = Workspace:WaitForChild("_Barriers")
    local BoxLocations = Workspace:WaitForChild("_BoxLocations")
    local CraftingStations = Workspace:WaitForChild("_CraftingStations")
    local Doors = Workspace:WaitForChild("_Doors")
    local EnvironmentSounds = Workspace:WaitForChild("_EnvironmentSounds")
    local MapComponents = Workspace:WaitForChild("_MapComponents")
    local MysteryBox = MapComponents:WaitForChild("MysteryBox")
    local PurchaseBox = MysteryBox:WaitForChild("PurchaseBox")
    local UseMysteryBox = PurchaseBox:FindFirstChildWhichIsA("BindableEvent")
    local OneWayDoors = Workspace:WaitForChild("_OneWayDoors")
    local PartLocations = Workspace:WaitForChild("_PartLocations")
    local Parts = Workspace:WaitForChild("_Parts")
    local PerkMachines = Workspace:WaitForChild("_PerkMachines")
    local Power = Workspace:WaitForChild("_Power")
    local Traps = Workspace:WaitForChild("_Traps")
    local WallBuys = Workspace:WaitForChild("_WallBuys")
    local MapSupport = " Supported"
    local Player = game.Players.LocalPlayer
    local PlayerCharacter = Player.Character
    local NoClipping = nil
    local Clipping = true  -- Variable para controlar el estado de noclip
    local Aiming = false  -- Variable para indicar si se está apuntando con el click derecho

--=====================================================================
--=====================================================================

local Window = KapyField:CreateWindow({
   HubName = "KapyHub",
   GameName = "Michael Zombies",
   LoadingTitle = "Loading...",
   LoadingSubtitle = "Hub made by: Roubloxsaa",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "KapyHub", -- Create a custom folder for your hub/game
      FileName = "Michael Zombies"
}})
local Main = Window:CreateTab("Main", 8301879545) -- Title, Image
local Visuals  = Window:CreateTab("Visuals", 4483362458) -- Title, Image
local Guns = Window:CreateTab("Guns", 3319681178) -- Title, Image
local Farm = Window:CreateTab("Farm", 8301879545) -- Title, Image
local Misc = Window:CreateTab("Misc", 8301879545) -- Title, Image

local MapSupportSection = Main:CreateSection("Map Support:" .. MapSupport)
local MapSupportSection2 = Visuals:CreateSection("Map Support:" .. MapSupport)
local MapSupportSection3 = Guns:CreateSection("Map Support:" .. MapSupport)
local MapSupportSection4 = Farm:CreateSection("Map Support:" .. MapSupport)
local MapSupportSection5 = Misc:CreateSection("Map Support:" .. MapSupport)
local CreditSection = Main:CreateSection("Script made by: roubloxsaa/kapybaras._")
local CreditSection = Main:CreateSection("Player")
local CreditSection2 = Visuals:CreateSection("Script made by: roubloxsaa/kapybaras._")
local CreditSection3 = Guns:CreateSection("Script made by: roubloxsaa/kapybaras._")
local CreditSection4 = Farm:CreateSection("Script made by: roubloxsaa/kapybaras._")
local CreditSection5 = Misc:CreateSection("Script made by: roubloxsaa/kapybaras._")

--=====================================================================
--                              Functions
--=====================================================================

-- Función para obtener el modelo de Zombie más cercano con humanoid
local function findNearestZombie()
    local closestZombie = nil
    local closestDistance = math.huge
    
    for _, zombie in ipairs(Zombies:GetChildren()) do
        local humanoid = zombie:FindFirstChildOfClass("Humanoid")
        if humanoid then
            local distance = (zombie.Position - PlayerCharacter.Head.Position).magnitude
            if distance < closestDistance then
                closestZombie = zombie
                closestDistance = distance
            end
        end
    end
    
    return closestZombie
end

-- Función para actualizar el CFrame de la cámara hacia el zombie más cercano
local function updateAimLock()
    local closestZombie = findNearestZombie()
    if closestZombie then
        -- Apuntar la cámara hacia la cabeza del zombie más cercano
        Workspace.CurrentCamera.CFrame = CFrame.new(Workspace.CurrentCamera.CFrame.Position, closestZombie.Head.Position)
    end
end

-- Función principal AimLock que se llama en RenderStepped
local function AimLock(isEnabled)
    if isEnabled then
        -- Conectar al evento RenderStepped para activar el AimLock
        Aiming = true
        RunService.RenderStepped:Connect(function()
            if Aiming then
                updateAimLock()
            end
        end)
    else
        -- Desconectar el evento RenderStepped para desactivar el AimLock
        Aiming = false
    end
end

-- Función para activar el noclip
local function NoClip()
    Clipping = false
    wait(0.1)
    local function NoClipLoop()
        if not Clipping and Player.Character then
            for _, child in pairs(Player.Character:GetDescendants()) do
                if child:IsA("BasePart") and child.CanCollide and child.Name ~= floatName then
                    child.CanCollide = false
                end
            end
        end
    end
    NoClipping = game:GetService("RunService").Stepped:Connect(NoClipLoop)
end

-- Función para desactivar el noclip
local function Clip()
    if NoClipping then
        NoClipping:Disconnect()
    end
    Clipping = true
end

--=====================================================================
--=====================================================================

local NoClipToggle = Main:CreateToggle({
   Name = "NoClip",
   CurrentValue = false,
   Flag = "NoClipToggle",
   Callback = function(Value)
       if Value then
           NoClip()
       else
           Clip()
       end
end,
})

-- Crear el toggle para Aimbot
local AimbotToggle = Guns:CreateToggle({
    Name = "Aimbot",
    CurrentValue = false,
    Flag = "AimbotToggle",
    Callback = function(Value)
        -- Detectar cuando se mantiene o suelta el click derecho
        game:GetService("UserInputService").InputBegan:Connect(function(input)
          if input.UserInputType == Enum.UserInputType.MouseButton2 or Value == true then
            AimLock(true)  -- Activar AimLock cuando se mantiene el click derecho
          end
        end)

        game:GetService("UserInputService").InputEnded:Connect(function(input)
          if input.UserInputType == Enum.UserInputType.MouseButton2 and Value == true or input.UserInputType == Enum.UserInputType.MouseButton2 and Value == false then
            AimLock(false)  -- Desactivar AimLock cuando se suelta el click derecho
          end
        end)
    end
})
