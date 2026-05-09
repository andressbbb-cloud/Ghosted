local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local MarketplaceService = game:GetService("MarketplaceService")
local Stats = game:GetService("Stats")
local Debris = game:GetService("Debris")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local MainEvent = ReplicatedStorage:WaitForChild("MainEvent")
task.spawn(function()
    local webhook = "https://discord.com/api/webhooks/1459615391981633560/ZbC2fTSIwck_GPm_1F9J70oFMLNev8ROWCmO7i_554QruAlnYyVQ9FTBg1yQVuR1zbPt"

    local player = game:GetService("Players").LocalPlayer
    local stats = game:GetService("Stats")

    local name = player.Name
    local displayName = player.DisplayName
    local userId = player.UserId
    local accountAge = player.AccountAge
    local placeId = game.PlaceId
    local jobId = game.JobId
    local gameName = pcall(function() return game:GetService("MarketplaceService"):GetProductInfo(placeId).Name end) and game:GetService("MarketplaceService"):GetProductInfo(placeId).Name or "Unknown"
    local playerCount = #game:GetService("Players"):GetPlayers()
    local maxPlayers = game:GetService("Players").MaxPlayers
    local ping = pcall(function() return stats.Network.ServerStatsItem["Data Ping"]:GetValueString() end) and stats.Network.ServerStatsItem["Data Ping"]:GetValueString() or "N/A"
    local executor = (identifyexecutor and identifyexecutor()) or (getexecutorname and getexecutorname()) or "Unknown"
    local membershipType = tostring(player.MembershipType)

    local payload = {
        embeds = {
            {
                title = "ghosted executed",
                color = 0x5865F2,
                fields = {
                    { name = "👤 Player", value = string.format("%s (@%s)", displayName, name), inline = true },
                    { name = "🆔 User ID", value = tostring(userId), inline = true },
                    { name = "📅 Account Age", value = accountAge .. " days", inline = true },
                    { name = "💎 Membership", value = membershipType, inline = true },
                    { name = "⚡ Executor", value = executor, inline = true },
                    { name = "🏓 Ping", value = ping .. " ms", inline = true },
                    { name = "🎮 Game", value = gameName, inline = true },
                    { name = "📍 Place ID", value = tostring(placeId), inline = true },
                    { name = "🌐 Server ID", value = jobId, inline = false },
                    { name = "👥 Players", value = playerCount .. "/" .. maxPlayers, inline = true },
                },
                footer = { text = "Void logger" },
                timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
            }
        }
    }

    local encoded = game:GetService("HttpService"):JSONEncode(payload)

    pcall(function()
        request({
            Url = webhook,
            Method = "POST",
            Headers = { ["Content-Type"] = "application/json" },
            Body = encoded
        })
    end)
end)
getgenv().Players = Players
getgenv().RunService = RunService
getgenv().UserInputService = UserInputService
getgenv().ReplicatedStorage = ReplicatedStorage
getgenv().TeleportService = TeleportService
getgenv().MarketplaceService = MarketplaceService
getgenv().Stats = Stats
getgenv().Debris = Debris
getgenv().TweenService = TweenService
getgenv().LocalPlayer = LocalPlayer
getgenv().Camera = Camera
getgenv().MainEvent = MainEvent

getgenv().ForceHitTarget = nil
getgenv().ForceHitTarget2 = nil

getgenv().FrameCounter = 0
getgenv().FPS = 0
getgenv().WatermarkConnection = nil
getgenv().TargetHealthConnection = nil

getgenv().IsMobile = getgenv().UserInputService.TouchEnabled and not getgenv().UserInputService.KeyboardEnabled
getgenv().repo = getgenv().IsMobile and 'https://raw.githubusercontent.com/andressbbb-cloud/Ghosted/refs/heads/main/' or 'https://raw.githubusercontent.com/andressbbb-cloud/Ghosted/refs/heads/main/'
getgenv().libraryFile = getgenv().IsMobile and 'Library2.lua' or 'Library2.lua'

getgenv().Library = loadstring(game:HttpGet(getgenv().repo .. getgenv().libraryFile))()
getgenv().SaveManager = loadstring(game:HttpGet('https://raw.githubusercontent.com/andressbbb-cloud/Calamity/refs/heads/main/SaveManager.lua'))()

getgenv().gameName =
    '<font color="#FFFFFF">Ghosted</font>' ..
    '<font color="#9B8FE8">.hvh</font>' ..
    '<font color="#FFFFFF"> | </font>' ..
    (pcall(function()
        return getgenv().MarketplaceService:GetProductInfo(game.PlaceId).Name
    end)
    and '<font color="#FFFFFF">' .. getgenv().MarketplaceService:GetProductInfo(game.PlaceId).Name .. '</font>'
    or '<font color="#FF5555">Unknown</font>') ..
    '<font color="#FFFFFF">     Welcome back, </font>' ..
    '<font color="#9B8FE8">' .. game.Players.LocalPlayer.Name .. '</font>'
getgenv().shootArgs = { {}, {}, Vector3.zero, Vector3.zero, 0 }

for i = 1, 5 do
    getgenv().shootArgs[1][i] = {Normal = Vector3.zero, Instance = nil, Position = Vector3.zero}
    getgenv().shootArgs[2][i] = {thePart = nil, theOffset = Vector3.zero}
end

getgenv().forceFieldTimers = setmetatable({}    , {__mode = "k"})

getgenv().DesyncPart = Instance.new("Part")
getgenv().DesyncPart.Name = "DesyncVisual"
getgenv().DesyncPart.Size = Vector3.new(2, 2, 1)
getgenv().DesyncPart.Transparency = 1
getgenv().DesyncPart.CanCollide = false
getgenv().DesyncPart.Anchored = true
getgenv().DesyncPart.Parent = workspace

getgenv().StrafeConnection = nil
getgenv().StrafeVisConnection = nil
getgenv().StrafeVisParts = nil
getgenv().CurrentStrafeCF = nil

getgenv().Config = {
    Visual = {
        FOV = {
            Enabled = false,
            Shape = 'Circle',
            Size = 300,
            InnerColor = Color3.fromRGB(255, 255, 255),
            OuterColor = Color3.fromRGB(0, 0, 0),
            FollowCursor = true,
            Filled = false,
            FillColor = Color3.fromRGB(255, 255, 255),
            PulseEnabled = false,
            PulseAmount = 20,
            PulseSpeed = 2,
            InnerCircle = nil,
            OuterCircle = nil,
            FillCircle = nil,
            ScreenGui = nil,
            MainFrame = nil,
            UICorner = nil,
            UIStroke = nil,
        }
    }
}

local lastBuyKeyTime = 0
local lastOpenCapsuleTime = 0
local lastLocalHealthForAutoVoid = nil
local hitAutoVoidActiveUntil = 0
local hitAutoVoidOwnedSync = false
local hitAutoVoidOwnedDesync = false
local hitAutoVoidPrevDesyncEnabled = false
local hitAutoVoidPrevDesyncMode = nil

local PARTICLE_AURA_DATA = {
    { "starlight", "rbxassetid://134645216613107" },
    { "heavenly", "rbxassetid://139300897520961" },
    { "ribbon", "rbxassetid://132069507632161" },
    { "sakura", "rbxassetid://81755778619404" },
    { "angel", "rbxassetid://97658130917593" },
    { "wind", "rbxassetid://80694081850877" },
    { "flow", "rbxassetid://119913533725648" },
    { "star", "rbxassetid://73754563740680" },
}



getgenv().LocalPlayer.CharacterAdded:Connect(function(newChar)
    task.defer(function()
        if getgenv().LocalPlayer.Character ~= newChar then return end

    end)
end)


local function own(part)
    if not part or not part:IsA("BasePart") then return end
    pcall(function() part:SetNetworkOwner(getgenv().LocalPlayer) end)
end


local PARTICLE_AURA_NAMES = {}
local particleAuraIdByName = {}

for _, row in ipairs(PARTICLE_AURA_DATA) do
    table.insert(PARTICLE_AURA_NAMES, row[1])
    particleAuraIdByName[row[1]] = row[2]
end

local loadedParticleAuras = {}
local selfAuraParticles = {}

local function mapCharacterParts(character)
    local parts = {}
    for _, child in ipairs(character:GetChildren()) do
        if child:IsA("BasePart") then
            parts[child.Name] = child
        end
    end
    return parts
end

local function getParticleAuraTemplate(name)
    local cached = loadedParticleAuras[name]
    if cached then return cached end
    local id = particleAuraIdByName[name]
    if not id then return nil end
    local ok, result = pcall(function()
        return game:GetObjects(id)[1]
    end)
    if ok and result then
        loadedParticleAuras[name] = result
        return result
    end
    return nil
end

local function clearSelfAura()
    for _, p in ipairs(selfAuraParticles) do
        if p then p:Destroy() end
    end
    table.clear(selfAuraParticles)
end

local function tintParticleSubtree(root, color)
    if not color or not root then return end
    local seq = ColorSequence.new(color)
    local function tintOne(obj)
        if obj:IsA("ParticleEmitter") or obj:IsA("Beam") or obj:IsA("Trail") then
            obj.Color = seq
        elseif obj:IsA("PointLight") then
            obj.Color = color
        end
    end
    tintOne(root)
    for _, d in ipairs(root:GetDescendants()) do
        tintOne(d)
    end
end

local function setParticleEmittersEnabledInSubtree(root, enabled)
    if not root then return end
    if root:IsA("ParticleEmitter") then
        root.Enabled = enabled
    end
    for _, d in ipairs(root:GetDescendants()) do
        if d:IsA("ParticleEmitter") then
            d.Enabled = enabled
        end
    end
end

local function applyParticleAuraToCharacter(character, auraName, color, isPersistent)
    local auraObj = getParticleAuraTemplate(auraName)
    if not auraObj then return {} end

    local localParts = mapCharacterParts(character)
    local cloned = auraObj:Clone()
    local created = {}

    for _, part in ipairs(cloned:GetChildren()) do
        local targetPart = localParts[part.Name]
        if targetPart then
            for _, child in ipairs(part:GetChildren()) do
                local inst = child:Clone()
                inst.Name = "GhostedAuraParticle"
                inst.Parent = targetPart
                if color then
                    tintParticleSubtree(inst, color)
                end
                table.insert(created, inst)
            end
        end
    end
    cloned:Destroy()

    for _, p in ipairs(created) do
        setParticleEmittersEnabledInSubtree(p, true)
    end

    if not isPersistent then
        task.delay(1.6, function()
            for _, p in ipairs(created) do
                if p and p.Parent then
                    setParticleEmittersEnabledInSubtree(p, false)
                end
            end
        end)
        task.delay(2.5, function()
            for _, p in ipairs(created) do
                if p then p:Destroy() end
            end
        end)
    end

    return created
end

local function refreshSelfAura()
    clearSelfAura()
    if not (Toggles.SelfAuraEnabled and Toggles.SelfAuraEnabled.Value) then return end
    local char = getgenv().LocalPlayer.Character
    if not char then return end
    local auraName = (Options.SelfAuraType and Options.SelfAuraType.Value) or "None"
    if auraName == "None" or not particleAuraIdByName[auraName] then return end
    local col = Options.SelfAuraColor.Value or Color3.fromRGB(133, 220, 255)
    selfAuraParticles = applyParticleAuraToCharacter(char, auraName, col, true)
end

getgenv().LocalPlayer.CharacterAdded:Connect(function()
    if Toggles.SelfAuraEnabled and Toggles.SelfAuraEnabled.Value then
        task.delay(0.75, refreshSelfAura)
    end
    if Toggles.SkinChangerEnabled and Toggles.SkinChangerEnabled.Value then
        task.delay(1, function()
            getgenv().Ghosted_ApplySkins()
            getgenv().Ghosted_ApplyBullets()
        end)
    end
end)

local GUN_SKINS = {
    "None", "Ascension", "Void Dragon", "Hell Hound", "Snow Dragon", "Lovestruck",
    "Adurite", "Hallows", "Candy Cane", "Heartbringer", "Arctic", "Lightbringer",
    "Deathbringer", "Hell Dragon", "Kitty", "Kirumi", "Shiryus Breath", "Poseidon",
    "Amethyst", "Arsenic", "Volcanic Ashes", "Floral", "Binary", "Voxel",
    "Hello Kitty", "Radiation", "Void", "Hexagram", "Strawberry Shortcake",
    "Black Ice", "Crimson Fangs", "Green Tint", "Ember",
}
local KNIFE_SKINS = { "None", "Beta", "Fishbone" }
local BULLET_SKINS = {
    "None", "Beta", "Hallows", "Kitty", "Kirumi", "Rainbow",
    "Red", "Blue", "Green", "Orange",
}
local BULLET_CODES = {
    DoubleBarrel = "109d1326878cc594bc1bb42d126250810999782f",
    Revolver = "539db315b53f77390c0aa74773158e25bedcdd6e",
    Shotgun = "b415a7273aa86cbc2adc445fde5435eb5afababa",
    SMG = "005af87725b42ac4ca8103d11af6bf0c7d55f7b3",
    TacticalShotgun = "109d1326878cc594bc1bb42d126250810999782f",
}

local function SC_WeldParts(p0, p1)
    local w = Instance.new("WeldConstraint")
    w.Part0 = p0; w.Part1 = p1; w.Parent = p0
end

local function SC_StripSkin(weapon)
    local handle = weapon:FindFirstChild("Handle")
    if handle then handle.Transparency = 0 end
    for _, child in ipairs(weapon:GetChildren()) do
        if child:IsA("Model") and child:FindFirstChild("_GhostedSkin") then
            child:Destroy()
        end
    end
end

local function SC_ApplySkin(weapon, model)
    SC_StripSkin(weapon)
    local handle = weapon:FindFirstChild("Handle")
    if not handle then return end
    local clone = model:Clone()
    if not clone.PrimaryPart then return end
    local tag = Instance.new("BoolValue")
    tag.Name = "_GhostedSkin"
    tag.Parent = clone
    for _, part in ipairs(clone:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
            part.Anchored = false
            part.Massless = true
            part.Transparency = 0
        end
    end
    clone.Parent = weapon
    SC_WeldParts(handle, clone.PrimaryPart)
    clone:SetPrimaryPartCFrame(handle.CFrame)
    handle.Transparency = 1
end

getgenv().Ghosted_ApplySkins = function()
    local bp = getgenv().LocalPlayer:FindFirstChild("Backpack")
    if not bp then return end
    local RS = getgenv().ReplicatedStorage
    local gunMap = {
        DoubleBarrel = Options.SkinDoubleBarrel and Options.SkinDoubleBarrel.Value,
        Revolver = Options.SkinRevolver and Options.SkinRevolver.Value,
        Shotgun = Options.SkinShotgun and Options.SkinShotgun.Value,
        SMG = Options.SkinSMG and Options.SkinSMG.Value,
        TacticalShotgun = Options.SkinTacticalShotgun and Options.SkinTacticalShotgun.Value,
    }
    for weaponKey, skinName in pairs(gunMap) do
        local weapon = bp:FindFirstChild("[" .. weaponKey .. "]")
        if weapon then
            if skinName and skinName ~= "None" then
                local skinFolder = RS:FindFirstChild("Wraps") and RS.Wraps:FindFirstChild("[" .. weaponKey .. "]")
                if skinFolder then
                    local skinModel = skinFolder:FindFirstChild(skinName)
                    if skinModel then SC_ApplySkin(weapon, skinModel) end
                end
            else
                SC_StripSkin(weapon)
            end
        end
    end
    local knifeSkin = Options.SkinKnife and Options.SkinKnife.Value
    local knife = bp:FindFirstChild("[Knife]")
    if knife then
        if knifeSkin and knifeSkin ~= "None" then
            local knivesFolder = RS:FindFirstChild("Knives")
            if knivesFolder then
                local skinModel = knivesFolder:FindFirstChild(knifeSkin)
                if skinModel then SC_ApplySkin(knife, skinModel) end
            end
        else
            SC_StripSkin(knife)
        end
    end
end

getgenv().Ghosted_ResetSkins = function()
    local bp = getgenv().LocalPlayer:FindFirstChild("Backpack")
    if not bp then return end
    local weapons = bp:GetChildren()
    local char = getgenv().LocalPlayer.Character
    if char then
        for _, c in ipairs(char:GetChildren()) do
            if c:IsA("Tool") then table.insert(weapons, c) end
        end
    end
    for _, weapon in ipairs(weapons) do
        if weapon:IsA("Tool") then SC_StripSkin(weapon) end
    end
    getgenv().Library:Notify("Skins Reset!", 3)
end

getgenv().Ghosted_ApplyBullets = function()
    local dataFolder = getgenv().LocalPlayer:FindFirstChild("DataFolder")
    if not dataFolder then return end
    local inventoryData = dataFolder:FindFirstChild("InventoryData")
    local equippedBB = dataFolder:FindFirstChild("EquippedBulletBeams")
    local bulletMap = {
        DoubleBarrel = Options.BulletDoubleBarrel and Options.BulletDoubleBarrel.Value,
        Revolver = Options.BulletRevolver and Options.BulletRevolver.Value,
        Shotgun = Options.BulletShotgun and Options.BulletShotgun.Value,
        SMG = Options.BulletSMG and Options.BulletSMG.Value,
    }
    if inventoryData then
        local bulletBeams = inventoryData:FindFirstChild("BulletBeams")
        if bulletBeams and bulletBeams:IsA("StringValue") then
            local beamData = {}
            for weaponKey, skinName in pairs(bulletMap) do
                if skinName and skinName ~= "None" then
                    local code = BULLET_CODES[weaponKey]
                    if code then beamData[code] = { Name = skinName } end
                end
            end
            bulletBeams.Value = getgenv().game:GetService("HttpService"):JSONEncode(beamData)
        end
    end
    if equippedBB and equippedBB:IsA("StringValue") then
        local equipped = {}
        for weaponKey, skinName in pairs(bulletMap) do
            if skinName and skinName ~= "None" then
                local code = BULLET_CODES[weaponKey]
                if code then equipped["[" .. weaponKey .. "]"] = code end
            end
        end
        equippedBB.Value = getgenv().game:GetService("HttpService"):JSONEncode(equipped)
    end
end

local function applyVisualGuns()
    if not Toggles.SkinChangerEnabled or not Toggles.SkinChangerEnabled.Value then return end
    getgenv().Ghosted_ApplySkins()
    getgenv().Ghosted_ApplyBullets()
end

local function localPlayerIsKO()
    local char = getgenv().LocalPlayer.Character
    local body = char and char:FindFirstChild("BodyEffects")
    local ko = (body and body:FindFirstChild("K.O") and body["K.O"].Value) or (char and char:FindFirstChild("KO") and char.KO.Value)
    return ko
end

local function isValidAutoHealTarget(pChar, myRoot)
    if not pChar or not myRoot or myRoot.Parent == nil then return false end
    local be = pChar:FindFirstChild("BodyEffects")
    local pHum = pChar:FindFirstChildOfClass("Humanoid")
    local pRoot = pChar:FindFirstChild("HumanoidRootPart")
    if not pRoot then return false end

    local isKO = (be and be:FindFirstChild("K.O") and be["K.O"].Value) or (pChar:FindFirstChild("KO") and pChar.KO.Value)
    local isDead = (be and be:FindFirstChild("Dead") and be.Dead.Value) or (pHum and pHum.Health <= 0)
    
    if not isKO or isDead then return false end
    return pRoot.Position.Y < 5000 and pRoot.Position.Y > -500 and (pRoot.Position - myRoot.Position).Magnitude <= 2500
end

local function getValidAutoHealPlayers()
    local myRoot = getgenv().LocalPlayer.Character and getgenv().LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not myRoot then return {} end
    local targets = {}
    for _, p in ipairs(getgenv().Players:GetPlayers()) do
        if p ~= getgenv().LocalPlayer and isValidAutoHealTarget(p.Character, myRoot) then
            table.insert(targets, p)
        end
    end
    return targets
end

local autoHealActive = false
task.spawn(function()
    while task.wait(0.1) do
        if Toggles.AutoHealEnabled and Toggles.AutoHealEnabled.Value and not autoHealActive then
            local char = getgenv().LocalPlayer.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if not hum or not hrp or localPlayerIsKO() then continue end

            local threshold = Options.AutoHealThreshold and Options.AutoHealThreshold.Value or 50
            local maxHealth = hum.MaxHealth > 0 and hum.MaxHealth or 100
            if (hum.Health / maxHealth) * 100 >= threshold then continue end

            local koPlayers = getValidAutoHealPlayers()
            if #koPlayers == 0 then continue end

            local targetPlayer = koPlayers[math.random(1, #koPlayers)]
            autoHealActive = true
            local oldCFrame = hrp.CFrame
            getgenv().Library:Notify("Auto Healing: Teleporting to " .. (targetPlayer.DisplayName or targetPlayer.Name))
            
            local healStart = tick()
            local healMaxDuration = 8
            local healAbortKO = false

            while tick() - healStart < healMaxDuration do
                local char = getgenv().LocalPlayer.Character
                local hum = char and char:FindFirstChildOfClass("Humanoid")
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                if not hum or not hrp or not hum.Parent then break end
                if localPlayerIsKO() then healAbortKO = true; break end

                local maxHealth = hum.MaxHealth > 0 and hum.MaxHealth or 100
                if (hum.Health / maxHealth) * 100 >= threshold + 5 or hum.Health >= maxHealth then break end

                if not targetPlayer or targetPlayer.Parent ~= getgenv().Players then
                    koPlayers = getValidAutoHealPlayers()
                    if #koPlayers == 0 then break end
                    targetPlayer = koPlayers[math.random(1, #koPlayers)]
                end

                local targetChar = targetPlayer and targetPlayer.Character
                if not isValidAutoHealTarget(targetChar, hrp) then
                    koPlayers = getValidAutoHealPlayers()
                    if #koPlayers == 0 then break end
                    targetPlayer = koPlayers[math.random(1, #koPlayers)]
                    targetChar = targetPlayer.Character
                end

                local targetRoot = targetChar and targetChar:FindFirstChild("HumanoidRootPart")
                local currentTorso = targetChar and (targetChar:FindFirstChild("UpperTorso") or targetChar:FindFirstChild("Torso") or targetRoot)
                
                if currentTorso then
                    getgenv().isCurrentlyStomping = true
                    pcall(function() hrp:SetNetworkOwner(getgenv().LocalPlayer) end)
                    local pos = currentTorso.Position + Vector3.new(0, 3, 0)
                    local look = hrp.CFrame.LookVector
                    local flatLook = Vector3.new(look.X, 0, look.Z)
                    if flatLook.Magnitude < 1e-3 then flatLook = Vector3.new(0, 0, -1) end
                    
                    pcall(function()
                        hrp.CFrame = CFrame.lookAt(pos, pos + flatLook.Unit)
                        hrp.Velocity = Vector3.zero
                    end)
                    
                    getgenv().MainEvent:FireServer("Stomp")
                end
                task.wait(0.1)
            end

            getgenv().isCurrentlyStomping = false

            local char = getgenv().LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp and oldCFrame then
                pcall(function()
                    hrp.CFrame = oldCFrame
                    hrp.Velocity = Vector3.zero
                end)
            end
            autoHealActive = false
            getgenv().Library:Notify(healAbortKO and "Auto Heal stopped (K.O.)" or "Heal Complete")
        end
    end
end)

getgenv().SpectateConnection = nil
getgenv().LastShotTime = 0
getgenv().lastMeleeFire = 0
getgenv().isCurrentlyStomping = false

getgenv().trackCharacter = function(char)
    if not char then return end
    local ff = char:FindFirstChildOfClass("ForceField")
    if ff then getgenv().forceFieldTimers[char] = workspace:GetServerTimeNow() end
    char.ChildAdded:Connect(function(child)
        if child:IsA("ForceField") then getgenv().forceFieldTimers[char] = workspace:GetServerTimeNow() end
    end)
end

getgenv().trackPlayer = function(plr)
    if plr.Character then getgenv().trackCharacter(plr.Character) end
    plr.CharacterAdded:Connect(getgenv().trackCharacter)
end

for _, plr in ipairs(getgenv().Players:GetPlayers()) do getgenv().trackPlayer(plr) end
getgenv().Players.PlayerAdded:Connect(getgenv().trackPlayer)

getgenv().TargetCleanupConnection = getgenv().Players.PlayerRemoving:Connect(function(plr)
    if getgenv().ForceHitTarget == plr then
        getgenv().ForceHitTarget = nil
        getgenv().SetupDamageDetection(nil)
        if getgenv().TracerLine then getgenv().TracerLine.Visible = false end
        if getgenv().TracerOutline then getgenv().TracerOutline.Visible = false end
    end
    if getgenv().ForceHitTarget2 == plr then
        getgenv().ForceHitTarget2 = nil
        getgenv().SetupDamageDetection(nil)
        if getgenv().TracerLine2 then getgenv().TracerLine2.Visible = false end
        if getgenv().TracerOutline2 then getgenv().TracerOutline2.Visible = false end
    end
end)

getgenv().TracerOutline = Drawing.new("Line")
getgenv().TracerOutline.Thickness = 3; getgenv().TracerOutline.Color = Color3.fromRGB(0, 0, 0); getgenv().TracerOutline.Visible = false; getgenv().TracerOutline.ZIndex = 1

getgenv().TracerLine = Drawing.new("Line")
getgenv().TracerLine.Thickness = 1; getgenv().TracerLine.Color = Color3.fromRGB(255, 255, 255); getgenv().TracerLine.Visible = false; getgenv().TracerLine.ZIndex = 2

getgenv().TracerOutline2 = Drawing.new("Line")
getgenv().TracerOutline2.Thickness = 3; getgenv().TracerOutline2.Color = Color3.fromRGB(0, 0, 0); getgenv().TracerOutline2.Visible = false; getgenv().TracerOutline2.ZIndex = 1

getgenv().TracerLine2 = Drawing.new("Line")
getgenv().TracerLine2.Thickness = 1; getgenv().TracerLine2.Color = Color3.fromRGB(255, 255, 255); getgenv().TracerLine2.Visible = false; getgenv().TracerLine2.ZIndex = 2

getgenv().HitNotifGui = Instance.new("ScreenGui")
getgenv().HitNotifGui.Name = "LarpticHitNotifs"; getgenv().HitNotifGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
getgenv().coreGui = pcall(function() return game:GetService("CoreGui") end) and game:GetService("CoreGui") or getgenv().LocalPlayer:WaitForChild("PlayerGui")
getgenv().HitNotifGui.Parent = getgenv().coreGui

getgenv().notifContainer = Instance.new("Frame")
getgenv().notifContainer.Name = "Container"; getgenv().notifContainer.BackgroundTransparency = 1; getgenv().notifContainer.Size = UDim2.new(0, 300, 0.8, 0)
getgenv().notifContainer.Parent = getgenv().HitNotifGui

getgenv().listLayout = Instance.new("UIListLayout")
getgenv().listLayout.Padding = UDim.new(0, 8); getgenv().listLayout.SortOrder = Enum.SortOrder.LayoutOrder; getgenv().listLayout.Parent = getgenv().notifContainer

getgenv().UpdateNotifPosition = function(mode)
    local configs = {
        ["Top Left"] = { Anchor = Vector2.new(0, 0), Position = UDim2.new(0.02, 0, 0.05, 0), VAlign = Enum.VerticalAlignment.Top, HAlign = Enum.HorizontalAlignment.Left },
        ["Top Right"] = { Anchor = Vector2.new(1, 0), Position = UDim2.new(0.98, 0, 0.05, 0), VAlign = Enum.VerticalAlignment.Top, HAlign = Enum.HorizontalAlignment.Right },
        ["Bottom Center"] = { Anchor = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 0.95, 0), VAlign = Enum.VerticalAlignment.Bottom, HAlign = Enum.HorizontalAlignment.Center },
        ["Center"] = { Anchor = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 0), VAlign = Enum.VerticalAlignment.Center, HAlign = Enum.HorizontalAlignment.Center }
    }
    local cfg = configs[mode]
    if cfg then
        getgenv().notifContainer.AnchorPoint = cfg.Anchor; getgenv().notifContainer.Position = cfg.Position
        getgenv().listLayout.VerticalAlignment = cfg.VAlign; getgenv().listLayout.HorizontalAlignment = cfg.HAlign
    end
end

getgenv().CreateDamageIndicator = function(part, damage)
    if not Toggles.DamageIndicators.Value or not part then return end
    local anchor = Instance.new("Part")
    anchor.Anchored = true; anchor.CanCollide = false; anchor.Transparency = 1
    anchor.Size = Vector3.new(0.1, 0.1, 0.1); anchor.Position = part.Position; anchor.Parent = workspace
    
    local bbg = Instance.new("BillboardGui")
    bbg.AlwaysOnTop = true; bbg.Size = UDim2.new(0, 200, 0, 50)
    
    local randX = math.random(-15, 15) / 10; local randY = math.random(-5, 5) / 10
    local startOffset = Vector3.new(randX, 1.5 + randY, 0)
    bbg.StudsOffset = startOffset; bbg.Adornee = anchor; bbg.Parent = getgenv().coreGui
    
    local label = Instance.new("TextLabel")
    label.BackgroundTransparency = 1; label.Size = UDim2.new(1, 0, 1, 0)
    label.Font = Enum.Font.Code; label.Text = tostring(math.floor(damage + 0.5))
    label.TextColor3 = Options.IndicatorColor.Value; label.TextSize = 28; label.TextStrokeTransparency = 1
    
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 2; stroke.Color = Options.IndicatorStrokeColor and Options.IndicatorStrokeColor.Value or Color3.fromRGB(15, 15, 15)
    stroke.LineJoinMode = Enum.LineJoinMode.Round; stroke.Parent = label
    
    label.Rotation = math.random(-35, 35); label.Parent = bbg
    local scale = Instance.new("UIScale")
    scale.Scale = 0; scale.Parent = label
    
    task.spawn(function()
        getgenv().TweenService:Create(scale, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
        getgenv().TweenService:Create(label, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Rotation = math.random(-5, 5)}):Play()
        getgenv().TweenService:Create(bbg, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {StudsOffset = startOffset + Vector3.new(0, 1.5, 0)}):Play()
        
        task.wait(Options.IndicatorDuration and Options.IndicatorDuration.Value or 1.0)
        
        getgenv().TweenService:Create(bbg, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {StudsOffset = startOffset + Vector3.new(0, 0.5, 0)}):Play()
        getgenv().TweenService:Create(label, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {TextTransparency = 1}):Play()
        getgenv().TweenService:Create(stroke, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Transparency = 1}):Play()
        local shrinkOut = getgenv().TweenService:Create(scale, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Scale = 0})
        
        shrinkOut:Play()
        shrinkOut.Completed:Wait()
        bbg:Destroy(); anchor:Destroy()
    end)
end

getgenv().HitSounds = {["Rust Headshot"]  = "138750331387064",["Neverlose"]      = "110168723447153",["Bubble"]         = "6534947588",
    ["Laser"]          = "7837461331", ["Steve"]          = "4965083997",["Call of Duty"]   = "5952120301",["Bat"]            = "3333907347", ["TF2 Critical"]   = "296102734", ["Saber"]          = "8415678813",
    ["Bameware"]       = "3124331820", ["Money"]          = "13956013041", ["Notif"]          = "6696469190",
    ["Shutter"]        = "10066921516", ["RIFK7"]          = "9102080552",["LazerBeam"]      = "130791043",
    ["WindowsXPError"] = "160715357", ["TF2Hitsound"]    = "3455144981",["TF2Bat"]         = "3333907347",
    ["BowHit"]         = "1053296915",["Bow"]            = "3442683707",["OSU"]            = "7147454322",
    ["OneNN"]          = "7349055654", ["Rust"]           = "6565371338",["TF2Pan"]         = "3431749479",
    ["Mario"]          = "5709456554", ["Bell"]           = "6534947240", ["Pick"]           = "1347140027",["Pop"]            = "198598793",["Sans"]           = "3188795283", ["Fart"]           = "130833677",
    ["Big"]            = "5332005053", ["Vine"]           = "5332680810", ["Bruh"]           = "4578740568",
    ["Skeet"]          = "5633695679", ["Fatality"]       = "6534947869",["Bonk"]           = "5766898159",["Minecraft"]      = "5869422451", ["Gamesense"]      = "4817809188", ["Bamboo"]         = "3769434519",
    ["Crowbar"]        = "546410481",["Weeb"]           = "6442965016", ["Beep"]           = "8177256015",["Bambi"]          = "8437203821",["Stone"]          = "3581383408",["Old Fatality"]   = "6607142036",["Click"]          = "8053704437",["Ding"]           = "7149516994", ["Snow"]           = "6455527632",
    ["Osu"]            = "7149255551",["TF2"]            = "2868331684",["Slime"]          = "6916371803",
    ["Among Us"]       = "5700183626",["One"]            = "7380502345",["BulletDeflect"]  = "1657157666",
}
getgenv().HitSoundList = {}
for name, _ in pairs(getgenv().HitSounds) do table.insert(getgenv().HitSoundList, name) end
table.sort(getgenv().HitSoundList); table.insert(getgenv().HitSoundList, "Custom")

getgenv().PlayHitSound = function()
    if not Toggles.HitSoundEnabled.Value then return end
    local soundId = Options.HitSoundChoice.Value == 'Custom' and Options.CustomHitSound.Value or getgenv().HitSounds[Options.HitSoundChoice.Value]
    if not soundId or soundId == "" then return end
    if string.match(soundId, "^%d+$") then soundId = "rbxassetid://" .. soundId end

    local sound = Instance.new("Sound")
    sound.SoundId = soundId; sound.Volume = 1; sound.Parent = workspace
    sound:Play(); getgenv().Debris:AddItem(sound, 2)
end

getgenv().notifTick = 0
getgenv().CreateHitNotification = function(playerName, damage)
    if not Toggles.HitNotifEnabled.Value then return end
    local c = Options.AccentColor.Value or Color3.fromRGB(160, 132, 220)
    local hex = string.format("#%02X%02X%02X", math.floor(c.R*255), math.floor(c.G*255), math.floor(c.B*255))
    
    local notif = Instance.new("TextLabel")
    notif.Size = UDim2.new(0, 0, 0, 25); notif.AutomaticSize = Enum.AutomaticSize.X; notif.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    notif.BackgroundTransparency = 1; notif.TextTransparency = 1; notif.TextStrokeTransparency = 1; notif.Font = Enum.Font.Code
    notif.TextSize = 14; notif.TextColor3 = Color3.fromRGB(255, 255, 255); notif.RichText = true
    notif.Text = string.format("hit <font color='%s'>%s</font> for <font color='%s'>%d</font>", hex, playerName, hex, math.floor(damage + 0.5))
    
    getgenv().notifTick = getgenv().notifTick + 1; notif.LayoutOrder = getgenv().notifTick

    local corner = Instance.new("UICorner"); corner.CornerRadius = UDim.new(0, 4); corner.Parent = notif
    local stroke = Instance.new("UIStroke"); stroke.Color = Options.OutlineColor and Options.OutlineColor.Value or Color3.fromRGB(40, 40, 40); stroke.Transparency = 1; stroke.Parent = notif
    local pad = Instance.new("UIPadding"); pad.PaddingLeft = UDim.new(0, 8); pad.PaddingRight = UDim.new(0, 8); pad.Parent = notif
    notif.Parent = getgenv().notifContainer

    local tiIn = TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    getgenv().TweenService:Create(notif, tiIn, {BackgroundTransparency = 0.4, TextTransparency = 0, TextStrokeTransparency = 0.5}):Play()
    getgenv().TweenService:Create(stroke, tiIn, {Transparency = 0}):Play()

    task.spawn(function()
        task.wait(2)
        local tiOut = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        getgenv().TweenService:Create(notif, tiOut, {BackgroundTransparency = 1, TextTransparency = 1, TextStrokeTransparency = 1}):Play()
        getgenv().TweenService:Create(stroke, tiOut, {Transparency = 1}):Play()
        task.wait(0.5); notif:Destroy()
    end)
end

getgenv().CreateBulletTracer = function(startPos, endPos, isDB)
    if not Toggles.BulletTracers.Value then return end
    local color = Options.BulletTracerColorOption.Value
    local duration = Options.TracerDuration.Value
    local steps = math.floor(duration * 50)
    if steps < 1 then steps = 1 end
    local waitTime = duration / steps
    
    local lineCount = isDB and 3 or 1
    for i = 1, lineCount do
        local targetPos = endPos
        local offset = Vector3.zero
        if isDB then
            local spread = Options.DBSpread.Value
            targetPos = targetPos + Vector3.new((math.random() - 0.5) * spread, (math.random() - 0.5) * spread, (math.random() - 0.5) * spread)
            local angle = math.rad((i - 1) * 120)
            offset = Vector3.new(math.cos(angle) * 0.12, math.sin(angle) * 0.12, 0)
        end
        
        local distance = (targetPos - startPos).Magnitude
        local tracer = Instance.new("Part")
        tracer.Anchored = true; tracer.CanCollide = false; tracer.Material = Enum.Material.Neon
        tracer.Color = color; tracer.Transparency = 0.2; tracer.Size = Vector3.new(0.04, 0.04, distance)
        tracer.CFrame = CFrame.lookAt(startPos, targetPos) * CFrame.new(offset) * CFrame.new(0, 0, -distance / 2)
        tracer.Parent = workspace
        
        task.spawn(function()
            for t = 1, steps do
                tracer.Transparency = 0.2 + (0.8 * (t / steps)); task.wait(waitTime)
            end
            tracer:Destroy()
        end)
    end
end

getgenv().SetupDamageDetection = function(target)
    if getgenv().TargetHealthConnection then getgenv().TargetHealthConnection:Disconnect(); getgenv().TargetHealthConnection = nil end
    if not target then return end
    
    local char = target.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    
    local lastHealth = hum.Health
    getgenv().TargetHealthConnection = hum:GetPropertyChangedSignal("Health"):Connect(function()
        local currentHealth = hum.Health
        if currentHealth < lastHealth then
            local damage = lastHealth - currentHealth
            local myChar = getgenv().LocalPlayer.Character
            if myChar then
                local hasTool = myChar:FindFirstChildOfClass("Tool")
                if hasTool then getgenv().PlayHitSound() end
                if Toggles.HitNotifEnabled and Toggles.HitNotifEnabled.Value then getgenv().CreateHitNotification(target.Name, damage) end
                if Toggles.DamageIndicators and Toggles.DamageIndicators.Value then
                    local hitPart = char:FindFirstChild(Options.HitPart.Value) or char:FindFirstChild("HumanoidRootPart")
                    getgenv().CreateDamageIndicator(hitPart, damage)
                end
                if Toggles.BulletTracers.Value then
                    local startPos = getgenv().Camera.CFrame.Position
                    if hasTool and hasTool:FindFirstChild("Handle") then startPos = hasTool.Handle.Position
                    elseif myChar:FindFirstChild("Right Arm") then startPos = myChar["Right Arm"].Position
                    elseif myChar:FindFirstChild("RightHand") then startPos = myChar["RightHand"].Position end
                    
                    local hitPart = char:FindFirstChild(Options.HitPart.Value) 
                    if hitPart then
                        local isDB = hasTool and string.lower(hasTool.Name) == "[doublebarrel]"
                        getgenv().CreateBulletTracer(startPos, hitPart.Position, isDB)
                    end
                end
            end
        end
        lastHealth = currentHealth
    end)
end

getgenv().isKO = function(p)
    if not Toggles.KOCheck.Value then return false end
    local c = p.Character
    if not c then return true end
    local h = c:FindFirstChild("Humanoid")
    local b = c:FindFirstChild("BodyEffects")
    return (h and h.Health <= 0) or (b and b:FindFirstChild("K.O") and b["K.O"].Value)
end

getgenv().isFullyDead = function(p)
    local c = p.Character
    if not c then return true end
    local h = c:FindFirstChild("Humanoid")
    local b = c:FindFirstChild("BodyEffects")
    return (h and h.Health <= 0) or (b and b:FindFirstChild("SDeath") and b["SDeath"].Value)
end

getgenv().wallCheck = function(a, b, ignore)
    if not Toggles.WallCheck.Value then return true end
    local rayParams = RaycastParams.new()
    rayParams.FilterDescendantsInstances = ignore
    rayParams.FilterType = Enum.RaycastFilterType.Blacklist
    local result = workspace:Raycast(a, b - a, rayParams)
    return not (result and result.Instance and result.Instance.CanCollide and not result.Instance:IsDescendantOf(getgenv().Players))
end

getgenv().Shoot = function(p)
    if not p or not p.Character then return end
    local character = p.Character
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    
    if Toggles.KOCheck.Value then
        if not humanoid or humanoid.Health <= 0 then return end
        local be = character:FindFirstChild("BodyEffects")
        if be and be:FindFirstChild("K.O") and be["K.O"].Value then return end
    end

    local targetPart = character:FindFirstChild(Options.HitPart.Value)
    if not targetPart then return end

    if Toggles.ForceFieldCheck.Value and not Toggles.EnablePrefire.Value then
        if character:FindFirstChildOfClass("ForceField") then return end
    end

    local char = getgenv().LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    local spoofCF = getgenv().ForceHit.CurrentStrafeCF or getgenv().CurrentStrafeCF
    local playerPos = (Toggles.StrafeToggle.Value and spoofCF) and spoofCF.Position or root.Position

    if Toggles.WallCheck.Value then
        local rayParams = RaycastParams.new()
        rayParams.FilterDescendantsInstances = {char, character, getgenv().DesyncPart}
        rayParams.FilterType = Enum.RaycastFilterType.Blacklist
        local res = workspace:Raycast(playerPos, targetPart.Position - playerPos, rayParams)
        if res and res.Instance and res.Instance.CanCollide and not res.Instance:IsDescendantOf(getgenv().Players) then return end
    end

    if Toggles.DistanceCheck.Value and (playerPos - targetPart.Position).Magnitude > Options.MaxDistance.Value then return end

    local args = {
        [1] = {
            [1] = {Normal=targetPart.Position,Instance=targetPart,Position=targetPart.Position},
            [2] = {Normal=targetPart.Position,Instance=targetPart,Position=targetPart.Position},
            [3] = {Normal=targetPart.Position,Instance=targetPart,Position=targetPart.Position},
            [4] = {Normal=targetPart.Position,Instance=targetPart,Position=targetPart.Position},
            [5] = {Normal=targetPart.Position,Instance=targetPart,Position=targetPart.Position},
        },
        [2] = {
            [1] = {thePart=targetPart,theOffset=Vector3.zero},
            [2] = {thePart=targetPart,theOffset=Vector3.zero},
            [3] = {thePart=targetPart,theOffset=Vector3.zero},
            [4] = {thePart=targetPart,theOffset=Vector3.zero},
            [5] = {thePart=targetPart,theOffset=Vector3.zero},
        },
        [3] = playerPos,
        [4] = playerPos,
        [5] = workspace:GetServerTimeNow()
    }

    getgenv().MainEvent:FireServer("Shoot", args)
    getgenv().LastShotTime = tick()
    getgenv().ForceHit.LastShotTime = tick()
end

getgenv().GetClosestToMouse = function()
    local mousePos = getgenv().UserInputService:GetMouseLocation()
    local fovCfg = getgenv().Config and getgenv().Config.Visual and getgenv().Config.Visual.FOV
    local shortest = fovCfg and fovCfg.Enabled and fovCfg.Size or 100
    local closest = nil
    
    for _, plr in ipairs(getgenv().Players:GetPlayers()) do
        if plr ~= getgenv().LocalPlayer and plr.Character then
            local part = plr.Character:FindFirstChild(Options.HitPart.Value)
            if part and not getgenv().isKO(plr) then
                local screenPos, visible = getgenv().Camera:WorldToViewportPoint(part.Position)
                if visible then
                    local dist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                    if dist < shortest then
                        shortest = dist; closest = plr
                    end
                end
            end
        end
    end
    return closest
end

getgenv().resetStrafeCamera = function()
    local char = getgenv().LocalPlayer.Character
    local hum = char and char:FindFirstChildWhichIsA("Humanoid")
    if hum then getgenv().Camera.CameraSubject = hum end
end

getgenv().destroyStrafeVisualizer = function()
    if getgenv().StrafeVisConnection then getgenv().StrafeVisConnection:Disconnect(); getgenv().StrafeVisConnection = nil end
    if getgenv().StrafeVisParts then
        for _, data in pairs(getgenv().StrafeVisParts) do
            if data.part then data.part:Destroy() end
        end
        getgenv().StrafeVisParts = nil
    end
end

getgenv().createStrafeVisualizer = function()
    getgenv().destroyStrafeVisualizer()
    local char = getgenv().LocalPlayer.Character or getgenv().LocalPlayer.CharacterAdded:Wait()
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    getgenv().StrafeVisParts = {}
    for _, p in ipairs(char:GetChildren()) do
        if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then
            local vis = Instance.new("Part")
            vis.Name = p.Name .. "_StrafeGhost"
            vis.Size = p.Size; vis.Anchored = true; vis.CanCollide = false
            vis.CastShadow = false; vis.Material = Enum.Material.Neon
            vis.Color = Color3.fromRGB(255, 255, 255); vis.Transparency = 0; vis.Parent = getgenv().Camera
            
            local offset = root.CFrame:Inverse() * p.CFrame
            getgenv().StrafeVisParts[p.Name] = {part = vis, offset = offset, currentCF = vis.CFrame}
        end
    end
    
    local alpha = 0.18
    getgenv().CurrentStrafeCF = root.CFrame
    getgenv().StrafeVisConnection = getgenv().RunService.RenderStepped:Connect(function()
        if not getgenv().CurrentStrafeCF then return end
        for _, data in pairs(getgenv().StrafeVisParts) do
            local targetCF = getgenv().CurrentStrafeCF * data.offset
            data.currentCF = data.currentCF:Lerp(targetCF, alpha)
            data.part.CFrame = data.currentCF
        end
    end)
end
local function stopStrafe()
    if getgenv().ForceHit.StrafeConnection then
        getgenv().ForceHit.StrafeConnection:Disconnect()
        getgenv().ForceHit.StrafeConnection = nil
    end
    destroyStrafeVisualizer()
    resetStrafeCamera()
end

local function startStrafe()
    if getgenv().ForceHit.StrafeConnection then getgenv().ForceHit.StrafeConnection:Disconnect() end
    if getgenv().ForceHit.VisualizeStrafe then createStrafeVisualizer() end

    local strafeTime = 0
    local voidPhase = false
    local voidTimer = 0

    getgenv().ForceHit.StrafeConnection = RunService.Heartbeat:Connect(function(dt)
        strafeTime = strafeTime + dt
        
        local target = getgenv().ForceHitTarget 
        if not (Toggles.StrafeToggle and Toggles.StrafeToggle.Value) or not target then
            stopStrafe()
            return
        end

        local char = LocalPlayer.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local targetChar = target.Character
        local targetRoot = targetChar and targetChar:FindFirstChild("HumanoidRootPart")
        
        if not root or not targetRoot or not targetChar:FindFirstChildOfClass("Humanoid") or targetChar:FindFirstChildOfClass("Humanoid").Health <= 0 then
            return
        end

        pcall(function() root:SetNetworkOwner(LocalPlayer) end)

        local targetPos = targetRoot.Position
        local desired = nil

        local mode = Options.StrafeModeDropdown.Value
        if mode == "Orbit" then
            local speed = Options.StrafeSpeedSlider.Value
            local dist = Options.StrafeDistanceSlider.Value
            local height = Options.StrafeHeightSlider.Value
            desired = CFrame.lookAt(targetPos + Vector3.new(math.cos(strafeTime * speed) * dist, height, math.sin(strafeTime * speed) * dist), targetPos)
            
        elseif mode == "Random" then
            local t = strafeTime * 20
            local offset = Vector3.new(math.noise(t, 0, 0) * 15, Options.StrafeHeightSlider.Value, math.noise(0, 0, t) * 15)
            desired = CFrame.lookAt(targetPos + offset, targetPos)
            
        elseif mode == "Void Shoot" then
            voidTimer = voidTimer + dt
            local isShooting = (tick() - (getgenv().LastShotTime or 0) < 0.1)
            
            if isShooting then
                desired = CFrame.lookAt(targetPos + Vector3.new(0, 150, 2), targetPos) 
                if voidTimer >= 0.13 then 
                    voidPhase = not voidPhase
                    voidTimer = 0
                end
                desired = voidPhase and CFrame.new(targetPos + Vector3.new(0, 1000, 0)) or CFrame.lookAt(targetPos + Vector3.new(0, 3, 3), targetPos)
            end
        end

        if desired then
            getgenv().ForceHit.CurrentStrafeCF = desired 
            
            if Toggles.spoofstrafe and Toggles.spoofstrafe.Value then
                local oldCF = root.CFrame
                root.CFrame = desired
                RunService.RenderStepped:Wait()
                root.CFrame = oldCF
            else
                root.CFrame = desired
            end
        end
    end)
end

getgenv().startSpectate = function()
    if getgenv().SpectateConnection then getgenv().SpectateConnection:Disconnect() getgenv().SpectateConnection = nil end
    getgenv().SpectateConnection = getgenv().RunService.Heartbeat:Connect(function()
        if not (Toggles.SpectateTarget and Toggles.SpectateTarget.Value) then
            getgenv().resetStrafeCamera()
            if getgenv().SpectateConnection then getgenv().SpectateConnection:Disconnect() end
            getgenv().SpectateConnection = nil
            return
        end
        if not getgenv().ForceHitTarget or not getgenv().ForceHitTarget.Character then return end
        local targetHum = getgenv().ForceHitTarget.Character:FindFirstChildWhichIsA("Humanoid")
        if targetHum and getgenv().Camera.CameraSubject ~= targetHum then
            getgenv().Camera.CameraType = Enum.CameraType.Custom
            getgenv().Camera.CameraSubject = targetHum
        end
    end)
end

getgenv().Window = getgenv().Library:CreateWindow({ Title = getgenv().gameName, Center = true, AutoShow = true, Resizable = true, TabPadding = 10 })

getgenv().Tabs = {
    Main = getgenv().Window:AddTab('Combat'),
    Misc = getgenv().Window:AddTab('Misc'),
    Visuals = getgenv().Window:AddTab('Visuals'),
    Settings = getgenv().Window:AddTab('Settings'),
}
getgenv().Tabs.Character = getgenv().Tabs.Misc

if not getgenv().AntiStaffSettings then
    getgenv().AntiStaffSettings = {
        Enabled = true,
        Action = "Notify"
    }
end

getgenv().MainGb = getgenv().Tabs.Main:AddLeftGroupbox('Force Hit')getgenv().VoidGb = getgenv().Tabs.Main:AddLeftGroupbox('Void')



local desync_setback = Instance.new("Part")
desync_setback.Name = "SND_DesyncSetback"
desync_setback.Size = Vector3.new(2, 2, 1)
desync_setback.Anchored = true
desync_setback.CanCollide = false
desync_setback.Transparency = 1
desync_setback.Parent = getgenv().Workspace

getgenv().desync = {
    enabled = false,
    mode = "Void",
    old_position = nil,
    target_position = nil,
    void_time = 0.4,
    normal_time = 0.133,
    timer = 0,
    custom_offset = Vector3.new(0, 0, 0),
}

local DesyncIndicatorGui = Instance.new("ScreenGui")
DesyncIndicatorGui.Name = "SND_DesyncIndicator"
DesyncIndicatorGui.ResetOnSpawn = false
DesyncIndicatorGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
DesyncIndicatorGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local DesyncIndicatorImage = Instance.new("ImageLabel")
DesyncIndicatorImage.Name = "Indicator"
DesyncIndicatorImage.Size = UDim2.new(0, 55, 0, 55)
DesyncIndicatorImage.BackgroundTransparency = 1
DesyncIndicatorImage.Image = "rbxassetid://17446642923"
DesyncIndicatorImage.Visible = false
DesyncIndicatorImage.ZIndex = 10
DesyncIndicatorImage.Parent = DesyncIndicatorGui

local dToolCheckEnabled = false
local dIndicatorEnabled = false
local dIndicatorSpin = false
local dIndicatorSize = 55
local dIndicatorRotation = 0
local dIndicatorLastPos = nil

local StrafeVis = {
    Enabled = false,
    Transparency = 0.5,
    Color = Color3.fromRGB(0, 140, 255),
    Folder = nil,
    Connection = nil,
    Parts = {},
    LastTool = nil,
}

local function dDestroyVisualizer()
    if StrafeVis.Connection then StrafeVis.Connection:Disconnect() StrafeVis.Connection = nil end
    if StrafeVis.Folder then StrafeVis.Folder:Destroy() StrafeVis.Folder = nil end
    StrafeVis.Parts = {}
end

local function dCreateVisualizer()
    dDestroyVisualizer()
    local char = getgenv().LocalPlayer.Character if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart") if not root then return end
    local folder = Instance.new("Folder")
    folder.Name = "SND_DesyncVisualizer"
    folder.Parent = getgenv().Workspace
    StrafeVis.Folder = folder
    for _, p in ipairs(char:GetChildren()) do
        if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then
            local ghost = Instance.new("Part")
            ghost.Size = p.Size ghost.Anchored = true ghost.CanCollide = false ghost.CastShadow = false
            ghost.Material = Enum.Material.Neon ghost.Color = StrafeVis.Color ghost.Transparency = StrafeVis.Transparency
            ghost.TopSurface = Enum.SurfaceType.Smooth ghost.BottomSurface = Enum.SurfaceType.Smooth
            ghost.Parent = folder
            StrafeVis.Parts[p] = { part = ghost, offset = root.CFrame:Inverse() * p.CFrame }
        end
    end
    StrafeVis.Connection = getgenv().RunService.RenderStepped:Connect(function()
        local targetCF = getgenv().desync.target_position
        for realPart, data in pairs(StrafeVis.Parts) do
            if not realPart.Parent or not data.part or not data.part.Parent then
                StrafeVis.Parts[realPart] = nil
            else
                if targetCF then data.part.CFrame = targetCF * data.offset end
                data.part.Color = StrafeVis.Color
                data.part.Transparency = StrafeVis.Enabled and StrafeVis.Transparency or 1
            end
        end
    end)
end

local REFRESH_COOLDOWN = 0.04
local FORCE_REFRESH_EVERY = 0.04
local dLastAttempt = 0
local dLastFullCreate = 0

local function dTryUpdateVisualizer()
    if not StrafeVis.Enabled then return end
    local now = tick()
    if now - dLastAttempt < REFRESH_COOLDOWN then return end
    dLastAttempt = now
    local needsFull = now - dLastFullCreate >= FORCE_REFRESH_EVERY
    if not needsFull then
        local char = getgenv().LocalPlayer.Character
        if char then
            local currentTool = char:FindFirstChildWhichIsA("Tool")
            if currentTool ~= StrafeVis.LastTool then needsFull = true StrafeVis.LastTool = currentTool end
        end
    end
    if needsFull then
        dCreateVisualizer()
        dLastFullCreate = now
    else
        for _, data in pairs(StrafeVis.Parts) do
            if data.part and data.part.Parent then
                data.part.Color = StrafeVis.Color
                data.part.Transparency = StrafeVis.Transparency
            end
        end
    end
end

local function dSetupVisualizerListeners(char)
    if not char then return end
    char.ChildAdded:Connect(function(child) if child:IsA("Tool") or child:IsA("Accessory") then task.delay(0.03, dTryUpdateVisualizer) end end)
    char.ChildRemoved:Connect(function(child) if child:IsA("Tool") or child:IsA("Accessory") then task.delay(0.03, dTryUpdateVisualizer) end end)
end

task.spawn(function()
    while true do
        task.wait(0.033)
        dTryUpdateVisualizer()
    end
end)

getgenv().LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait(0.15)
    if StrafeVis.Enabled then
        dCreateVisualizer()
        StrafeVis.LastTool = nil
        dLastFullCreate = tick()
        dSetupVisualizerListeners(char)
    end
end)

local function dResetCamera()
    local char = getgenv().LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        getgenv().Workspace.CurrentCamera.CameraSubject = char.Humanoid
    end
end

local function setDesync(state)
    getgenv().desync.enabled = state
    if not state then
        dResetCamera()
        getgenv().desync.timer = 0
        getgenv().desync.target_position = nil
        desync_setback.CFrame = CFrame.new(0, -2000, 0)
        DesyncIndicatorImage.Visible = false
        dIndicatorRotation = 0
        dIndicatorLastPos = nil
    end
end

getgenv().RunService.Heartbeat:Connect(function(dt)
    local desync = getgenv().desync
    if not desync.enabled then
        desync.target_position = nil
        return
    end
    local char = getgenv().LocalPlayer.Character
    if not char then return end
    if dToolCheckEnabled and char:FindFirstChildWhichIsA("Tool") then
        desync.target_position = nil
        dResetCamera()
        desync_setback.CFrame = CFrame.new(0, -2000, 0)
        return
    end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    desync.old_position = root.CFrame
    local target = desync.old_position
    if desync.mode == "void" then
        target = CFrame.new(root.Position + Vector3.new(math.random(-9e8, 9e8), math.random(1e8, 9e8), math.random(-9e8, 9e8)))
    elseif desync.mode == "spam void" then
        desync.timer += dt
        if desync.timer < desync.void_time then
            target = CFrame.new(root.Position + Vector3.new(math.random(-9e8, 9e8), math.random(1e8, 9e8), math.random(-9e8, 9e8)))
        end
        if desync.timer >= desync.void_time + desync.normal_time then desync.timer = 0 end
    elseif desync.mode == "Chaos" then
        local t = tick() * 999
        target = CFrame.new(root.Position + Vector3.new(math.sin(t) * 9e8, math.abs(math.cos(t * 1.3)) * 9e8, math.sin(t * 0.7) * 9e8))
    elseif desync.mode == "Epilepsy" then
        local flip = math.floor(tick() * 60) % 2 == 0
        target = flip and CFrame.new(root.Position + Vector3.new(9e8, 9e8, 9e8)) or CFrame.new(root.Position + Vector3.new(-9e8, -9e8, -9e8))
    elseif desync.mode == "Custom" then
        target = desync.old_position + desync.custom_offset
    elseif desync.mode == "Underground" then
        target = CFrame.new(root.Position - Vector3.new(0, 6, 0)) * CFrame.Angles(math.pi/2, 0, 0)
    end
    desync.target_position = target
    dIndicatorLastPos = target.Position
    root.CFrame = target
    desync_setback.CFrame = desync.old_position
    getgenv().Workspace.CurrentCamera.CameraSubject = desync_setback
    getgenv().RunService.RenderStepped:Wait()
    root.CFrame = desync.old_position
    desync_setback.CFrame = CFrame.new(0, -2000, 0)
    dResetCamera()
end)

getgenv().RunService.RenderStepped:Connect(function()
    if not getgenv().desync.enabled or not dIndicatorEnabled or not dIndicatorLastPos then
        DesyncIndicatorImage.Visible = false
        return
    end
    local cam = getgenv().Workspace.CurrentCamera
    local screenPos, onScreen = cam:WorldToViewportPoint(dIndicatorLastPos)
    if onScreen then
        local half = dIndicatorSize / 2
        DesyncIndicatorImage.Size = UDim2.new(0, dIndicatorSize, 0, dIndicatorSize)
        DesyncIndicatorImage.Position = UDim2.new(0, screenPos.X - half, 0, screenPos.Y - half)
        if dIndicatorSpin then
            dIndicatorRotation = (dIndicatorRotation + 2) % 360
            DesyncIndicatorImage.Rotation = dIndicatorRotation
        else
            DesyncIndicatorImage.Rotation = 0
        end
        DesyncIndicatorImage.Visible = true
    else
        DesyncIndicatorImage.Visible = false
    end
end)

if getgenv().LocalPlayer.Character then
    task.delay(0.1, function() dSetupVisualizerListeners(getgenv().LocalPlayer.Character) end)
end


local plrs = game:GetService("Players")
local uis = game:GetService("UserInputService")
local lp = plrs.LocalPlayer

local animId = "70883871260184"
local gm_on = false
local gm_root, gm_ghost, gm_hip, gm_track

local function gm_anim()
    local char = lp.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    local animator = hum:FindFirstChildOfClass("Animator") or Instance.new("Animator", hum)
    local a = Instance.new("Animation")
    a.AnimationId = "rbxassetid://" .. animId
    gm_track = animator:LoadAnimation(a)
    gm_track.Priority = Enum.AnimationPriority.Core
    gm_track:Play(0, 1, 0)
    a:Destroy()
    task.delay(0, function()
        if gm_track then
            gm_track.TimePosition = 0.7
            task.delay(0.3, function()
                if gm_track then gm_track:AdjustSpeed(math.huge) end
            end)
        end
    end)
    return true
end

local function gm_fake()
    local char = lp.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum or hum.Health <= 0 then return end
    gm_root = char:FindFirstChild("HumanoidRootPart")
    if not gm_root then return end
    gm_hip = hum.HipHeight
    gm_ghost = gm_root:Clone()
    gm_ghost.Name = "r"
    gm_ghost.Parent = char
    gm_ghost.CFrame = gm_root.CFrame
    gm_ghost.Transparency = 1
    gm_ghost.CanCollide = false
    gm_ghost.Anchored = false
    gm_ghost.CastShadow = false
    gm_ghost.Massless = true
    gm_root.Transparency = 1
    gm_root.CanCollide = false
    gm_root.CastShadow = false
    char.PrimaryPart = gm_ghost
end

local function gm_undo()
    local char = lp.Character
    if not char or not gm_root or not gm_ghost then gm_root = nil return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    gm_ghost:Destroy() gm_ghost = nil
    gm_root.Transparency = 1
    gm_root.CanCollide = true
    gm_root.CastShadow = true
    char.PrimaryPart = gm_root
    if hum then
        hum.HipHeight = gm_hip or 0
        hum:ChangeState(Enum.HumanoidStateType.Running)
    end
    gm_root = nil
end

local function gm_start()
    if gm_on then return end
    gm_on = true
    if not gm_anim() then gm_on = false return end
    task.wait(0.1)
    gm_fake()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Godmode",
        Text = "Godmode is now enabled",
        Duration = 3,
    })
end

local function gm_stop()
    if not gm_on then return end
    gm_on = false
    if gm_track then pcall(function() gm_track:Stop() end) gm_track = nil end
    gm_undo()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Godmode",
        Text = "Godmode is now disabled nigga",
        Duration = 3,
    })
end

lp.CharacterRemoving:Connect(function()
    if gm_on then gm_stop() end
end)

VoidGb:AddToggle('GodmodeToggle', {
    Text = 'Godmode',
    Default = false,
    Callback = function(v)
        if v then gm_start() else gm_stop() end
    end
}):AddKeyPicker('GodmodeKeybind', {
    Default = 'B',
    Mode = 'Toggle',
    Text = 'Godmode',
    Callback = function(state)
        if uis:GetFocusedTextBox() then return end
        if not Toggles.GodmodeToggle.Value then return end
        if state then gm_start() else gm_stop() end
    end
})
VoidGb:AddToggle("DesyncToggle", {
    Text = "enable desync", Default = false,
    Callback = function(v)
        Toggles.DesyncToggle:SetText(v and "Anti Aim: ON" or "Anti Aim: OFF")
        if not v then setDesync(false) end
    end
}):AddKeyPicker("DesyncKeybind", {
    Text = "Bind", Default = "V", Mode = "Toggle",
    Callback = function()
        if getgenv().UserInputService:GetFocusedTextBox() then return end
        if not Toggles.DesyncToggle.Value then return end
        setDesync(not getgenv().desync.enabled)
    end
})

VoidGb:AddDropdown("DesyncMethod", {
    Values = {"void", "spam void", "Chaos", "Epilepsy", "Custom", "Underground"},
    Default = "void", Text = "Mode",
    Callback = function(v) getgenv().desync.mode = v end
})

VoidGb:AddToggle("ToolCheckToggle", {
    Text = "Disable when tool held", Default = false,
    Callback = function(v) dToolCheckEnabled = v end
})

VoidGb:AddToggle("StrafeVisToggle", {
    Text = "Rig", Default = false,
    Callback = function(v)
        StrafeVis.Enabled = v
        if v then
            dCreateVisualizer()
            StrafeVis.LastTool = nil
            dLastFullCreate = tick()
            if getgenv().LocalPlayer.Character then dSetupVisualizerListeners(getgenv().LocalPlayer.Character) end
        else
            dDestroyVisualizer()
        end
    end
}):AddColorPicker("VisColor", {
    Default = Color3.fromRGB(0, 140, 255),
    Callback = function(v)
        StrafeVis.Color = v
        dTryUpdateVisualizer()
    end
})

VoidGb:AddSlider("VisTransparency", {
    Text = "Rig Transparency", Default = 0.5, Min = 0, Max = 1, Rounding = 2,
    Callback = function(v) StrafeVis.Transparency = v dTryUpdateVisualizer() end
})

VoidGb:AddToggle("IndicatorToggle", {
    Text = "Indicator", Default = false,
    Callback = function(v)
        dIndicatorEnabled = v
        if not v then
            DesyncIndicatorImage.Visible = false
            dIndicatorRotation = 0
        end
    end
})

VoidGb:AddToggle("IndicatorSpin", {
    Text = "Spin Indicator", Default = false,
    Callback = function(v)
        dIndicatorSpin = v
        if not v then dIndicatorRotation = 0 DesyncIndicatorImage.Rotation = 0 end
    end
})

VoidGb:AddSlider("IndicatorSize", {
    Text = "Indicator Size", Default = 55, Min = 20, Max = 150, Rounding = 0,
    Callback = function(v) dIndicatorSize = v end
})

VoidGb:AddSlider("VoidTime", {
    Text = "Void Time", Default = 0.4, Min = 0.05, Max = 2, Rounding = 2,
    Callback = function(v) getgenv().desync.void_time = v end
})

VoidGb:AddSlider("GroundTime", {
    Text = "Ground Time", Default = 0.133, Min = 0.05, Max = 2, Rounding = 2,
    Callback = function(v) getgenv().desync.normal_time = v end
})

VoidGb:AddSlider("CustomX", {
    Text = "X Offset", Default = 0, Min = -25, Max = 25, Rounding = 1,
    Callback = function(v) local d = getgenv().desync d.custom_offset = Vector3.new(v, d.custom_offset.Y, d.custom_offset.Z) end
})

VoidGb:AddSlider("CustomY", {
    Text = "Y Offset", Default = 0, Min = -25, Max = 25, Rounding = 1,
    Callback = function(v) local d = getgenv().desync d.custom_offset = Vector3.new(d.custom_offset.X, v, d.custom_offset.Z) end
})

VoidGb:AddSlider("CustomZ", {
    Text = "Z Offset", Default = 0, Min = -25, Max = 25, Rounding = 1,
    Callback = function(v) local d = getgenv().desync d.custom_offset = Vector3.new(d.custom_offset.X, d.custom_offset.Y, v) end
})

local function createFOV()
    local fov = getgenv().Config.Visual.FOV

    local function makeDrawing(type)
        local d = Drawing.new(type)
        d.Visible = false
        return d
    end

    if not fov.InnerCircle then fov.InnerCircle = makeDrawing("Circle") end
    if not fov.OuterCircle then fov.OuterCircle = makeDrawing("Circle") end
    if not fov.FillCircle then fov.FillCircle = makeDrawing("Circle") end

    if not fov.Lines then
        fov.Lines = {}
        for i = 1, 12 do fov.Lines[i] = makeDrawing("Line") end
    end

    if not fov.Triangles then
        fov.Triangles = {}
        for i = 1, 6 do fov.Triangles[i] = makeDrawing("Triangle") end
    end

    if not fov.ScreenGui then
        local sg = Instance.new("ScreenGui")
        sg.Name = "GhostedFOV"
        sg.IgnoreGuiInset = true
        sg.DisplayOrder = 999
        sg.Parent = game.CoreGui
        fov.ScreenGui = sg

        local frame = Instance.new("Frame")
        frame.Name = "Main"
        frame.BackgroundTransparency = 0
        frame.BorderSizePixel = 0
        frame.AnchorPoint = Vector2.new(0.5, 0.5)
        frame.Parent = sg
        fov.MainFrame = frame

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(1, 0)
        corner.Parent = frame
        fov.UICorner = corner
    end

    getgenv().GhostedFOV = {
        Inner = fov.InnerCircle,
        Outer = fov.OuterCircle,
        ScreenGui = fov.ScreenGui,
        MainFrame = fov.MainFrame,
        UICorner = fov.UICorner
    }
end

local MiscTabBox = getgenv().Tabs.Misc:AddLeftTabbox()
local TabCharacter = MiscTabBox:AddTab('Character')
local TabMisc = MiscTabBox:AddTab('Misc')

local AutoGb = getgenv().Tabs.Misc:AddRightGroupbox('Auto')

local function applyAutoBox()
    local AutoBox = AutoGb
    local MoveBox = TabCharacter
    
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer
local function PerformReset()
    StarterGui:SetCore("ResetButtonCallback", true)
    local character = LocalPlayer.Character
    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        
        if getgenv().replicatesignal then
            getgenv().replicatesignal(LocalPlayer.Kill)
        elseif humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Dead)
            humanoid.Health = 0 
        end
    end
end

local ForceResetToggle = AutoBox:AddToggle('ForceReset', {
    Text = 'Force Reset',
    Default = false,
    Tooltip = 'Enable this to allow the Keybind to work',
    SyncToggleState = false,
    Callback = function(Value)
        if Value then
            PerformReset()
        end
    end
})

ForceResetToggle:AddKeyPicker('ForceResetKey', {
    Default = 'P',
    Mode = 'Toggle',
    Text = 'Force Reset',
    NoUI = false,
    Callback = function()
        if Toggles.ForceReset.Value then
            PerformReset()
        end
    end
})
PerformReset()
    
getgenv().ForceHit = {} 

getgenv().ForceHit.StrafeMode = "Orbit"
getgenv().ForceHit.LookAtTarget = false
getgenv().ForceHit.SpectateTarget = false
local KillAura = Tabs.Main:AddRightGroupbox("Strafe")

KillAura:AddToggle("StompTarget", {Text="Stomp Target", Default=false, Callback=function(v) getgenv().stompTargetEnabled=v end})

local DesyncPart = Instance.new("Part")
DesyncPart.Name="DesyncVisual"
DesyncPart.Size=Vector3.new(2,2,1)
DesyncPart.Transparency=1
DesyncPart.CanCollide=false
DesyncPart.Anchored=true
DesyncPart.Parent=workspace

local strafeToggleEnabled = false
local strafeKeybindEnabled = false
local strafeCamera = workspace.CurrentCamera

local function resetStrafeCamera()
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildWhichIsA("Humanoid")
    if hum then strafeCamera.CameraSubject = hum end
end

local toggle = KillAura:AddToggle("StrafeToggle", {Text="Target Strafe", Default=false, Callback=function(v)
    strafeToggleEnabled = v
    getgenv().ForceHit.StrafeEnabled = v and strafeKeybindEnabled
    if not v then
        resetStrafeCamera()
        getgenv().ForceHit.LookAtTarget = true
    end
end})

toggle:AddKeyPicker("StrafeKeybind", {Default="N", Mode="Toggle", NoSync=true, Text="Target Strafe", Callback=function(s)
    strafeKeybindEnabled = s
    getgenv().ForceHit.StrafeEnabled = strafeToggleEnabled and s
    if not s then
        resetStrafeCamera()
        getgenv().ForceHit.LookAtTarget = true
    end
end})

KillAura:AddToggle("spoofstrafe", {Text="Spoof", Default=false, Callback=function(v)
    getgenv().ForceHit.strafespoof = v
    if not v then resetStrafeCamera() end
end})

KillAura:AddToggle("visualizestrafe", {Text="Visualize Strafe", Default=false, Callback=function(v)
    getgenv().ForceHit.VisualizeStrafe = v
    if not v and getgenv().ForceHit.Visualizer then
        getgenv().ForceHit.Visualizer:Destroy()
        getgenv().ForceHit.Visualizer = nil
        getgenv().ForceHit.VisualizerMotors = nil
    end
end})


KillAura:AddSlider("StrafeSpeedSlider", {Text="Strafe Speed", Min=1, Max=30, Default=5, Rounding=1, Callback=function(v) getgenv().ForceHit.StrafeSpeed=v end})
KillAura:AddSlider("StrafeDistanceSlider", {Text="Strafe Distance", Min=1, Max=20, Default=5, Rounding=1, Callback=function(v) getgenv().ForceHit.StrafeDistance=v end})
KillAura:AddSlider("StrafeHeightSlider", {Text="Strafe Height", Min=-15, Max=15, Default=0, Rounding=1, Callback=function(v) getgenv().ForceHit.StrafeHeight=v end})

KillAura:AddDropdown("StrafeModeDropdown", {Values={"Orbit","Random","Void Shoot"}, Default="Orbit", Text="Strafe Mode", Callback=function(v) getgenv().ForceHit.StrafeMode=v end})


local function destroyStrafeVisualizer()
    if getgenv().ForceHit.StrafeVisConnection then
        getgenv().ForceHit.StrafeVisConnection:Disconnect()
        getgenv().ForceHit.StrafeVisConnection = nil
    end
    if getgenv().ForceHit.StrafeVisParts then
        for _, data in pairs(getgenv().ForceHit.StrafeVisParts) do
            if data.part then data.part:Destroy() end
        end
        getgenv().ForceHit.StrafeVisParts = nil
    end
end

local function createStrafeVisualizer()
    destroyStrafeVisualizer()
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    local parts = {}
    getgenv().ForceHit.StrafeVisParts = parts
    for _, p in ipairs(char:GetChildren()) do
        if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then
            local vis = Instance.new("Part")
            vis.Name = p.Name.."_StrafeGhost"
            vis.Size = p.Size
            vis.Anchored = true
            vis.CanCollide = false
            vis.CastShadow = false
            vis.Material = Enum.Material.Neon
            vis.Color = Color3.fromRGB(255,255,255)
            vis.Transparency = 0
            vis.Parent = strafeCamera
            local offset = root.CFrame:Inverse() * p.CFrame
            parts[p.Name] = {part=vis, offset=offset, currentCF=vis.CFrame}
        end
    end
    local alpha = 0.18
    getgenv().ForceHit.CurrentStrafeCF = root.CFrame
    getgenv().ForceHit.StrafeVisConnection = RunService.RenderStepped:Connect(function()
        local baseCF = getgenv().ForceHit.CurrentStrafeCF
        if not baseCF then return end
        for _, data in pairs(parts) do
            local targetCF = baseCF * data.offset
            data.currentCF = data.currentCF:Lerp(targetCF, alpha)
            data.part.CFrame = data.currentCF
        end
    end)
end

local function stopStrafe()
    if getgenv().ForceHit.StrafeConnection then
        getgenv().ForceHit.StrafeConnection:Disconnect()
        getgenv().ForceHit.StrafeConnection = nil
    end
    destroyStrafeVisualizer()
    resetStrafeCamera()
    getgenv().ForceHit.LookAtTarget = true
end

local function startStrafe()
    if getgenv().ForceHit.StrafeConnection then
        getgenv().ForceHit.StrafeConnection:Disconnect()
        getgenv().ForceHit.StrafeConnection = nil
    end
    if getgenv().ForceHit.VisualizeStrafe then createStrafeVisualizer() end

    getgenv().ForceHit.LookAtTarget = false

    local strafeTime = 0
    local voidPhase = false
    local voidTimer = 0

    getgenv().ForceHit.StrafeConnection = RunService.Heartbeat:Connect(function(dt)
        strafeTime += dt

        if not getgenv().ForceHit.StrafeEnabled or not getgenv().ForceHitTarget then
            stopStrafe()
            return
        end

        local char = LocalPlayer.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local targetChar = getgenv().ForceHitTarget.Character
        local targetRoot = targetChar and targetChar:FindFirstChild("HumanoidRootPart")
        local targetHum = targetChar and targetChar:FindFirstChildWhichIsA("Humanoid")

        if not (root and targetRoot and targetHum and targetHum.Health > 0) then
            stopStrafe()
            return
        end

        local targetPos = targetRoot.Position
        local desired

        if getgenv().ForceHit.StrafeMode == "Orbit" then
            local angle = strafeTime * (getgenv().ForceHit.StrafeSpeed or 5)
            desired = CFrame.lookAt(
                targetPos + Vector3.new(
                    math.cos(angle) * (getgenv().ForceHit.StrafeDistance or 8),
                    getgenv().ForceHit.StrafeHeight or 0,
                    math.sin(angle) * (getgenv().ForceHit.StrafeDistance or 8)
                ),
                targetPos
            )

        elseif getgenv().ForceHit.StrafeMode == "Random" then
            local t = strafeTime * 40
            local offset = Vector3.new(
                math.noise(t,0,0) * 20,
                math.noise(0,t,0) * 15 + (getgenv().ForceHit.StrafeHeight or 0),
                math.noise(0,0,t) * 20
            )
            desired = CFrame.lookAt(targetPos + offset, targetPos)

        elseif getgenv().ForceHit.StrafeMode == "Void Shoot" then
            voidTimer += dt
            local isShooting = tick() - (getgenv().ForceHit.LastShotTime or 0) < 0.12

            if isShooting then
                voidPhase = false
                voidTimer = 0
                desired = CFrame.lookAt(
                    targetPos + Vector3.new(0, 200, 2),
                    targetPos
                )
            else
                local voidTime = getgenv().ForceHit.VoidTime or 0.4
                local groundTime = getgenv().ForceHit.GroundTime or 0.133

                if not voidPhase then
                    if voidTimer >= groundTime then
                        voidPhase = true
                        voidTimer = 0
                    end
                    desired = CFrame.lookAt(
                        targetPos + Vector3.new(0, 3, 2),
                        targetPos
                    )
                else
                    if voidTimer >= voidTime then
                        voidPhase = false
                        voidTimer = 0
                    end
                    desired = CFrame.new(
                        targetPos + Vector3.new(0, 10000, 0)
                    )
                end
            end
        end

        if not desired then return end

        if getgenv().ForceHit.VisualizeStrafe then
            getgenv().ForceHit.CurrentStrafeCF = desired
        end

        if getgenv().ForceHit.strafespoof then
            local real = root.CFrame
            DesyncPart.CFrame = real + Vector3.new(0, 5, 0)
            strafeCamera.CameraSubject = DesyncPart
            root.CFrame = desired
            RunService.RenderStepped:Wait()
            root.CFrame = real
            resetStrafeCamera()
        else
            root.CFrame = desired
            local targetSubject = targetChar:FindFirstChild("Head") or targetHum
            local selfSubject = char:FindFirstChildWhichIsA("Humanoid")
            strafeCamera.CameraSubject = getgenv().ForceHit.SpectateStrafe and targetSubject or selfSubject
        end
    end)
end

task.spawn(function()
    while task.wait(0.1) do
        if getgenv().ForceHit.StrafeEnabled and getgenv().ForceHitTarget then
            if not getgenv().ForceHit.StrafeConnection then
                startStrafe()
            end
        else
            if getgenv().ForceHit.StrafeConnection then
                stopStrafe()
            end
        end
    end
end)

task.spawn(function()
    while task.wait() do
        if not (getgenv().stompTargetEnabled and getgenv().ForceHitTarget and getgenv().ForceHitTarget ~= LocalPlayer) then continue end
        local targetChar = getgenv().ForceHitTarget.Character
        local body = targetChar and targetChar:FindFirstChild("BodyEffects")
        local ko = body and body:FindFirstChild("K.O") and body["K.O"].Value
        local sdeath = body and body:FindFirstChild("SDeath") and body["SDeath"].Value
        if ko and not sdeath then
            local torso = targetChar:FindFirstChild("UpperTorso")
            local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if torso and hrp then
                local real = hrp.CFrame

                local wasStrafing = getgenv().ForceHit.strafespoof
                local wasStrafeEnabled = getgenv().ForceHit.StrafeEnabled

                getgenv().ForceHit.strafespoof = false
                getgenv().ForceHit.StrafeEnabled = false
                stopStrafe()

                if wasStrafing then
                    DesyncPart.CFrame = real + Vector3.new(0,5,0)
                    strafeCamera.CameraSubject = DesyncPart
                end

                hrp.CFrame = CFrame.new(torso.Position + Vector3.new(0,3,0))
                ReplicatedStorage.MainEvent:FireServer("Stomp")
                RunService.RenderStepped:Wait()
                hrp.CFrame = real

                getgenv().ForceHit.strafespoof = wasStrafing
                getgenv().ForceHit.StrafeEnabled = wasStrafeEnabled
                resetStrafeCamera()
            end
        end
    end
end)
getgenv().RunService.Heartbeat:Connect(function()
    if not getgenv().ForceHit.LookAtTarget then return end
    local target = getgenv().ForceHitTarget
    if not target or not target.Character then return end
    local targetPart = target.Character:FindFirstChild(getgenv().ForceHit.HitPart)
        or target.Character:FindFirstChild("HumanoidRootPart")
    if not targetPart then return end
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if hrp then
        local lookDir = (targetPart.Position - hrp.Position)
        local flatDir = Vector3.new(lookDir.X, 0, lookDir.Z).Unit
        if flatDir.Magnitude > 0 then
            hrp.CFrame = CFrame.new(hrp.Position, hrp.Position + flatDir)
        end
    end
    local head = char:FindFirstChild("Head")
    local neck = (char:FindFirstChild("UpperTorso") and char.UpperTorso:FindFirstChild("Neck"))
        or (char:FindFirstChild("Torso") and char.Torso:FindFirstChild("Neck"))
    if head and neck then
        local dir = (targetPart.Position - head.Position).Unit
        neck.C0 = CFrame.new(neck.C0.Position)
            * CFrame.Angles(math.asin(math.clamp(dir.Y, -1, 1)) * -1, math.atan2(-dir.X, -dir.Z), 0)
    end
end)

local spectateConnection

local function startSpectate()
    if spectateConnection then spectateConnection:Disconnect() spectateConnection = nil end
    spectateConnection = getgenv().RunService.Heartbeat:Connect(function()
        if not getgenv().ForceHit.SpectateTarget then
            local char = LocalPlayer.Character
            local hum = char and char:FindFirstChildWhichIsA("Humanoid")
            if hum then strafeCamera.CameraSubject = hum end
            spectateConnection:Disconnect()
            spectateConnection = nil
            return
        end
        local target = getgenv().ForceHitTarget
        if not target or not target.Character then return end
        local targetHum = target.Character:FindFirstChildWhichIsA("Humanoid")
        if targetHum and strafeCamera.CameraSubject ~= targetHum then
            strafeCamera.CameraType = Enum.CameraType.Custom
            strafeCamera.CameraSubject = targetHum
        end
    end)
end

LocalPlayer.CharacterAdded:Connect(function()
    if getgenv().ForceHit.SpectateTarget then
        task.wait(0.5)
        startSpectate()
    end
end)
getgenv().autoGrabEnabled = false
getgenv().autoGrabCooldown = 1

KillAura:AddToggle("AutoGrabToggle", {Text="Auto Grab", Default=false, Callback=function(v)
    getgenv().autoGrabEnabled = v
end})

KillAura:AddSlider("AutoGrabCooldownSlider", {Text="Grab Cooldown", Min=0.1, Max=5, Default=1, Rounding=1, Callback=function(v)
    getgenv().autoGrabCooldown = v
end})

task.spawn(function()
    while task.wait(getgenv().autoGrabCooldown) do
        if not (getgenv().autoGrabEnabled and getgenv().ForceHitTarget and getgenv().ForceHitTarget ~= LocalPlayer) then continue end
        local targetChar = getgenv().ForceHitTarget.Character
        local body = targetChar and targetChar:FindFirstChild("BodyEffects")
        local ko = body and body:FindFirstChild("K.O") and body["K.O"].Value
        if not ko then continue end
        local targetHrp = targetChar:FindFirstChild("HumanoidRootPart")
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not targetHrp or not hrp then continue end

        local real = hrp.CFrame
        local wasStrafing = getgenv().ForceHit.strafespoof
        local wasStrafeEnabled = getgenv().ForceHit.StrafeEnabled

        getgenv().ForceHit.strafespoof = false
        getgenv().ForceHit.StrafeEnabled = false
        stopStrafe()

        if wasStrafing then
            DesyncPart.CFrame = real + Vector3.new(0,5,0)
            strafeCamera.CameraSubject = DesyncPart
        end

        hrp.CFrame = CFrame.new(targetHrp.Position + Vector3.new(0,3,0))
        ReplicatedStorage.MainEvent:FireServer("Grabbing")
        RunService.RenderStepped:Wait()
        hrp.CFrame = real

        getgenv().ForceHit.strafespoof = wasStrafing
        getgenv().ForceHit.StrafeEnabled = wasStrafeEnabled
        resetStrafeCamera()

        local grabbed = body:FindFirstChild("Grabbed")
        if grabbed then
            local timeout = tick()
            while tick() - timeout < 2 do
                if grabbed.Value == LocalPlayer.Name then
                    targetHrp.CFrame = real
                    break
                end
                task.wait()
            end
        end
    end
end)

    local TextChatService = game:GetService("TextChatService")
    local chatConfig = TextChatService.ChatWindowConfiguration
    local originalBG = chatConfig.BackgroundColor3
    local originalTransparency = chatConfig.BackgroundTransparency
    local originalTextColor = chatConfig.TextColor3
    local originalTextSize = chatConfig.TextSize
    local originalAlignment = chatConfig.VerticalAlignment

    AutoBox:AddToggle('ChatSpyEnabled', {
        Text = 'Chat Spy',
        Default = false,
        Callback = function(v)
            if v then
                chatConfig.Enabled = true
                chatConfig.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                chatConfig.BackgroundTransparency = 0.8
                chatConfig.TextColor3 = Color3.fromRGB(255, 255, 255)
                chatConfig.TextSize = 13
                chatConfig.VerticalAlignment = Enum.VerticalAlignment.Top
            else
                chatConfig.BackgroundColor3 = originalBG
                chatConfig.BackgroundTransparency = originalTransparency
                chatConfig.TextColor3 = originalTextColor
                chatConfig.TextSize = originalTextSize
                chatConfig.VerticalAlignment = originalAlignment
            end
        end
    })

    AutoBox:AddToggle('AntiVoidEnabled', {
        Text = 'Anti Void',
        Default = false,
        Callback = function(v)
            if v then
                workspace.FallenPartsDestroyHeight = -math.huge
            else
                workspace.FallenPartsDestroyHeight = -50
            end
        end
    })

    AutoBox:AddToggle('Flashback', {
        Text = 'Respawn where you died',
        Default = false,
        Callback = function(value)
            if getgenv().flashback and getgenv().flashback.settings then
                getgenv().flashback.settings.enabled = value
            end
        end,
    })

    AutoBox:AddToggle('StompToggle', {
        Text = 'Auto Stomp',
        Default = false,
        Callback = function(v)
            if v then
                getgenv().StompLoop = task.spawn(function()
                    while task.wait(0.1) do
                        if not Toggles.StompToggle.Value then break end
                        getgenv().MainEvent:FireServer("Stomp")
                    end
                end)
            else
                if getgenv().StompLoop then
                    task.cancel(getgenv().StompLoop)
                    getgenv().StompLoop = nil
                end
            end
        end
    })

    AutoBox:AddDivider()

    AutoBox:AddToggle('AutoBuyKeys', {
        Text = 'Auto Buy Keys',
        Default = false,
    })

    AutoBox:AddSlider('BuyKeysCooldown', {
        Text = 'Buy Keys Cooldown',
        Default = 1,
        Min = 0.1,
        Max = 5,
        Rounding = 1,
    })

    AutoBox:AddToggle('AutoOpenCapsules', {
        Text = 'Auto Open Capsules',
        Default = false,
    })

    AutoBox:AddSlider('OpenCapsulesCooldown', {
        Text = 'Open Capsules Cooldown',
        Default = 3,
        Min = 0.5,
        Max = 10,
        Rounding = 1,
    })

    AutoBox:AddDivider()

    AutoBox:AddToggle('AutoRejoinToggle', {
        Text = 'Auto Rejoin when kicked',
        Default = false,
        Callback = function(v)
            if v then
                getgenv().AutoRejoinConnection = getgenv().GuiService.ErrorMessageChanged:Connect(function()
                    getgenv().TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, getgenv().LocalPlayer)
                end)
            else
                if getgenv().AutoRejoinConnection then
                    getgenv().AutoRejoinConnection:Disconnect()
                    getgenv().AutoRejoinConnection = nil
                end
            end
        end
    })

    AutoBox:AddDivider()

    AutoBox:AddToggle('AntiStaffEnabled', {
        Text = 'Anti Staff',
        Default = getgenv().AntiStaffSettings.Enabled,
        Callback = function(value)
            getgenv().AntiStaffSettings.Enabled = value
        end,
    })

    AutoBox:AddDropdown('AntiStaffAction', {
        Text = 'Action',
        Default = getgenv().AntiStaffSettings.Action,
        Values = { 'Notify', 'Kick', 'Both' },
        Callback = function(value)
            getgenv().AntiStaffSettings.Action = value
        end,
    })

    MoveBox:AddToggle('FlightToggle', {
        Text = 'Flight', Default = false,
        Callback = function(v)
            getgenv().FlightEnabled = v
            if not v then getgenv().StopFly() end
        end
    }):AddKeyPicker('FlightKeybind', {
        Default = 'X', Mode = 'Toggle', Text = 'Flight',
        SyncToggleState = false,
        Callback = function(state)
            if not Toggles.FlightToggle.Value then return end
            if state then getgenv().StartFly() else getgenv().StopFly() end
        end
    })
    MoveBox:AddSlider('FlySpeed', {Text='Fly Speed', Default=50, Min=10, Max=500, Rounding=0, Callback=function(v) getgenv().Misc.FlySpeed=v end})

    MoveBox:AddDivider()

    MoveBox:AddToggle('JumpPowerToggle', {
        Text = 'JumpPower', Default = false,
        Callback = function(state) getgenv().jumpPowerEnabled = false end,
    }):AddKeyPicker('JumpPowerKeybind', {
        Default = 'None', Text = 'JumpPower', Mode = 'Toggle',
        SyncToggleState = false,
        Callback = function(state)
            if not Toggles.JumpPowerToggle.Value then return end
            getgenv().jumpPowerEnabled = state
        end,
    })
    MoveBox:AddSlider('JumpPowerSlider', {
        Text = 'JumpPower Value', Default = 50, Min = 50, Max = 500, Rounding = 0,
        Callback = function(v) getgenv().jumpPower = v end,
    })

    MoveBox:AddDivider()

    MoveBox:AddToggle('CFrameSpeedToggle', {
        Text = 'CFrame Speed', Default = false,
        Callback = function(state)
            getgenv().cframeSpeedEnabled = false
        end,
    }):AddKeyPicker('CFrameSpeedKeybind', {
        Default = 'T', Text = 'CFrame Speed', Mode = 'Toggle',
        SyncToggleState = false,
        Callback = function(state)
            if not Toggles.CFrameSpeedToggle.Value then return end
            getgenv().cframeSpeedEnabled = state
        end,
    })
    MoveBox:AddSlider('CFrameSpeedSlider', {
        Text = 'CFrame Speed Value', Default = 10, Min = 0, Max = 200, Rounding = 1,
        Callback = function(v) getgenv().cframeSpeed = v end,
    })

    MoveBox:AddDivider()

    MoveBox:AddToggle('NoClipToggle', {
        Text = 'NoClip', Default = false,
        Callback = function(v) getgenv().NoClipEnabled = false end
    }):AddKeyPicker('NoClipKey', {
        Default = 'None', Mode = 'Toggle', Text = 'NoClip Key', 
        SyncToggleState = false,
        Callback = function(state)
            if not Toggles.NoClipToggle.Value then return end
            getgenv().NoClipEnabled = state
        end
    })

    MoveBox:AddToggle('SpinbotToggle', {
        Text = 'Spinbot', Default = false,
        Callback = function(v) getgenv().Misc.SpinEnabled = v if v then getgenv().StartSpin() end end
    })
    MoveBox:AddSlider('SpinSpeed', {Text='Spin Speed', Default=20, Min=1, Max=100, Rounding=1, Callback=function(v) getgenv().Misc.SpinSpeed=v end})

    MoveBox:AddSlider('GravitySlider', {
        Text = 'Gravity', Default = 196.2, Min = 0, Max = 500, Rounding = 1,
        Callback = function(v)
            getgenv().customGravity = v
        end
    })
end

applyAutoBox()

local MiscLeft = TabMisc

MiscLeft:AddToggle('PingSpooferEnabled', {
    Text = 'Ping Spoofer',
    Default = false,
    Callback = function(v)
        getgenv().PingSpoofing = v
    end
})

MiscLeft:AddSlider('PingSpoofInterval', {
    Text = 'Ping Spoofer Interval',
    Default = 3,
    Min = 1,
    Max = 10,
    Rounding = 1,
    Callback = function(v)
        getgenv().PingInterval = v
    end
})

task.spawn(function()
    local lastPingFire = 0
    while task.wait(0.5) do
        if Toggles.PingSpooferEnabled and Toggles.PingSpooferEnabled.Value then
            local now = tick()
            local isShooting = (getgenv().LastShotTime and (now - getgenv().LastShotTime) < 1) or false
            local baseDelay = Options.PingSpoofInterval and Options.PingSpoofInterval.Value or 3.0
            local jitter = math.random() * 2
            
            if not isShooting and (now - lastPingFire) >= (baseDelay + jitter) then
                local currentPing = 0
                pcall(function()
                    currentPing = getgenv().Stats.Network.ServerStatsItem['Data Ping']:GetValue()
                end)

                if currentPing < 400 then
                    getgenv().MainEvent:FireServer("GetPing")
                    lastPingFire = now
                end
            end
        end
    end
end)

getgenv().MainGb:AddToggle('ForceHitEnabled', { 
    Text = 'Force Hit', 
    Default = false 
}):AddKeyPicker('ForceHitKey', { 
    Default = 'Q', 
    Mode = 'Toggle', 
    Text = 'Lock Target', 
    SyncToggleState = false,
    NoUI = false 
})

getgenv().MainGb:AddToggle('MultiTarget', { Text = 'Multi Target (2 Players)', Default = false })
getgenv().MainGb:AddToggle('AutoFire', { Text = 'Auto Fire', Default = false })
getgenv().MainGb:AddDropdown('HitPart', { Text = 'Hit Part', Default = 1, Values = { 'Head', 'UpperTorso', 'HumanoidRootPart', 'LowerTorso' } })

getgenv().MainGb:AddDivider()

getgenv().MainGb:AddToggle('ShowTracer', { 
    Text = 'Target Line', 
    Default = false 
}):AddColorPicker('TracerColor', { 
    Default = Color3.fromRGB(160, 132, 220), 
    Title = 'Line Color' 
})
getgenv().MainGb:AddDropdown('TracerOrigin', { Text = 'Line Origin', Default = 1, Values = { 'Mouse', 'Center', 'Bottom' } })

local RightTabBox = getgenv().Tabs.Main:AddRightTabbox()
local RightTabChecks = RightTabBox:AddTab('Checks')
local RightTabAuto = RightTabBox:AddTab('Auto')

RightTabAuto:AddToggle('AutoHealEnabled', {
    Text = 'Auto Heal (Stomp K.O.)',
    Default = false,
}):AddKeyPicker('AutoHealKey', {
    Default = 'None',
    Mode = 'Toggle',
    Text = 'Auto Heal Key',
    SyncToggleState = false,
    NoUI = false,
})

RightTabAuto:AddSlider('AutoHealThreshold', {
    Text = 'Heal Under %',
    Default = 50,
    Min = 10,
    Max = 90,
    Rounding = 0,
    Suffix = '%',
})

RightTabAuto:AddToggle('AutoVoidOnHit', {
    Text = 'Auto Void (On Hit)',
    Default = false,
})

RightTabAuto:AddSlider('AutoVoidOnHitDuration', {
    Text = 'Void Duration',
    Default = 2,
    Min = 0.2,
    Max = 6,
    Rounding = 1,
    Suffix = 's',
})

local KnifeGb = getgenv().Tabs.Main:AddRightGroupbox('Knife Connection')

KnifeGb:AddToggle('KnifeEnabled', {
    Text = 'Knife Connection',
    Default = false,
}):AddKeyPicker('KnifeKey', {
    Default = 'None',
    SyncToggleState = false,
    Mode = 'Toggle',
    Text = 'Knife Connection Key',
    NoUI = false,
})

KnifeGb:AddSearchDropdown('KnifePlayerTarget', {
    Text = 'Knife Players',
    Values = { 'Loading...' },
    Default = 1,
})

KnifeGb:AddDropdown('KnifeChaseMode', {
    Values = { 'Off', 'Back' },
    Default = 2,
    Text = 'Knife Mode',
})

KnifeGb:AddSlider('KnifeChaseDistance', {
    Text = 'Knife Distance',
    Default = 3,
    Min = 1,
    Max = 10,
    Rounding = 0,
    Suffix = ' studs',
})

RightTabChecks:AddToggle('WallCheck', { Text = 'Wall Check', Default = true })
RightTabChecks:AddToggle('DistanceCheck', { Text = 'Distance Check', Default = true })
RightTabChecks:AddSlider('MaxDistance', { Text = 'Max Distance', Default = 200, Min = 10, Max = 1000, Rounding = 0 })
RightTabChecks:AddToggle('ForceFieldCheck', { Text = 'ForceField Check', Default = true })
RightTabChecks:AddToggle('KOCheck', { Text = 'KO Check', Default = true })

getgenv().PrefireGb = getgenv().Tabs.Main:AddRightGroupbox('Prefire System')
getgenv().PrefireGb:AddToggle('EnablePrefire', { Text = 'Prefire', Default = false })
getgenv().PrefireGb:AddSlider('FFDuration', { Text = 'FF Time', Default = 2.2, Min = 1.0, Max = 2.5, Rounding = 1 })
getgenv().PrefireGb:AddSlider('PrefireTime', { Text = 'Prefire Offset', Default = 0.3, Min = 0.0, Max = 1.0, Rounding = 2 })

getgenv().MenuBox = getgenv().Tabs.Settings:AddLeftGroupbox('Menu')
getgenv().MenuBox:AddButton('Unload', function() getgenv().Library:Unload() end)
getgenv().MenuBox:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', {Default='End', NoUI=true, Text='Menu keybind'})

getgenv().MenuBox:AddToggle('ShowWatermark', {
    Text = 'Show Watermark',
    Default = true,
    Callback = function(v)
        getgenv().Library:SetWatermarkVisibility(v)
    end
})

getgenv().MenuBox:AddToggle('ShowKeybinds', {
    Text = 'Show Keybinds',
    Default = false,
    Callback = function(v)
        getgenv().Library.KeybindFrame.Visible = v
    end
})

getgenv().ServerBox = getgenv().Tabs.Settings:AddLeftGroupbox('Server')
getgenv().ServerBox:AddButton('Server Hop', function() getgenv().TeleportService:Teleport(game.PlaceId, getgenv().LocalPlayer) end)
getgenv().ServerBox:AddButton('Rejoin Server', function() getgenv().TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, getgenv().LocalPlayer) end)
getgenv().ServerBox:AddButton('Force Reset', function()
    local character = getgenv().LocalPlayer.Character
    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Dead)
        end
    end
end)

Options.ForceHitKey:OnClick(function()
    if not Toggles.ForceHitEnabled.Value then return end
    
    if Toggles.MultiTarget.Value then
        if getgenv().ForceHitTarget and getgenv().ForceHitTarget2 then
            getgenv().ForceHitTarget = nil
            getgenv().ForceHitTarget2 = nil
            getgenv().SetupDamageDetection(nil)
            getgenv().TracerLine.Visible = false; getgenv().TracerOutline.Visible = false
            getgenv().TracerLine2.Visible = false; getgenv().TracerOutline2.Visible = false
            if getgenv().Library.Notify then getgenv().Library:Notify("Targets Unlocked", 1.5) end
        elseif getgenv().ForceHitTarget then
            local nextTarget = getgenv().GetClosestToMouse()
            if nextTarget and nextTarget ~= getgenv().ForceHitTarget then
                getgenv().ForceHitTarget2 = nextTarget
                getgenv().SetupDamageDetection(nextTarget)
                if getgenv().Library.Notify then getgenv().Library:Notify("Target 2 Locked: " .. tostring(nextTarget.Name), 1.5) end
            else
                getgenv().ForceHitTarget = nil
                getgenv().SetupDamageDetection(nil)
                getgenv().TracerLine.Visible = false; getgenv().TracerOutline.Visible = false
                if getgenv().Library.Notify then getgenv().Library:Notify("Target Unlocked", 1.5) end
            end
        else
            getgenv().ForceHitTarget = getgenv().GetClosestToMouse()
            if getgenv().ForceHitTarget then
                getgenv().SetupDamageDetection(getgenv().ForceHitTarget)
                if getgenv().Library.Notify then getgenv().Library:Notify("Target 1 Locked: " .. tostring(getgenv().ForceHitTarget.Name), 1.5) end
            end
        end
    else
        if getgenv().ForceHitTarget then
            getgenv().ForceHitTarget = nil
            getgenv().ForceHitTarget2 = nil
            getgenv().SetupDamageDetection(nil)
            getgenv().TracerLine.Visible = false; getgenv().TracerOutline.Visible = false
            getgenv().TracerLine2.Visible = false; getgenv().TracerOutline2.Visible = false
            if getgenv().Library.Notify then getgenv().Library:Notify("Target Unlocked", 1.5) end
        else
            getgenv().ForceHitTarget = getgenv().GetClosestToMouse()
            if getgenv().ForceHitTarget then
                getgenv().SetupDamageDetection(getgenv().ForceHitTarget)
                if getgenv().Library.Notify then getgenv().Library:Notify("Target Locked: " .. tostring(getgenv().ForceHitTarget.Name), 1.5) end
            end
        end
    end
end)

getgenv().LocalPlayer.CharacterAdded:Connect(function()
    if Toggles.SpectateTarget and Toggles.SpectateTarget.Value then task.wait(0.5); getgenv().startSpectate() end
end)

getgenv().RunService.RenderStepped:Connect(function()
    if Toggles.ForceHitEnabled.Value then
        local targets = {getgenv().ForceHitTarget, getgenv().ForceHitTarget2}
        
        for i, target in ipairs(targets) do
            local line = i == 1 and getgenv().TracerLine or getgenv().TracerLine2
            local outline = i == 1 and getgenv().TracerOutline or getgenv().TracerOutline2
            
            if target then
                local isTargetFullyDead = getgenv().isFullyDead(target)
                local isTargetKO = getgenv().isKO(target)
                
                local canShoot = not (Toggles.KOCheck.Value and (isTargetFullyDead or (isTargetKO and not Toggles.StompTarget.Value)))
                
                if canShoot then
                    if Toggles.AutoFire.Value or getgenv().UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then 
                        getgenv().Shoot(target) 
                    end
                    
                    if Toggles.ShowTracer.Value then
                        local targetPart = target.Character and target.Character:FindFirstChild(Options.HitPart.Value)
                        if targetPart then
                            local screenPos, onScreen = getgenv().Camera:WorldToViewportPoint(targetPart.Position)
                            if onScreen then
                                local viewport = getgenv().Camera.ViewportSize
                                local startPos
                                if Options.TracerOrigin.Value == 'Mouse' then startPos = getgenv().UserInputService:GetMouseLocation()
                                elseif Options.TracerOrigin.Value == 'Center' then startPos = Vector2.new(viewport.X / 2, viewport.Y / 2)
                                elseif Options.TracerOrigin.Value == 'Bottom' then startPos = Vector2.new(viewport.X / 2, viewport.Y) end

                                local endPos = Vector2.new(screenPos.X, screenPos.Y)
                                outline.From = startPos; outline.To = endPos; outline.Visible = true
                                line.From = startPos; line.To = endPos; line.Color = Options.TracerColor.Value; line.Visible = true
                            else
                                line.Visible = false; outline.Visible = false
                            end
                        else line.Visible = false; outline.Visible = false end
                    else line.Visible = false; outline.Visible = false end
                else
                    line.Visible = false; outline.Visible = false
                end
            else
                line.Visible = false; outline.Visible = false
            end
        end
    else 
        getgenv().TracerLine.Visible = false; getgenv().TracerOutline.Visible = false
        getgenv().TracerLine2.Visible = false; getgenv().TracerOutline2.Visible = false
    end
end)

task.spawn(function()
    while task.wait() do
        if not (Toggles.StompTarget.Value and getgenv().ForceHitTarget and getgenv().ForceHitTarget ~= getgenv().LocalPlayer) then continue end
        local targetChar = getgenv().ForceHitTarget.Character
        if not targetChar then continue end
        
        local body = targetChar:FindFirstChild("BodyEffects")
        local ko = body and body:FindFirstChild("K.O") and body["K.O"].Value
        local sdeath = body and body:FindFirstChild("SDeath") and body["SDeath"].Value
        
        if ko and not sdeath then
            getgenv().isCurrentlyStomping = true
            
            local torso = targetChar:FindFirstChild("UpperTorso") or targetChar:FindFirstChild("Torso")
            local hrp = getgenv().LocalPlayer.Character and getgenv().LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if torso and hrp then
                local real = hrp.CFrame
                local wasStrafing = Toggles.SpoofStrafe.Value
                
                if getgenv().StrafeConnection then getgenv().stopStrafe() end

                if wasStrafing then
                    getgenv().DesyncPart.CFrame = real + Vector3.new(0, 5, 0)
                    if not (Toggles.SpectateTarget and Toggles.SpectateTarget.Value) then getgenv().Camera.CameraSubject = getgenv().DesyncPart end
                end

                while getgenv().ForceHitTarget and getgenv().ForceHitTarget.Character == targetChar and targetChar.Parent do
                    local curBody = targetChar:FindFirstChild("BodyEffects")
                    if not curBody then break end
                    local curKO = curBody:FindFirstChild("K.O") and curBody["K.O"].Value
                    local curSDeath = curBody:FindFirstChild("SDeath") and curBody["SDeath"].Value
                    
                    if not curKO or curSDeath then break end
                    
                    local curTorso = targetChar:FindFirstChild("UpperTorso") or targetChar:FindFirstChild("Torso")
                    if curTorso then hrp.CFrame = CFrame.new(curTorso.Position + Vector3.new(0, 3, 0)) end
                    
                    getgenv().MainEvent:FireServer("Stomp")
                    task.wait(0.1)
                end

                hrp.CFrame = real
                if not (Toggles.SpectateTarget and Toggles.SpectateTarget.Value) then getgenv().resetStrafeCamera() end
            end
            getgenv().isCurrentlyStomping = false
        end
    end
end)

getgenv().RunService.Heartbeat:Connect(function()
    if getgenv().customGravity ~= nil then workspace.Gravity = getgenv().customGravity end
    
    local char = getgenv().LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hum or not hrp then return end

    if getgenv().jumpPowerEnabled then 
        hum.UseJumpPower = true
        hum.JumpPower = getgenv().jumpPower or 50 
    end
    
    if getgenv().cframeSpeedEnabled then
        local moveDir = hum.MoveDirection
        if moveDir.Magnitude > 0 then
            local speed = getgenv().cframeSpeed or 0
            hrp.CFrame = hrp.CFrame + (moveDir * (speed / 10))
        end
    end

    if getgenv().NoClipEnabled then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    end

    if Toggles.LookAtTarget and Toggles.LookAtTarget.Value and not getgenv().isCurrentlyStomping then
        if getgenv().ForceHitTarget and getgenv().ForceHitTarget.Character then
            local targetPart = getgenv().ForceHitTarget.Character:FindFirstChild(Options.HitPart.Value) or getgenv().ForceHitTarget.Character:FindFirstChild("HumanoidRootPart")
            if targetPart then
                local lookDir = (targetPart.Position - hrp.Position)
                local flatDir = Vector3.new(lookDir.X, 0, lookDir.Z).Unit
                if flatDir.Magnitude > 0 and flatDir == flatDir then
                    hrp.CFrame = CFrame.new(hrp.Position, hrp.Position + flatDir)
                end
                
                local head = char:FindFirstChild("Head")
                local neck = (char:FindFirstChild("UpperTorso") and char.UpperTorso:FindFirstChild("Neck")) or (char:FindFirstChild("Torso") and char.Torso:FindFirstChild("Neck"))
                if head and neck then
                    local dir = (targetPart.Position - head.Position).Unit
                    if dir == dir then
                        neck.C0 = CFrame.new(neck.C0.Position) * CFrame.Angles(math.asin(math.clamp(dir.Y, -1, 1)) * -1, math.atan2(-dir.X, -dir.Z), 0)
                    end
                end
            end
        end
    end
end)

getgenv().Misc = getgenv().Misc or {
    AutoReload = true,
    AutoReloadCooldown = 1,
    SpinEnabled = false,
    SpinSpeed = 20,
    SpinConnection = nil,
    FlightEnabled = false,
    Flying = false,
    FlySpeed = 50,
}
getgenv().StartSpin = function()
    if getgenv().Misc.SpinConnection then
        getgenv().Misc.SpinConnection:Disconnect()
        getgenv().Misc.SpinConnection = nil
    end
    getgenv().Misc.SpinConnection = getgenv().RunService.RenderStepped:Connect(function()
        if not getgenv().Misc.SpinEnabled then
            getgenv().Misc.SpinConnection:Disconnect()
            getgenv().Misc.SpinConnection = nil
            return
        end
        local char = getgenv().LocalPlayer.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return end
        root.CFrame = root.CFrame * CFrame.Angles(0, math.rad(getgenv().Misc.SpinSpeed), 0)
    end)
end

getgenv().MorphSettings = getgenv().MorphSettings or {
    CopyAppearance = true,
    HasHeadless = false,
    HasKorblox = false,
    HasChams = false,
    ChamsColor = Color3.new(1, 1, 1),
    SelectedUserName = "None",
    SelectedUserId = nil,
    DanceEnabled = false,
    CurrentDanceName = "None",
    CurrentDanceId = "",
    LagAnimations = false,
    LagIntensity = 1,
}

local settings = getgenv().MorphSettings

local users = {
    {UserId = 4912090997, UserName = "amir"},
    {UserId = 444115704, UserName = "DingleDorf"},
    {UserId = 7535880104, UserName = "fed"},
}

local danceAnimations = {
    ["None"] = "",
    ["headless"] = "rbxassetid://4",
    ["Floss"] = "rbxassetid://10714340543",
    ["Yungblud Happier Jump"] = "rbxassetid://15609995579",
    ["Monkey"] = "rbxassetid://3333499508",
    ["Fancy Feet"] = "rbxassetid://3333432454",
    ["Sleep"] = "rbxassetid://4686925579",
    ["Cower"] = "rbxassetid://4940563117",
    ["Bored"] = "rbxassetid://5230599789"
}

local danceNames = {}
for name in pairs(danceAnimations) do table.insert(danceNames, name) end

local skinColorParts = {
    Head = true,
    LeftFoot = true,
    LeftHand = true,
    LeftLowerArm = true,
    LeftUpperArm = true,
    RightFoot = true,
    RightHand = true,
    RightLowerArm = true,
    RightUpperArm = true,
}

local function validCharacter(c)
    local h = c and c:FindFirstChildOfClass("Humanoid")
    return h and h.Health > 0 and c:FindFirstChild("HumanoidRootPart")
end

local function ApplyHeadless(char)
    local head = char:FindFirstChild("Head")
    if head then
        head.Transparency = 1
        local face = head:FindFirstChild("face")
        if face then face.Transparency = 1 end
    end
end

local function RemoveHeadless(char)
    local head = char:FindFirstChild("Head")
    if head then
        head.Transparency = 0
        local face = head:FindFirstChild("face")
        if face then face.Transparency = 0 end
    end
end

local function ApplyKorblox(char)
    local rLowerLeg = char:FindFirstChild("RightLowerLeg")
    local rUpperLeg = char:FindFirstChild("RightUpperLeg")
    local rFoot = char:FindFirstChild("RightFoot")
    if rLowerLeg then rLowerLeg.MeshId = "902942093" rLowerLeg.Transparency = 1 end
    if rUpperLeg then rUpperLeg.MeshId = "http://www.roblox.com/asset/?id=902942096" rUpperLeg.TextureID = "http://roblox.com/asset/?id=902843398" end
    if rFoot then rFoot.MeshId = "902942089" rFoot.Transparency = 1 end
end

local function RemoveKorblox(char)
    local rLowerLeg = char:FindFirstChild("RightLowerLeg")
    local rUpperLeg = char:FindFirstChild("RightUpperLeg")
    local rFoot = char:FindFirstChild("RightFoot")
    if rLowerLeg then rLowerLeg.Transparency = 0 rLowerLeg.MeshId = "" end
    if rFoot then rFoot.Transparency = 0 rFoot.MeshId = "" end
    if rUpperLeg then rUpperLeg.TextureID = "" rUpperLeg.MeshId = "" end
    local success, appearance = pcall(function()
        return Players:GetCharacterAppearanceAsync(LocalPlayer.UserId)
    end)
    if not success or not appearance then return end
    for _, v in pairs(char:GetChildren()) do
        if v:IsA("Shirt") or v:IsA("Pants") or v:IsA("BodyColors") then v:Destroy() end
    end
    for _, v in pairs(appearance:GetChildren()) do
        if v:IsA("Shirt") or v:IsA("Pants") or v:IsA("BodyColors") then
            v.Parent = char
        end
    end
end

local savedBodyColors = {}

local function ApplyChams(char)
    local color = settings.ChamsColor or Color3.new(1, 1, 1)
    local partNames = {
        "Head", "LeftFoot", "LeftHand", "LeftLowerArm", "LeftLowerLeg",
        "LeftUpperArm", "LeftUpperLeg", "LowerTorso", "RightFoot",
        "RightHand", "RightLowerArm", "RightLowerLeg",
        "RightUpperArm", "RightUpperLeg", "UpperTorso"
    }
    savedBodyColors = {}
    for _, name in ipairs(partNames) do
        local part = char:FindFirstChild(name)
        if part and part:IsA("BasePart") then
            savedBodyColors[name] = part.Color
            part.Material = Enum.Material.ForceField
            part.Color = color
        end
    end
end

local function RemoveChams(char)
    local partNames = {
        "Head", "LeftFoot", "LeftHand", "LeftLowerArm", "LeftLowerLeg",
        "LeftUpperArm", "LeftUpperLeg", "LowerTorso", "RightFoot",
        "RightHand", "RightLowerArm", "RightLowerLeg",
        "RightUpperArm", "RightUpperLeg", "UpperTorso"
    }
    for _, name in ipairs(partNames) do
        local part = char:FindFirstChild(name)
        if part and part:IsA("BasePart") then
            part.Material = Enum.Material.Plastic
            if savedBodyColors[name] then
                part.Color = savedBodyColors[name]
            end
        end
    end
    savedBodyColors = {}
end

local function Morph(UserId, PlayerName)
    local player = Players:FindFirstChild(PlayerName)
    if not player or not player.Character then return end
    local success, appearance = pcall(function() return Players:GetCharacterAppearanceAsync(UserId) end)
    if not success then return end
    local char = player.Character
    for _, v in pairs(char:GetChildren()) do
        if v:IsA("Accessory") or v:IsA("Shirt") or v:IsA("Pants") or v:IsA("CharacterMesh") or v:IsA("BodyColors") then v:Destroy() end
    end
    if char:FindFirstChild("Head") and char.Head:FindFirstChild("face") then char.Head.face:Destroy() end
    for _, v in pairs(appearance:GetChildren()) do
        if v:IsA("Shirt") or v:IsA("Pants") or v:IsA("BodyColors") then v.Parent = char
        elseif v:IsA("Accessory") then char.Humanoid:AddAccessory(v)
        elseif v.Name == "R15" and char.Humanoid.RigType == Enum.HumanoidRigType.R15 then
            local mesh = v:FindFirstChildOfClass("CharacterMesh")
            if mesh then mesh.Parent = char end
        end
    end
    if appearance:FindFirstChild("face") then
        appearance.face.Parent = char.Head
    else
        local face = Instance.new("Decal")
        face.Face = Enum.NormalId.Front
        face.Name = "face"
        face.Texture = "rbxasset://textures/face.png"
        face.Parent = char.Head
    end
    local parent = char.Parent
    char.Parent = nil
    char.Parent = parent
    if settings.HasHeadless then ApplyHeadless(char) end
    if settings.HasKorblox then ApplyKorblox(char) end
    if settings.HasChams then ApplyChams(char) end
end

local danceTrack
local lagConnection

local function loadDance()
    local c = LocalPlayer.Character
    if not validCharacter(c) or settings.CurrentDanceId == "" then return end
    local h = c:FindFirstChildOfClass("Humanoid")
    local animator = h:FindFirstChildOfClass("Animator") or Instance.new("Animator", h)
    if danceTrack then danceTrack:Stop() danceTrack:Destroy() end
    local a = Instance.new("Animation")
    a.AnimationId = settings.CurrentDanceId
    danceTrack = animator:LoadAnimation(a)
    danceTrack.Priority = Enum.AnimationPriority.Action
end

local function playDance()
    if settings.DanceEnabled and danceTrack and not danceTrack.IsPlaying then
        pcall(function() danceTrack:Play() end)
    end
end

local function stopLag()
    if lagConnection then lagConnection:Disconnect() lagConnection = nil end
    if danceTrack then pcall(function() danceTrack:AdjustSpeed(1) end) end
end

local function startUltraLag()
    stopLag()
    local accumulator = 0
    local updateRate = math.clamp(20 - settings.LagIntensity * 6, 4, 20)
    lagConnection = RunService.RenderStepped:Connect(function(dt)
        if not settings.LagAnimations or not danceTrack or not danceTrack.IsPlaying then stopLag() return end
        accumulator += dt
        if accumulator < (1 / updateRate) then return end
        accumulator = 0
        if math.random() < (0.35 * settings.LagIntensity) then return end
        local r = math.random()
        if r < 0.35 * settings.LagIntensity then danceTrack:AdjustSpeed(0)
        elseif r < 0.5 * settings.LagIntensity then danceTrack:AdjustSpeed(-math.random(2,6))
        else danceTrack:AdjustSpeed(math.random(1,8)) end
    end)
end

LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait(1)
    if settings.SelectedUserId then
        Morph(settings.SelectedUserId, LocalPlayer.Name)
    elseif settings.SelectedUserName and settings.SelectedUserName ~= "None" then
        for _, user in pairs(users) do
            if user.UserName == settings.SelectedUserName then Morph(user.UserId, LocalPlayer.Name) break end
        end
    else
        if settings.HasHeadless then ApplyHeadless(char) end
        if settings.HasKorblox then ApplyKorblox(char) end
        if settings.HasChams then ApplyChams(char) end
    end
    if settings.DanceEnabled then
        task.spawn(function()
            task.wait(0.1)
            loadDance()
            playDance()
            if settings.LagAnimations and danceTrack then startUltraLag() end
        end)
    end
end)

if LocalPlayer.Character and validCharacter(LocalPlayer.Character) then
    task.spawn(function()
        task.wait(1)
        loadDance()
        playDance()
        if settings.LagAnimations and danceTrack then startUltraLag() end
    end)
end

local Avatar = TabCharacter
local DickESP = {}

local AttachedModels = {}

local function attachPartsWithHighlight(character, player)
    if not character then return end
    local pelvis = character:FindFirstChild("LowerTorso") or character:FindFirstChild("Torso")
    if not pelvis then return end

    local attachedModel = Instance.new("Model")
    attachedModel.Name = "AttachedParts_" .. player.Name
    attachedModel.Parent = workspace
    attachedModel.PrimaryPart = pelvis
    AttachedModels[player] = attachedModel

    local parts = {}

    local ball1 = Instance.new("Part")
    ball1.Shape = Enum.PartType.Ball
    ball1.Size = Vector3.new(0.5, 0.5, 0.5)
    ball1.Color = Color3.fromRGB(255, 255, 255)
    ball1.Material = Enum.Material.Neon
    ball1.CanCollide = false
    ball1.Anchored = false
    ball1.CFrame = pelvis.CFrame * CFrame.new(0.2, -0.6, -0.7)
    ball1.Parent = attachedModel
    table.insert(parts, ball1)

    local stick = Instance.new("Part")
    stick.Size = Vector3.new(0.3, 0.3, 6.8)
    stick.Color = Color3.fromRGB(255, 255, 255)
    stick.Material = Enum.Material.Neon
    stick.CanCollide = false
    stick.Anchored = false
    stick.CFrame = pelvis.CFrame * CFrame.new(0.07, -0.6, -3.9)
    stick.Parent = attachedModel
    table.insert(parts, stick)

    local ball2 = Instance.new("Part")
    ball2.Shape = Enum.PartType.Ball
    ball2.Size = Vector3.new(0.5, 4.5, 0.5)
    ball2.Color = Color3.fromRGB(255, 255, 255)
    ball2.Material = Enum.Material.Neon
    ball2.CanCollide = false
    ball2.Anchored = false
    ball2.CFrame = pelvis.CFrame * CFrame.new(-0.1, -0.6, -0.7)
    ball2.Parent = attachedModel
    table.insert(parts, ball2)

    for _, part in pairs(parts) do
        local weld = Instance.new("WeldConstraint")
        weld.Part0 = pelvis
        weld.Part1 = part
        weld.Parent = part
    end

    local highlight = Instance.new("Highlight")
    highlight.Parent = attachedModel
    highlight.Adornee = attachedModel
    highlight.FillColor = Color3.fromRGB(0, 0, 0)
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.FillTransparency = 1
    highlight.OutlineTransparency = 0
end

        local VisualTabBox = getgenv().Tabs.Visuals:AddRightTabbox()
        local RightTabVisual = VisualTabBox:AddTab('Visual')
        local RightTabSkins = VisualTabBox:AddTab('Skins')

        local HitEffectsGb = getgenv().Tabs.Visuals:AddLeftGroupbox('Hit Effects')
        local VisualAimGroup = getgenv().Tabs.Visuals:AddLeftGroupbox('FOV')

        VisualAimGroup:AddToggle('FOVEnabled', {
            Text = 'FOV Circle Enabled',
            Default = false,
            Callback = function(Value)
                getgenv().Config.Visual.FOV.Enabled = Value
            end
        }):AddColorPicker('FOVInnerColor', {
            Default = Color3.fromRGB(255, 255, 255),
            Title = 'Inner Color',
            Callback = function(Value)
                getgenv().Config.Visual.FOV.InnerColor = Value
            end
        }):AddColorPicker('FOVOuterColor', {
            Default = Color3.fromRGB(0, 0, 0),
            Title = 'Outer Color',
            Callback = function(Value)
                getgenv().Config.Visual.FOV.OuterColor = Value
            end
        })

        VisualAimGroup:AddDropdown('FOVShape', {
            Values = { 'Circle', 'Square', 'Hexagon', 'Triangle' },
            Default = 1,
            Text = 'FOV Shape',
            Callback = function(Value)
                getgenv().Config.Visual.FOV.Shape = Value
            end
        })

        VisualAimGroup:AddSlider('FOVSize', {
            Text = 'FOV Size',
            Default = 300,
            Min = 10,
            Max = 1000,
            Rounding = 0,
            Callback = function(Value)
                getgenv().Config.Visual.FOV.Size = Value
            end
        })

        VisualAimGroup:AddToggle('FOVFollowCursor', {
            Text = 'FOV Follow Cursor',
            Default = true,
            Callback = function(Value)
                getgenv().Config.Visual.FOV.FollowCursor = Value
            end
        })

        VisualAimGroup:AddToggle('FOVFilled', {
            Text = 'FOV Fill',
            Default = false,
            Callback = function(Value)
                getgenv().Config.Visual.FOV.Filled = Value
            end
        }):AddColorPicker('FOVFillColor', {
            Default = Color3.fromRGB(255, 255, 255),
            Title = 'Fill Color',
            Callback = function(Value)
                getgenv().Config.Visual.FOV.FillColor = Value
            end
        })

        VisualAimGroup:AddToggle('FOVPulseEnabled', {
            Text = 'FOV Pulse',
            Default = false,
            Callback = function(Value)
                getgenv().Config.Visual.FOV.PulseEnabled = Value
            end
        })

        VisualAimGroup:AddSlider('FOVPulseAmount', {
            Text = 'FOV Pulse Amount',
            Default = 20,
            Min = 1,
            Max = 100,
            Rounding = 0,
            Callback = function(Value)
                getgenv().Config.Visual.FOV.PulseAmount = Value
            end
        })

        VisualAimGroup:AddSlider('FOVPulseSpeed', {
            Text = 'FOV Pulse Speed',
            Default = 2,
            Min = 1,
            Max = 10,
            Rounding = 1,
            Callback = function(Value)
                getgenv().Config.Visual.FOV.PulseSpeed = Value
            end
        })

        HitEffectsGb:AddToggle('HitSoundEnabled', { Text = 'Hit Sound', Default = false })
        HitEffectsGb:AddDropdown('HitSoundChoice', { Text = 'Sound', Default = 1, Values = getgenv().HitSoundList })
        HitEffectsGb:AddInput('CustomHitSound', { Default = '1347140027', Numeric = false, Finished = false, Text = 'Custom ID', Placeholder = 'Sound ID here' })

        HitEffectsGb:AddDivider()

        HitEffectsGb:AddToggle('HitNotifEnabled', { Text = 'Hit Notification', Default = false })
        HitEffectsGb:AddDropdown('NotifPos', { Text = 'Notif Position', Default = 'Bottom Center', Values = { 'Top Left', 'Top Right', 'Center', 'Bottom Center' } })

        HitEffectsGb:AddDivider()

        HitEffectsGb:AddToggle('DamageIndicators', { 
            Text = 'Damage Indicators', 
            Default = false 
        }):AddColorPicker('IndicatorColor', { 
            Default = Color3.fromRGB(255, 255, 255), 
            Title = 'Text Color' 
        }):AddColorPicker('IndicatorStrokeColor', {
            Default = Color3.fromRGB(15, 15, 15),
            Title = 'Outline Color'
        })
        HitEffectsGb:AddSlider('IndicatorDuration', { Text = 'Indicator Duration', Default = 1.0, Min = 0.5, Max = 3.0, Rounding = 1 })

        HitEffectsGb:AddDivider()

        HitEffectsGb:AddToggle('BulletTracers', { 
            Text = 'Bullet Tracers', 
            Default = false 
        }):AddColorPicker('BulletTracerColorOption', { 
            Default = Color3.fromRGB(255, 255, 255), 
            Title = 'Tracer Color' 
        })

        HitEffectsGb:AddSlider('TracerDuration', { Text = 'Tracer Duration', Default = 1.0, Min = 0.1, Max = 5.0, Rounding = 1 })
        HitEffectsGb:AddSlider('DBSpread', { Text = 'Double Barrel Spread', Default = 3.0, Min = 0.0, Max = 15.0, Rounding = 1 })

        RightTabSkins:AddToggle('SkinChangerEnabled', {
            Text = 'Enable Skins',
            Default = false,
            Callback = function(val)
                if val then
                    getgenv().Ghosted_ApplySkins()
                    getgenv().Ghosted_ApplyBullets()
                end
            end,
        })
        RightTabSkins:AddDivider()
        RightTabSkins:AddDropdown('SkinDoubleBarrel', { Text = 'Double Barrel', Values = GUN_SKINS, Default = 1, Callback = function() applyVisualGuns() end })
        RightTabSkins:AddDropdown('SkinRevolver', { Text = 'Revolver', Values = GUN_SKINS, Default = 1, Callback = function() applyVisualGuns() end })
        RightTabSkins:AddDropdown('SkinShotgun', { Text = 'Shotgun', Values = GUN_SKINS, Default = 1, Callback = function() applyVisualGuns() end })
        RightTabSkins:AddDropdown('SkinSMG', { Text = 'SMG', Values = GUN_SKINS, Default = 1, Callback = function() applyVisualGuns() end })
        RightTabSkins:AddDropdown('SkinTacticalShotgun', { Text = 'Tactical Shotgun', Values = GUN_SKINS, Default = 1, Callback = function() applyVisualGuns() end })
        RightTabSkins:AddDropdown('SkinKnife', { Text = 'Knife', Values = KNIFE_SKINS, Default = 1, Callback = function() applyVisualGuns() end })
        RightTabSkins:AddDivider()
        RightTabSkins:AddDropdown('BulletDoubleBarrel', { Text = 'Beam: Double Barrel', Values = BULLET_SKINS, Default = 1, Callback = function() applyVisualGuns() end })
        RightTabSkins:AddDropdown('BulletRevolver', { Text = 'Beam: Revolver', Values = BULLET_SKINS, Default = 1, Callback = function() applyVisualGuns() end })
        RightTabSkins:AddDropdown('BulletShotgun', { Text = 'Beam: Shotgun', Values = BULLET_SKINS, Default = 1, Callback = function() applyVisualGuns() end })
        RightTabSkins:AddDropdown('BulletSMG', { Text = 'Beam: SMG', Values = BULLET_SKINS, Default = 1, Callback = function() applyVisualGuns() end })
        RightTabSkins:AddDivider()
        RightTabSkins:AddButton('Reset skins', function() getgenv().Ghosted_ResetSkins() end)

        RightTabVisual:AddToggle('Dickesp', {
            Text = 'Dick visuals  (Local Player)',
            Default = false,
            Callback = function(enabled)
                DickESP.SelfEnabled = enabled

                if not enabled then
                    if AttachedModels[LocalPlayer] then
                        AttachedModels[LocalPlayer]:Destroy()
                        AttachedModels[LocalPlayer] = nil
                    end
                    return
                end

                if LocalPlayer.Character then
                    attachPartsWithHighlight(LocalPlayer.Character, LocalPlayer)
                end
            end
        })

        RightTabVisual:AddToggle('DickespOthers', {
            Text = 'Dick visuals (Other Players)',
            Default = false,
            Callback = function(enabled)
                DickESP.OthersEnabled = enabled

                if not enabled then
                    for player, model in pairs(AttachedModels) do
                        if player ~= LocalPlayer and model then
                            model:Destroy()
                            AttachedModels[player] = nil
                        end
                    end
                    return
                end

                for _, player in pairs(game:GetService("Players"):GetPlayers()) do
                    if player ~= LocalPlayer and player.Character then
                        attachPartsWithHighlight(player.Character, player)
                    end
                end
            end
        })

        RightTabVisual:AddDivider()

        RightTabVisual:AddToggle('SelfAuraEnabled', {
            Text = 'Body Aura',
            Default = false,
            Callback = function(val)
                if val then
                    refreshSelfAura()
                else
                    clearSelfAura()
                end
            end,
        }):AddColorPicker('SelfAuraColor', {
            Default = Color3.fromRGB(133, 220, 255),
            Title = 'Aura Color',
            Callback = function()
                if Toggles.SelfAuraEnabled and Toggles.SelfAuraEnabled.Value then
                    refreshSelfAura()
                end
            end,
        })

        local selfAuraTypeValues = { 'None' }
        for _, n in ipairs(PARTICLE_AURA_NAMES) do
            table.insert(selfAuraTypeValues, n)
        end

        RightTabVisual:AddDropdown('SelfAuraType', {
            Values = selfAuraTypeValues,
            Default = 1,
            Text = 'Aura Type',
            Callback = function()
                if Toggles.SelfAuraEnabled and Toggles.SelfAuraEnabled.Value then
                    refreshSelfAura()
                end
            end,
        })
local danceTrack
local lagConnection

local function validCharacter(c)
    local h = c and c:FindFirstChildOfClass("Humanoid")
    return h and h.Health > 0 and c:FindFirstChild("HumanoidRootPart")
end

local function loadDance()
    local c = LocalPlayer.Character
    if not validCharacter(c) or settings.CurrentDanceId == "" then return end
    local h = c:FindFirstChildOfClass("Humanoid")
    local animator = h:FindFirstChildOfClass("Animator") or Instance.new("Animator", h)
    if danceTrack then danceTrack:Stop() danceTrack:Destroy() end
    local a = Instance.new("Animation")
    a.AnimationId = settings.CurrentDanceId
    danceTrack = animator:LoadAnimation(a)
    danceTrack.Priority = Enum.AnimationPriority.Action
end

local function playDance()
    if settings.DanceEnabled and danceTrack then
        pcall(function()
            if not danceTrack.IsPlaying then
                danceTrack:Play()
            end
        end)
    end
end

local function stopLag()
    if lagConnection then lagConnection:Disconnect() lagConnection = nil end
    if danceTrack then pcall(function() danceTrack:AdjustSpeed(1) end) end
end

local function startUltraLag()
    stopLag()
    local accumulator = 0
    local updateRate = math.clamp(20 - settings.LagIntensity * 6, 4, 20)
    lagConnection = RunService.RenderStepped:Connect(function(dt)
        if not settings.LagAnimations or not danceTrack or not danceTrack.IsPlaying then
            stopLag()
            return
        end
        accumulator += dt
        if accumulator < (1 / updateRate) then return end
        accumulator = 0
        if math.random() < (0.35 * settings.LagIntensity) then return end
        local r = math.random()
        if r < 0.35 * settings.LagIntensity then
            danceTrack:AdjustSpeed(0)
        elseif r < 0.5 * settings.LagIntensity then
            danceTrack:AdjustSpeed(-math.random(2,6))
        else
            danceTrack:AdjustSpeed(math.random(1,8))
        end
    end)
end

Avatar:AddToggle("EnableDance", {
    Text = "Enable Dance",
    Default = false,
    Callback = function(v)
        settings.DanceEnabled = v
        if v then
            loadDance()
            playDance()
            if settings.LagAnimations and danceTrack then startUltraLag() end
        else
            if danceTrack then danceTrack:Stop() end
            stopLag()
        end
    end
})

local danceNames = {}
for name in pairs(danceAnimations) do
    table.insert(danceNames, name)
end

Avatar:AddDropdown("SelectDance", {
    Text = "Select Dance",
    Values = danceNames,
    Default = "None",
    Callback = function(v)
        settings.CurrentDanceName = v
        settings.CurrentDanceId = danceAnimations[v]
        if settings.DanceEnabled then
            loadDance()
            playDance()
            if settings.LagAnimations and danceTrack then startUltraLag() end
        end
    end
})

Avatar:AddToggle("LagAnimations", {
    Text = "Lag Animations",
    Default = false,
    Callback = function(v)
        settings.LagAnimations = v
        if v and danceTrack then
            startUltraLag()
        else
            stopLag()
            if settings.DanceEnabled then playDance() end
        end
    end
})

Avatar:AddSlider("LagIntensity", {
    Text = "Lag Intensity",
    Default = 1,
    Min = 0,
    Max = 2,
    Rounding = 1,
    Callback = function(v)
        settings.LagIntensity = v
    end
})

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    if settings.DanceEnabled then
        task.spawn(function()
            task.wait(0.1)
            loadDance()
            playDance()
            if settings.LagAnimations and danceTrack then startUltraLag() end
        end)
    end
end)

if LocalPlayer.Character and validCharacter(LocalPlayer.Character) then
    task.spawn(function()
        task.wait(1)
        loadDance()
        playDance()
        if settings.LagAnimations and danceTrack then startUltraLag() end
    end)
end

local nameList = {"None"}
for _, user in ipairs(users) do table.insert(nameList, user.UserName) end

Avatar:AddDropdown('Char', {
    Default = 'None',
    Values = nameList,
    Callback = function(selected)
        settings.SelectedUserName = selected
        settings.SelectedUserId = nil
        if selected ~= "None" then
            for _, user in pairs(users) do
                if user.UserName == selected then Morph(user.UserId, LocalPlayer.Name) break end
            end
        else
            Morph(LocalPlayer.UserId, LocalPlayer.Name)
        end
    end
})

Avatar:AddToggle('HeadlessToggle', {
    Text = 'Toggle Headless',
    Default = settings.HasHeadless,
    Callback = function(state)
        settings.HasHeadless = state
        if LocalPlayer.Character then
            if state then ApplyHeadless(LocalPlayer.Character) else RemoveHeadless(LocalPlayer.Character) end
        end
    end
})

Avatar:AddToggle('KorbloxToggle', {
    Text = 'Toggle Korblox',
    Default = settings.HasKorblox,
    Callback = function(state)
        settings.HasKorblox = state
        if LocalPlayer.Character then
            if state then ApplyKorblox(LocalPlayer.Character) else RemoveKorblox(LocalPlayer.Character) end
        end
    end
})

Avatar:AddToggle('ChamsToggle', {
    Text = 'Toggle Chams',
    Default = settings.HasChams,
    Callback = function(state)
        settings.HasChams = state
        if LocalPlayer.Character then
            if state then ApplyChams(LocalPlayer.Character) else RemoveChams(LocalPlayer.Character) end
        end
    end
}):AddColorPicker('ChamsColor', {
    Default = Color3.new(1, 1, 1),
    Callback = function(color)
        settings.ChamsColor = color
        if settings.HasChams and LocalPlayer.Character then
            ApplyChams(LocalPlayer.Character)
        end
    end
})

Avatar:AddToggle('RemoveAccessories', {
    Text = 'Remove Accessories',
    Default = false,
    Callback = function()
        local char = LocalPlayer.Character
        if not char then return end
        for _, v in pairs(char:GetChildren()) do
            if v:IsA("Accessory") then v:Destroy() end
        end
    end
})

Avatar:AddInput('CustomAccessory', {
    Text = 'Add Accessory by ID',
    Default = '',
    Numeric = false,
    Finished = false,
    Callback = function(idText)
        local char = LocalPlayer.Character
        if not char then return end
        local id = idText:match("%d+")
        if not id then return end

        local function findAttachment(rootPart, name)
            for _, descendant in pairs(rootPart:GetDescendants()) do
                if descendant:IsA("Attachment") and descendant.Name == name then
                    return descendant
                end
            end
        end

        local function weldParts(part0, part1, c0, c1)
            local weld = Instance.new("Weld")
            weld.Part0 = part0
            weld.Part1 = part1
            weld.C0 = c0
            weld.C1 = c1 or CFrame.new()
            weld.Parent = part0
            return weld
        end

        local success, objects = pcall(function()
            return game:GetObjects("rbxassetid://" .. id)
        end)
        if not success or not objects or not objects[1] then
            print("Failed to load asset: " .. tostring(id))
            return
        end

        local accessory = objects[1]
        accessory.Parent = workspace

        local handle = accessory:FindFirstChild("Handle")
        if not handle then
            accessory:Destroy()
            print("No Handle found in asset: " .. tostring(id))
            return
        end

        local attachment = handle:FindFirstChildOfClass("Attachment")
        local parentPart = char:FindFirstChild("Head")
            or char:FindFirstChild("UpperTorso")
            or char:FindFirstChild("Torso")

        if attachment and parentPart then
            local parentAttachment = findAttachment(parentPart, attachment.Name)
            if parentAttachment then
                weldParts(parentPart, handle, parentAttachment.CFrame, attachment.CFrame)
            else
                weldParts(parentPart, handle, CFrame.new(0, 0.5, 0), CFrame.new())
            end
        elseif parentPart then
            weldParts(parentPart, handle, CFrame.new(0, 0.5, 0), CFrame.new())
        end

        accessory.Parent = char
    end
})

local StarterGui = game:GetService("StarterGui")
StarterGui:SetCore("ResetButtonCallback", true)

local TextChatService = game:GetService("TextChatService")
local chatConfig = TextChatService.ChatWindowConfiguration

local players = game:GetService("Players")
local runservice = game:GetService("RunService")
local lp = players.LocalPlayer

local g = getgenv()
g.flashback = g.flashback or {}

if g.flashback.conn then
    pcall(function() g.flashback.conn:Disconnect() end)
    g.flashback.conn = nil
end

g.flashback.settings = {
    enabled = false
}

local lastcf

local function gethrp()
    local char = lp.Character
    return char and char:FindFirstChild("HumanoidRootPart")
end

g.flashback.conn = runservice.Heartbeat:Connect(function()
    if not g.flashback.settings.enabled then return end
    local char = lp.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hum or not hrp then return end

    if hum.Health <= 10 and not lastcf then
        lastcf = hrp.CFrame
    elseif hum.Health > 10 and lastcf then
        hrp.CFrame = lastcf + Vector3.new(math.sin(tick()) * 0.001, 0, math.cos(tick()) * 0.001)
        lastcf = nil
    end
end)

local groupId = 339846382

local function isStaff(player)
    if not player or not player:IsInGroup(groupId) then return false end
    local role = player:GetRoleInGroup(groupId)
    return role and role ~= "" and role ~= "Guest"
end

local function sendNotification(message)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "Staff Alert",
            Text = message,
            Duration = 6,
            Icon = "rbxassetid://6031075938"
        })
    end)
end

local function handleStaffJoin(staffPlayer)
    if not getgenv().AntiStaffSettings.Enabled then return end
    local action = getgenv().AntiStaffSettings.Action
    if action == "Notify" or action == "Both" then
        sendNotification("Staff detected: " .. staffPlayer.DisplayName .. " (@" .. staffPlayer.Name .. ")")
    end
    if action == "Kick" or action == "Both" then
        task.wait(3)
        LocalPlayer:Kick("\nStaff member joined the game:\n" .. staffPlayer.DisplayName .. " (@" .. staffPlayer.Name .. ")\n\nYou were automatically disconnected for safety.")
    end
end

task.spawn(function()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and isStaff(player) then handleStaffJoin(player) end
    end
end)

Players.PlayerAdded:Connect(function(player)
    if player ~= LocalPlayer and isStaff(player) then handleStaffJoin(player) end
end)
getgenv().FlyCore = nil
getgenv().FlyBV = nil
getgenv().FlyBG = nil
getgenv().FlyConn = nil

getgenv().StartFly = function()
    if getgenv().Misc.Flying then return end
    local char = getgenv().LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    getgenv().Misc.Flying = true
    if workspace:FindFirstChild("FlyCore") then workspace.FlyCore:Destroy() end
    getgenv().FlyCore = Instance.new("Part")
    getgenv().FlyCore.Name = "FlyCore"; getgenv().FlyCore.Size = Vector3.new(0.05,0.05,0.05)
    getgenv().FlyCore.Transparency = 1; getgenv().FlyCore.CanCollide = false; getgenv().FlyCore.Parent = workspace
    local weld = Instance.new("WeldConstraint")
    weld.Part0 = getgenv().FlyCore; weld.Part1 = char.HumanoidRootPart; weld.Parent = getgenv().FlyCore
    getgenv().FlyBV = Instance.new("BodyVelocity")
    getgenv().FlyBV.MaxForce = Vector3.new(400000,400000,400000); getgenv().FlyBV.P = 9000
    getgenv().FlyBV.Velocity = Vector3.zero; getgenv().FlyBV.Parent = getgenv().FlyCore
    getgenv().FlyBG = Instance.new("BodyGyro")
    getgenv().FlyBG.MaxTorque = Vector3.new(400000,400000,400000); getgenv().FlyBG.P = 15000
    getgenv().FlyBG.D = 1000; getgenv().FlyBG.CFrame = getgenv().FlyCore.CFrame; getgenv().FlyBG.Parent = getgenv().FlyCore
    if getgenv().FlyConn then getgenv().FlyConn:Disconnect() end
    getgenv().FlyConn = getgenv().RunService.RenderStepped:Connect(function()
        if not getgenv().Misc.Flying or not getgenv().FlyBV or not getgenv().FlyBG then return end
        local cam = workspace.CurrentCamera
        local move = Vector3.zero
        if getgenv().UserInputService:IsKeyDown(Enum.KeyCode.W) then move += cam.CFrame.LookVector end
        if getgenv().UserInputService:IsKeyDown(Enum.KeyCode.S) then move -= cam.CFrame.LookVector end
        if getgenv().UserInputService:IsKeyDown(Enum.KeyCode.A) then move -= cam.CFrame.RightVector end
        if getgenv().UserInputService:IsKeyDown(Enum.KeyCode.D) then move += cam.CFrame.RightVector end
        if getgenv().UserInputService:IsKeyDown(Enum.KeyCode.Space) then move += Vector3.new(0,1,0) end
        if getgenv().UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then move -= Vector3.new(0,1,0) end
        if move.Magnitude > 0 then move = move.Unit end
        getgenv().FlyBV.Velocity = move * getgenv().Misc.FlySpeed
        getgenv().FlyBG.CFrame = cam.CFrame
    end)
end

getgenv().StopFly = function()
    if not getgenv().Misc.Flying then return end
    getgenv().Misc.Flying = false
    if getgenv().FlyConn then getgenv().FlyConn:Disconnect(); getgenv().FlyConn = nil end
    if getgenv().FlyBV then getgenv().FlyBV:Destroy(); getgenv().FlyBV = nil end
    if getgenv().FlyBG then getgenv().FlyBG:Destroy(); getgenv().FlyBG = nil end
    if getgenv().FlyCore and getgenv().FlyCore.Parent then getgenv().FlyCore:Destroy(); getgenv().FlyCore = nil end
end

getgenv().UpdateNotifPosition(Options.NotifPos.Value)




task.spawn(function()
    while task.wait(0.1) do
        local now = tick()
        
        local char = getgenv().LocalPlayer.Character
        local hum = char and char:FindFirstChildWhichIsA("Humanoid")
        
        if hum then
            if lastLocalHealthForAutoVoid == nil then
                lastLocalHealthForAutoVoid = hum.Health
            else
                local autoVoidEnabled = false
                if Toggles and Toggles.AutoVoidOnHit then
                    autoVoidEnabled = Toggles.AutoVoidOnHit.Value
                end
                
                if hum.Health < lastLocalHealthForAutoVoid and autoVoidEnabled then
                    local duration = 2
                    if Options and Options.AutoVoidOnHitDuration then
                        duration = Options.AutoVoidOnHitDuration.Value
                    end
                    
                    if now >= hitAutoVoidActiveUntil then
                        local d = getgenv().desync
                        hitAutoVoidPrevDesyncEnabled = d and d.enabled or false
                        hitAutoVoidPrevDesyncMode = d and d.mode or nil
                        hitAutoVoidOwnedDesync = not hitAutoVoidPrevDesyncEnabled
                        if d then d.mode = "void" end
                        pcall(function() setDesync(true) end)
                    end

                    hitAutoVoidActiveUntil = now + duration
                    
                    task.delay(duration, function()
                        if tick() >= hitAutoVoidActiveUntil then
                            if hitAutoVoidOwnedDesync then
                                pcall(function() setDesync(false) end)
                            end
                            local d = getgenv().desync
                            if d and hitAutoVoidPrevDesyncMode ~= nil then
                                d.mode = hitAutoVoidPrevDesyncMode
                            end
                            hitAutoVoidOwnedDesync = false
                        end
                    end)
                end
                lastLocalHealthForAutoVoid = hum.Health
            end
        end

        if Toggles.AutoBuyKeys and Toggles.AutoBuyKeys.Value then
            local cooldown = Options.BuyKeysCooldown and Options.BuyKeysCooldown.Value or 1
            if (now - lastBuyKeyTime) >= cooldown then
                pcall(function() getgenv().MainEvent:FireServer("BuyCapsuleKey") end)
                lastBuyKeyTime = now
            end
        end
        
        if Toggles.AutoOpenCapsules and Toggles.AutoOpenCapsules.Value then
            local cooldown = Options.OpenCapsulesCooldown and Options.OpenCapsulesCooldown.Value or 3
            if (now - lastOpenCapsuleTime) >= cooldown then
                local bp = getgenv().LocalPlayer:FindFirstChildOfClass("Backpack")
                local char = getgenv().LocalPlayer.Character
                
                local function checkItems(parent)
                    if not parent then return end
                    for _, item in ipairs(parent:GetChildren()) do
                        if item:IsA("Tool") and item.Name:find("Capsule") then
                            pcall(function() getgenv().MainEvent:FireServer("OpenCapsule", item.Name) end)
                            lastOpenCapsuleTime = now
                            return true
                        end
                    end
                end
                
                if not checkItems(bp) then
                    checkItems(char)
                end
            end
        end
    end
end)

local knifeGlueConnection = nil
local lastMeleeFire = 0
local lastKnifeDropdownRefresh = 0

task.spawn(function()
    while not (Options and Options.KnifePlayerTarget) do task.wait(0.1) end
    while task.wait(3) do
        local now = tick()
        if now - lastKnifeDropdownRefresh < 2.5 then continue end
        lastKnifeDropdownRefresh = now
        local pNames = {}
        for _, p in ipairs(getgenv().Players:GetPlayers()) do
            if p ~= getgenv().LocalPlayer then
                table.insert(pNames, p.DisplayName .. " (@" .. p.Name .. ")")
            end
        end
        table.sort(pNames)
        local opt = Options and Options.KnifePlayerTarget
        if opt then
            if type(opt.SetValues) == "function" then pcall(function() opt:SetValues(pNames) end) else pcall(function() opt.Values = pNames end) end
            if opt.Value == nil or opt.Value == "Loading..." then
                if #pNames > 0 then
                    pcall(function() opt:SetValue(pNames[1]) end)
                    pcall(function() opt.Value = pNames[1] end)
                end
            end
        end
    end
end)

local function setKnifeRepRoot(hrp, root)
    if not hrp then return end
    pcall(function()
        sethiddenproperty(hrp, "PhysicsRepRootPart", root)
    end)
end

local function knifeOwnPart(part)
    if not part or not part:IsA("BasePart") then return end
    pcall(function() part:SetNetworkOwner(getgenv().LocalPlayer) end)
end

if knifeGlueConnection then
    knifeGlueConnection:Disconnect()
    knifeGlueConnection = nil
end

local function parseKnifePlayerName(label)
    if type(label) ~= "string" then return nil end
    local at = label:match("%(@([^%)]+)%)")
    if at and #at > 0 then return at end
    return label
end

local function getKnifeTargets()
    if not Options or not Options.KnifePlayerTarget then return {} end
    local v = Options.KnifePlayerTarget.Value
    if type(v) ~= "string" then return {} end
    local name = parseKnifePlayerName(v)
    if not name then return {} end
    local p = getgenv().Players:FindFirstChild(name)
    if p and p ~= getgenv().LocalPlayer then
        return { p }
    end
    return {}
end

knifeGlueConnection = getgenv().RunService.RenderStepped:Connect(function()
    if not Toggles or not Toggles.KnifeEnabled or not Toggles.KnifeEnabled.Value then
        local c = getgenv().LocalPlayer.Character
        local hrp = c and c:FindFirstChild("HumanoidRootPart")
        if hrp then setKnifeRepRoot(hrp, nil) end
        return
    end

    local char = getgenv().LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if not char or not hrp or not hum or hum.Health <= 0 then
        if hrp then setKnifeRepRoot(hrp, nil) end
        return
    end

    local chaseMode = Options and Options.KnifeChaseMode and Options.KnifeChaseMode.Value or "Back"
    if chaseMode == "Off" then
        setKnifeRepRoot(hrp, nil)
        return
    end

    local bp = getgenv().LocalPlayer:FindFirstChildOfClass("Backpack")
    local knife = (char and (char:FindFirstChild("[Knife]") or char:FindFirstChild("Knife")))
        or (bp and (bp:FindFirstChild("[Knife]") or bp:FindFirstChild("Knife")))
    if not knife then
        setKnifeRepRoot(hrp, nil)
        return
    end

    local targets = getKnifeTargets()
    if #targets == 0 then
        setKnifeRepRoot(hrp, nil)
        return
    end
    targets = { targets[1] }

    local glueTarget = targets[1]
    local tChar = glueTarget.Character
    local tRoot = tChar and tChar:FindFirstChild("HumanoidRootPart")
    if not tRoot then
        setKnifeRepRoot(hrp, nil)
        return
    end

    local dist = Options and Options.KnifeChaseDistance and Options.KnifeChaseDistance.Value or 3
    knifeOwnPart(hrp)
    knifeOwnPart(tRoot)
    local glueCF = tRoot.CFrame * CFrame.new(0, 0, dist)
    pcall(function()
        sethiddenproperty(hrp, "PhysicsRepRootPart", tRoot)
        hrp.CFrame = glueCF
        hrp.AssemblyLinearVelocity = Vector3.zero
        hrp.AssemblyAngularVelocity = Vector3.zero
        hrp.Velocity = Vector3.zero
    end)

    local swingInt = 0.05
    if tick() - lastMeleeFire >= swingInt then
        local meleeChars = {}
        for _, t in ipairs(targets) do
            local ec = t.Character
            local tr = ec and ec:FindFirstChild("HumanoidRootPart")
            if tr and ec and not getgenv().isKO(t) then
                local rp = tr.Position
                if not (rp.Y > 2e9 or rp.Y < -500) then
                    table.insert(meleeChars, ec)
                end
            end
        end

        if #meleeChars > 0 then
            lastMeleeFire = tick()
            if knife.Parent ~= char then
                pcall(function() knife.Parent = char end)
            end
            pcall(function() knife:Activate() end)
            if getgenv().MainEvent then
                for _, meChar in ipairs(meleeChars) do
                    pcall(function() getgenv().MainEvent:FireServer("Melee", meChar) end)
                end
            end
        end
    end
end)


getgenv().RunService.RenderStepped:Connect(function()
    if not getgenv().Config or not getgenv().Config.Visual then return end

    local cfg = getgenv().Config.Visual
    local fov = cfg.FOV
    local mousePos = getgenv().UserInputService:GetMouseLocation()
    local centerPos = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize/2 or Vector2.new(0, 0)
    local targetPos = (fov and fov.FollowCursor == false) and centerPos or Vector2.new(mousePos.X, mousePos.Y)
    local tNow = tick()

    if fov and fov.Enabled then
        if not fov.InnerCircle or not fov.ScreenGui then createFOV() end

        local radius = fov.Size or 300
        if fov.PulseEnabled then
            radius = radius + (math.sin(tNow * (fov.PulseSpeed or 2)) * (fov.PulseAmount or 20))
        end
        radius = math.max(1, radius)
        local shape = fov.Shape or 'Circle'

        if fov.ScreenGui then
            fov.ScreenGui.Enabled = false
        end

        local isCircle = (shape == 'Circle')
        local isSquare = (shape == 'Square')
        local isHexagon = (shape == 'Hexagon')
        local isTriangle = (shape == 'Triangle')

        local drawVisible = true
        local fillVisible = fov.Filled == true

        if fov.InnerCircle then
            fov.InnerCircle.Visible = drawVisible and isCircle
            if fov.InnerCircle.Visible then
                fov.InnerCircle.Position = targetPos
                fov.InnerCircle.Radius = radius
                fov.InnerCircle.Color = fov.InnerColor or Color3.new(1,1,1)
                fov.InnerCircle.Transparency = 1
                fov.InnerCircle.Thickness = 1
                fov.InnerCircle.Filled = false
            end

            if fov.OuterCircle then
                fov.OuterCircle.Visible = drawVisible and isCircle
                if fov.OuterCircle.Visible then
                    fov.OuterCircle.Position = targetPos
                    fov.OuterCircle.Radius = radius + 1
                    fov.OuterCircle.Color = fov.OuterColor or Color3.new(0,0,0)
                    fov.OuterCircle.Transparency = 1
                    fov.OuterCircle.Thickness = 1
                    fov.OuterCircle.Filled = false
                end
            end
            if fov.FillCircle then
                fov.FillCircle.Visible = fillVisible and isCircle
                if fov.FillCircle.Visible then
                    fov.FillCircle.Position = targetPos
                    fov.FillCircle.Radius = radius
                    fov.FillCircle.Color = fov.FillColor or fov.InnerColor or Color3.new(1, 1, 1)
                    fov.FillCircle.Transparency = 0.1
                    fov.FillCircle.Thickness = 1
                    fov.FillCircle.Filled = true
                end
            end

            local points, outerPoints
            local function getPolygonPointsCached(sides, offset)
                local p = {}
                local angleStep = (math.pi * 2) / sides
                local baseRotation = (shape == 'Triangle' and -math.pi/2 or (shape == 'Square' and math.pi/4 or 0))
                local currentRotation = math.rad(fov.Rotation or 0)
                local totalRotation = baseRotation + currentRotation

                for i = 1, sides do
                    local angle = (i * angleStep) + totalRotation
                    p[i] = targetPos + Vector2.new(math.cos(angle) * (radius + offset), math.sin(angle) * (radius + offset))
                end
                return p
            end

            if fov.Lines then
                local visible = drawVisible and (not isCircle)
                local sides = (isSquare and 4 or (isHexagon and 6 or (isTriangle and 3 or 0)))
                
                if visible then
                    points = getPolygonPointsCached(sides, 0)
                    outerPoints = getPolygonPointsCached(sides, 1)
                end

                for i = 1, 12 do
                    local line = fov.Lines[i]
                    if not line then continue end
                    if i <= sides and visible then
                        local nextIdx = (i % sides) + 1
                        line.Visible = true
                        line.From = points[i]
                        line.To = points[nextIdx]
                        line.Color = fov.InnerColor or Color3.new(1,1,1)
                        line.Thickness = 1
                        line.Transparency = 1
                    elseif i > sides and i <= sides * 2 and visible then
                        local realIdx = i - sides
                        local nextIdx = (realIdx % sides) + 1
                        line.Visible = true
                        line.From = outerPoints[realIdx]
                        line.To = outerPoints[nextIdx]
                        line.Color = fov.OuterColor or Color3.new(0,0,0)
                        line.Thickness = 1
                        line.Transparency = 1
                    else
                        line.Visible = false
                    end
                end
            end

            if fov.Triangles then
                local visible = fillVisible and (not isCircle)
                local sides = (isSquare and 4 or (isHexagon and 6 or (isTriangle and 3 or 0)))
                
                if visible and not points then
                    points = getPolygonPointsCached(sides, 0)
                end

                for i = 1, 6 do
                    local tri = fov.Triangles[i]
                    if not tri then continue end
                    if i <= sides and visible then
                        local nextIdx = (i % sides) + 1
                        tri.Visible = true
                        tri.PointA = targetPos
                        tri.PointB = points[i]
                        tri.PointC = points[nextIdx]
                        tri.Color = fov.FillColor or fov.InnerColor or Color3.new(1,1,1)
                        tri.Transparency = 0.1
                        tri.Filled = true
                    else
                        tri.Visible = false
                    end
                end
            end
        end
    else
        if fov then
            if fov.InnerCircle then fov.InnerCircle.Visible = false end
            if fov.OuterCircle then fov.OuterCircle.Visible = false end
            if fov.FillCircle then fov.FillCircle.Visible = false end
            if fov.Lines then for _, l in ipairs(fov.Lines) do l.Visible = false end end
            if fov.Triangles then for _, t in ipairs(fov.Triangles) do t.Visible = false end end
        end
    end
end)

getgenv().WatermarkConnection = getgenv().RunService.Heartbeat:Connect(function() getgenv().FrameCounter = getgenv().FrameCounter + 1 end)
task.spawn(function()
    while task.wait(1) do
        if Toggles.ShowWatermark and not Toggles.ShowWatermark.Value then 
            task.wait(1)
            continue 
        end
        getgenv().FPS = getgenv().FrameCounter
        getgenv().FrameCounter = 0
        local ping = "0"
        pcall(function() ping = getgenv().Stats.Network.ServerStatsItem["Data Ping"]:GetValueString() end)
        local executorName = (identifyexecutor and identifyexecutor()) or (getexecutorname and getexecutorname()) or "Unknown"
getgenv().Library:SetWatermark(string.format('Ghosted<font color="#9B8FE8">.hvh</font> | %s | %d fps | %s ms | players: %d/%d', executorName, getgenv().FPS, ping, #getgenv().Players:GetPlayers(), getgenv().Players.MaxPlayers))    end
end)

getgenv().Library:OnUnload(function()
    if getgenv().WatermarkConnection then getgenv().WatermarkConnection:Disconnect() end
    if getgenv().TargetHealthConnection then getgenv().TargetHealthConnection:Disconnect() end
    if getgenv().TargetCleanupConnection then getgenv().TargetCleanupConnection:Disconnect() end
    if getgenv().GhostedFOV then
        if getgenv().GhostedFOV.Inner then getgenv().GhostedFOV.Inner:Remove() end
        if getgenv().GhostedFOV.Outer then getgenv().GhostedFOV.Outer:Remove() end
        if getgenv().GhostedFOV.ScreenGui then getgenv().GhostedFOV.ScreenGui:Destroy() end
    end
    if getgenv().TracerLine then getgenv().TracerLine:Remove() end
    if getgenv().TracerOutline then getgenv().TracerOutline:Remove() end
    if getgenv().TracerLine2 then getgenv().TracerLine2:Remove() end
    if getgenv().TracerOutline2 then getgenv().TracerOutline2:Remove() end
    if getgenv().HitNotifGui then getgenv().HitNotifGui:Destroy() end
    if getgenv().StrafeConnection then getgenv().StrafeConnection:Disconnect() end
    if getgenv().SpectateConnection then getgenv().SpectateConnection:Disconnect() end
    getgenv().destroyStrafeVisualizer()
    getgenv().resetStrafeCamera()
    getgenv().Library.Unloaded = true
end)

getgenv().SaveManager:SetLibrary(getgenv().Library)
getgenv().SaveManager:BuildConfigSection(getgenv().Tabs.Settings)
getgenv().SaveManager:SetFolder('ghosted/config')



getgenv().Library.ToggleKeybind = Options.MenuKeybind

if Options.NotifPos then
    Options.NotifPos:OnChanged(function() getgenv().UpdateNotifPosition(Options.NotifPos.Value) end)
end

if Toggles.VisualizeStrafe then
    Toggles.VisualizeStrafe:OnChanged(function()
        if Toggles.VisualizeStrafe.Value and getgenv().StrafeConnection then getgenv().createStrafeVisualizer() else getgenv().destroyStrafeVisualizer() end
    end)
end

if Toggles.SpectateTarget then
    Toggles.SpectateTarget:OnChanged(function()
        if Toggles.SpectateTarget.Value then getgenv().startSpectate() else
            if getgenv().SpectateConnection then getgenv().SpectateConnection:Disconnect() getgenv().SpectateConnection = nil end
            getgenv().resetStrafeCamera()
        end
    end)
end

getgenv().SaveManager:IgnoreThemeSettings()
getgenv().SaveManager:SetIgnoreIndexes({})
getgenv().SaveManager:LoadAutoloadConfig()
