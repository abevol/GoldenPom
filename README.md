# Golden Pom

Allow pom to upgrade rarity when it upgrade level.

It allows you to customize the effective chance.

## Features

1. Allow pom to upgrade rarity.
2. Allow custom the effective chance.

## Installation Tutorial

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

## Mod Loader

Suggest using [Hell2Modding].

## Requirements

Mod loader:
[Hell2Modding-Hell2Modding-1.0.23]

Supporting mods:
[SGG_Modding-DemonDaemon-1.0.1]
[SGG_Modding-ModUtil-3.1.1]
[SGG_Modding-ENVY-1.0.0]
[SGG_Modding-Chalk-1.0.0]
[SGG_Modding-SJSON-1.0.0]
[SGG_Modding-ReLoad-1.0.1]

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

[Hell2Modding]: https://thunderstore.io/c/hades-ii/p/Hell2Modding/Hell2Modding/
[Hell2Modding-Hell2Modding-1.0.23]: https://thunderstore.io/package/download/Hell2Modding/Hell2Modding/1.0.23/
[SGG_Modding-DemonDaemon-1.0.1]: https://thunderstore.io/package/download/SGG_Modding/DemonDaemon/1.0.1/
[SGG_Modding-ModUtil-3.1.1]: https://thunderstore.io/package/download/SGG_Modding/ModUtil/3.1.1/
[SGG_Modding-ENVY-1.0.0]: https://thunderstore.io/package/download/SGG_Modding/ENVY/1.0.0/
[SGG_Modding-Chalk-1.0.0]: https://thunderstore.io/package/download/SGG_Modding/Chalk/1.0.0/
[SGG_Modding-SJSON-1.0.0]: https://thunderstore.io/package/download/SGG_Modding/SJSON/1.0.0/
[SGG_Modding-ReLoad-1.0.1]: https://thunderstore.io/package/download/SGG_Modding/ReLoad/1.0.1/
