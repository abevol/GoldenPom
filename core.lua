local mod = GoldenPom

if not mod.Config.Enabled then return end

local function printMsg(text)
    if not mod.Config.Debug then return end
    local green = "\x1b[32m"
    local reset = "\x1b[0m"
    print(green .. "[GoldenPom] " .. text .. reset)
end

local function GetUpgradedTraitRarity( traitData, stacks, rarityUpgradeOrder )
	stacks = stacks or 1
    local newRarity = traitData.Rarity
    for _ = 1, stacks do
        local temp = GetUpgradedRarity(newRarity, rarityUpgradeOrder)
        if (temp == nil) then break end
        if traitData.RarityLevels[temp] == nil then break end
        newRarity = temp
    end
    return newRarity
end

ModUtil.Path.Wrap("CreateUpgradeChoiceButton", function(base, screen, lootData, itemIndex, itemData)
    printMsg(string.format("[CreateUpgradeChoiceButton] lootData.Name: %s, itemData.Name: %s, itemData.ItemName: %s, itemData.Rarity: %s",
    lootData.Name, itemData.Name, itemData.ItemName, itemData.Rarity))

    local newRarity = nil
    if lootData.StackOnly and itemData.ItemName ~= "FallbackGold" and RandomChance(mod.Config.UpgradeRarityChance) then
        local traitData = CurrentRun.Hero.TraitDictionary[itemData.ItemName][1]
        if traitData then
            newRarity = GetUpgradedTraitRarity(traitData, lootData.StackNum)
            if newRarity ~= traitData.Rarity then
                screen.RarityText.RawText = string.format("{$Keywords.%s}{!Icons.RightArrow}{$Keywords.%s}", traitData.Rarity, newRarity) 
            end
        end
    end

    local button = base(screen, lootData, itemIndex, itemData)
    if newRarity then
        button.Data.NewRarity = newRarity;
    end
    return button
end, mod)

local function AssignRarityTrait( traitData, newRarity )
    if traitData.RarityLevels[newRarity] == nil then return end

    local persistentValues = {}
    for i, key in pairs( PersistentTraitKeys ) do
        persistentValues[key] = traitData[key]
    end

    local oldstackNum = GetTraitCount( CurrentRun.Hero, { TraitData = traitData } )
    local newTrait = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = traitData.Name, StackNum = oldstackNum, Rarity = newRarity})
    for i, key in pairs( PersistentTraitKeys ) do
        newTrait[key] = persistentValues[key]
    end

    RemoveTrait( CurrentRun.Hero, traitData.Name, { SkipActivatedTraitUpdate = true })
    AddTraitToHero({ TraitData = newTrait, SkipNewTraitHighlight = true, SkipActivatedTraitUpdate = true, SkipSetup = true })

    return newTrait
end

ModUtil.Path.Wrap("HandleUpgradeChoiceSelection", function(base, screen, button, args)
	args = args or {}
	local upgradeData = button.Data

    if button.LootData.StackOnly and upgradeData.Name ~= "FallbackGold" and upgradeData.NewRarity then
        local traitData = CurrentRun.Hero.TraitDictionary[upgradeData.Name][1]
        if traitData then
            printMsg(string.format("[HandleUpgradeChoiceSelection] traitData.Name: %s, traitData.Slot: %s, traitData.Rarity: %s",
            traitData.Name, traitData.Slot, traitData.Rarity))
            AssignRarityTrait(traitData, upgradeData.NewRarity)
        end
    end

    base(screen, button, args)
end, mod)
