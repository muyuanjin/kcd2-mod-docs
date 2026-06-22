# Crime
Crime is a complex system written (or drawn?) mainly in AI Behavioral trees, but we can modify some of the basic aspects via database tables as well.

### Crime.xml
All the crimes are defined in `Data/Libs/Tables/rpg/crime.xml`, the entry looks like this:

```xml
<crime expiration="5" fine="1500" importance="130" isCrime="true" isSpreadable="true" isViolent="true" jail="5" label="assault" metaroleLabel="ASSAULT" scalingWithSocialClass="true" ui_name="ui_crime_assault" />
```
- Fine is defined in decigroschen (/10)

### Script_params.xml
This database table is used throughout the game (not only by crime, but mainly by Crime) and it adds a parametrization to some of the magical values. It's located at `Data/Libs/Tables/ai/script_params.xml`. The entries look like this:

```xml
<ScriptParam Name="crime_longTermMemoryTrespassExpiration" Value="7200.0" Comment="" />
<ScriptParam Name="crime_checkHomeStashes_robbedValue_threshold_small" Value="50.0" Comment="Robbed value threshold for small theft" />
<ScriptParam Name="crime_checkHomeStashes_maxDistanceToStash" Value="40.0" Comment="Measured for kmal_studfarm" /> 
```
It's basically just a float value with a name that's referenced inside SKALD or AI, the comments/names should help us navigate around.