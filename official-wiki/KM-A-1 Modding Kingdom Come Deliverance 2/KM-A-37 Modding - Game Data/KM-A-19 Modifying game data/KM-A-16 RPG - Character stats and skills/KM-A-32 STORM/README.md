# STORM
STORM (Soul-to-role manager) is a tool that helps us automate assigning RPG, ScriptContexts, Inventories, Dialogue roles, Appearances, UI names, etc. to souls throughout the game. This tool runs whenever the game loads or for a given soul when it spawns (e.g. in an event).

STORM is located at `Data/Libs/Storm` (or `IPL_GameData.pak/Libs/Storm`) and its entry point is `storm.xml`. This root includes our custom selectors, custom operations and implements all the Tasks that perform the STORM logic.

### File structures

#### STORM Entry point file

```xml
<sources>
  <common>
    ...
    <source path="customselectors.xml" />
    ...
  </common>
  <tasks>
    ...
    <task name="..." class="...">
      ...
      <source path="taskfile.xml" />
      ...
    </task>
    ...
  </tasks>
</sources>
```

#### STORM Rules file

```xml
<storm>
  <customSelectors>
    ...
    <customSelector name="..."> 
      ...
    </customSelector >
    ...
  </customSelectors>
  <customOperations>
    ...
    <customOperation name="..."> 
      ...
    </customOperation>
    ...
  </customOperations>
    <rules> 
      ...
      <rule name="...">
        <selectors>
          ....
        </selectors>
        <operations>
          ...
        </operations>
      </rule>
      ...
    </rules>
</storm>
```

### Rule

Each rule has a specific structure that needs to be followed. The rule is a combination of selectors and operations, as we can see below - we want to give millers and beggars a specific dialogue role for "Can I have a beer (male)". We will write more about selectors and operations itself a bit later.

```xml
<rule name="...">
  <selectors>
    <or>
			<hasSocialClass name="miller" />
      <hasSocialClass name="beggar" />
		</or>
  </selectors>
  <operations>
    <addRole name="DAL_BYCH_SI_PIVO_MUZ" />
  </operations>
</rule>
```

You can wrap selectors in `<or>`,`<and>`,`<not>` to introduce some boolean logic when selecting souls. The rules execute from the top to the bottom, you can override this by specifying `<rule order="(number)">`.

### Task

Tasks are a group of "rules files" that limit what the rules inside can do, e.g. you can only affect RPG under the "abilities" task.

* abilities – RPG, stats, perks, skills
* characters – Skald character, voice
* names – UI names
* reputations – Reputation
* roles – Dialogue roles and metaroles

Operations that are under an incorrect task won't take effect!



### Custom selectors

We can aggregate similar selectors into a custom selector to make the rule more readable.

```xml
<customSelector name="isMiddleClass" mode="or">
	<hasSocialClass name="villager" />
	<hasSocialClass name="bartender" />
	<hasSocialClass name="baker" />
	<hasSocialClass name="butcher" />
	<hasSocialClass name="craftsman" />
	<hasSocialClass name="miller" />
	...
</customSelector>
```

And then combine multiple custom selectors into another custom selector

```xml
<customSelector name="reactsToSmell">
    <isNotBffAndHasNoUniqueBffVoice />
    <or>
      <isPublicEnemy/>
      <isNobleClass/>
      <isUpperClass/>
      <and>
        <isMiddleClass/>
        <isWoman />
      </and>
    </or>
</customSelector>
```

which can be used in a rule

```xml
<rule name="contexts_reactToSmell">
	<selectors>
		<reactsToSmell/>				
	</selectors>
	<operations>
		<addContext name="crime_canReactToSmell" />
	</operations>
</rule>
```

### Custom operations

Operations can be aggregated in the same way

```xml
<customOperation name="addBribeRoles">
  <addRole name="SMLOUVANI"/>
  <addRole name="BRIBE"/>
  <addMetarole name="BRIBE"/>
</customOperation>
```

So we don't have to repeat ourselves every time we want to add roles for bribe

```xml
<rule name="...">
  <selectors>
    <isGuard/>
  </selectors>
  <operations>
    <addBribeRoles/>
  </operations>
</rule>
```

## Globally used selectors and operations

We have a library of frequently used selectors and operations, which can be found in these files that are included in the Entry root file:

```xml
<common>
	<!-- Common selectors -->
	<source path="common\base.xml" />
	<source path="common\baseArchetypes.xml" />
	<source path="common\baseZones.xml" />
	<!-- Common operations -->
	<source path="common\roles_operations.xml" />
</common>
```

List of selectors: [KM-A-33](KM-A-33 Selectors/README.md)
List of operations: [KM-A-34](KM-A-34 Operations/README.md)