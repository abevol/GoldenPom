# Golden Pom

Allows Pom to upgrade Boon's rarity while leveling it up.

It also allows you to customize the effective chance.

## Features

1. Allow pom to upgrade rarity.
2. Allow custom the effective chance.

## Automatic Installation

Use the [internal-build-of-r2modman].

## Manual Installation

1. Install the mod loader.
Place the main Hell2Modding file, called d3d12.dll, next to the game executable called Hades2.exe inside the game folder.

2. Then run the game.
The mod loader will automatically create the mod file directory in the game directory: Hades II\Ship\ReturnOfModding\plugins.
If you find that this directory has already been generated, you can exit the game to proceed to the next step.

3. Install this mod and supporting mods.
After downloading and extracting the mod, copy it to the above-generated directory: Hades II\Ship\ReturnOfModding\plugins, ensuring the following file path structure (using the manifest.json file as an example):
`Hades II\Ship\ReturnOfModding\plugins\Abevol-GoldenPom\manifest.json`
`Hades II\Ship\ReturnOfModding\plugins\SGG_Modding-DemonDaemon\manifest.json`
And so on, the same applies to other mods.
*Note, the structure for the mod folder name must be: 'author-modname'. Do not add version numbers or any extra characters; otherwise, it will result in an error.*

4. Now you can launch the game again, and if there are no surprises, all the mods should start to work.

## Requirements

Mod loader:
[Hell2Modding-Hell2Modding]

Dependencies:
[SGG_Modding-DemonDaemon]
[SGG_Modding-ModUtil]
[SGG_Modding-ENVY]
[SGG_Modding-Chalk]
[SGG_Modding-SJSON]
[SGG_Modding-ReLoad]

## How to configure

You need to modify this configuration file:
`Hades II\Ship\ReturnOfModding\config\Abevol-GoldenPom\config.toml`

You can determine the probability of upgrading rarity by modifying the value of `UpgradeRarityChance`, with the numerical range being 0 - 1.

## Config Example

```ini
Debug = true
Enabled = true
UpgradeRarityChance = 1.0
```

[internal-build-of-r2modman]: https://github.com/xiaoxiao921/r2modmanPlus/releases/
[Hell2Modding-Hell2Modding]: https://thunderstore.io/c/hades-ii/p/Hell2Modding/Hell2Modding/
[SGG_Modding-DemonDaemon]: https://thunderstore.io/c/hades-ii/p/SGG_Modding/DemonDaemon/
[SGG_Modding-ModUtil]: https://thunderstore.io/c/hades-ii/p/SGG_Modding/ModUtil/
[SGG_Modding-ENVY]: https://thunderstore.io/c/hades-ii/p/SGG_Modding/ENVY/
[SGG_Modding-Chalk]: https://thunderstore.io/c/hades-ii/p/SGG_Modding/Chalk/
[SGG_Modding-SJSON]: https://thunderstore.io/c/hades-ii/p/SGG_Modding/SJSON/
[SGG_Modding-ReLoad]: https://thunderstore.io/c/hades-ii/p/SGG_Modding/ReLoad/
