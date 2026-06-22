# Localization
Any text displayed in game (hud descriptions, quests, item names, dialogue, etc...) is a localized string, meaning it needs to be specified in a localization file for each language.

For ingame localization, all text needs to be localized for each language. Mods default to english localization, if user selects a language that the users doesn't have.

## References in data

Some fields in some tables are **stringIds**, which in game are replaced by corresponding localized text (For example, UIName property in item table). Some **stringIds** are prefixed with **ui_**, which is just a optional convention, it is not actually a requirement.

## Localization files

Mods localization files are placed in **Localization/** folder in the mod directory. It needs to contain PAK files in the format *language*_xml.pak for text and *language*.pak for voiceovers.

### Text localization

Inside text paks, any number of localization files can be placed, all named *anything*_*modid*.xml , with following structure:

```xml
<Table>
  <Row><Cell>buff_against_all_odds</Cell><Cell>Against All Odds</Cell><Cell>Against All Odds</Cell></Row>
</Table>
```

First cell is the **stringId**, second cell is irrelevant, last cell is the actual translation used in game.



If the filename is in a different format, it will still be loaded, however it will be loaded at a wrong time and will spam the log with "hash clash" errors.
<span style="background-color:mistyrose;">Before patch 1.3, only text__*modid*.xml is loaded correctly, all other files are loaded in random order</span>