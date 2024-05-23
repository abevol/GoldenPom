---@meta _
-- globals we define are private to our plugin!
---@diagnostic disable: lowercase-global

-- this file will be reloaded if it changes during gameplay,
-- 	so only assign to values or define things here.

local function GetUpgradedTraitRarity( traitData, stacks, rarityUpgradeOrder )
	stacks = stacks or 1
    local newRarity = traitData.Rarity
    for _ = 1, stacks do
        local temp = Game.GetUpgradedRarity(newRarity, rarityUpgradeOrder)
        if (temp == nil) then break end
        if traitData.RarityLevels[temp] == nil then break end
        newRarity = temp
    end
    return newRarity
end

function patch_CreateUpgradeChoiceButton(base, screen, lootData, itemIndex, itemData)
	-- printMsg("[CreateUpgradeChoiceButton] lootData.Name: %s, itemData.Name: %s, itemData.ItemName: %s, itemData.Rarity: %s",
    -- lootData.Name, itemData.Name, itemData.ItemName, itemData.Rarity)

    local newRarity = nil
    if lootData.StackOnly and itemData.ItemName ~= "FallbackGold" and Game.RandomChance(Config.UpgradeRarityChance) then
        local traitData = Game.CurrentRun.Hero.TraitDictionary[itemData.ItemName][1]
        if traitData then
            newRarity = GetUpgradedTraitRarity(traitData, lootData.StackNum)
            -- printMsg("[CreateUpgradeChoiceButton] lootData.Name: %s, itemData.Name: %s, itemData.ItemName: %s, itemData.Rarity: %s, newRarity: %s",
            -- lootData.Name, itemData.Name, itemData.ItemName, itemData.Rarity, newRarity)
            if newRarity ~= traitData.Rarity then
                screen.RarityText.RawText = string.format("{$Keywords.%s}{!Icons.RightArrow}{$Keywords.%s}", traitData.Rarity, newRarity)
            end
        end
    end

    local button = base(screen, lootData, itemIndex, itemData)
    if newRarity then
        button.Data.NewRarity = newRarity;
    end
    screen.RarityText.RawText = nil
    return button
end

local function AssignRarityTrait( traitData, newRarity )
    if traitData.RarityLevels[newRarity] == nil then return end

    local persistentValues = {}
    for i, key in pairs( Game.PersistentTraitKeys ) do
        persistentValues[key] = traitData[key]
    end

    local oldstackNum = Game.GetTraitCount( Game.CurrentRun.Hero, { TraitData = traitData } )
    local newTrait = Game.GetProcessedTraitData({ Unit = Game.CurrentRun.Hero, TraitName = traitData.Name, StackNum = oldstackNum, Rarity = newRarity})
    for i, key in pairs( Game.PersistentTraitKeys ) do
        newTrait[key] = persistentValues[key]
    end

    Game.RemoveTrait( Game.CurrentRun.Hero, traitData.Name, { SkipActivatedTraitUpdate = true })
    Game.AddTraitToHero({ TraitData = newTrait, SkipNewTraitHighlight = true, SkipActivatedTraitUpdate = true, SkipSetup = true })

    return newTrait
end

-- function patch_HandleUpgradeChoiceSelection(base, screen, button, args)
-- 	args = args or {}
-- 	local upgradeData = button.Data

--     if button.LootData.StackOnly and upgradeData.Name ~= "FallbackGold" and upgradeData.NewRarity then
--         local traitData = Game.CurrentRun.Hero.TraitDictionary[upgradeData.Name][1]
--         if traitData then
--             -- printMsg("[HandleUpgradeChoiceSelection] traitData.Name: %s, traitData.Slot: %s, traitData.Rarity: %s",
--             -- traitData.Name, traitData.Slot, traitData.Rarity)
--             AssignRarityTrait(traitData, upgradeData.NewRarity)
--         end
--     end

--     return base(screen, button, args)
-- end

-- function patch_UseStoreRewardRandomStack(base, args)
--     args = args or {}
--     printMsg("[UseStoreRewardRandomStack] args: \n%s\n", dumpTable(args))
--     return base(args)
-- end

function patch_IncreaseTraitLevel(base, traitData, stacks)
    stacks = stacks or 1
    -- printMsg("[patch_IncreaseTraitLevel] traitData: \n%s\n", dumpTable(traitData))
    if Game.RandomChance(Config.UpgradeRarityChance) then
        local newRarity = GetUpgradedTraitRarity(traitData, stacks)
        if newRarity ~= traitData.Rarity then
            printMsg("[patch_IncreaseTraitLevel] traitData.Name: %s, traitData.Slot: %s, traitData.Rarity: %s, newRarity: %s",
            traitData.Name, traitData.Slot, traitData.Rarity, newRarity)
            traitData = AssignRarityTrait(traitData, newRarity)
        end
    end
    return base(traitData, stacks)
end
