# Random Event Variant node


![](https://youtrack.warhorsestudios.cz/api/files/235-11003?sign=MTc0MjE2OTYwMDAwMHwyNi02NTd8MjM1LTExMDAzfEN1Z3JZUGcwYTdDenFQX0I5QVotaGJnZE5NTFFpYjhSU2phbDJqMzJaUzANCg&updated=1676035486076)

A module that contains event variant logic. Can only be created inside a **Random event** node or another **Random event variant** node. Every event should have at least one variant to function. The **Random event variant** node defines which profile should be streamed if this variant is chosen, what souls should be spawned and the probability of this variant to occur.

* Inputs:
  * ***OnSpawn*** — triggers when variant or its subvariant spawns
  * ***OnDespawn*** — triggers when variant or its subvariant despawns
* Outputs:
  * ***ActivateCooldown*** — trigger event cooldown
  * ***IsEnabled*** — bool port to disable/enable variant
* Properties:
  * ***Profile*** — a profile type asset to stream when this variant is selected to spawn
  * ***Weight***— a floating-point value specifying the probability of this variant to be selected (this value is then linearly scaled with duration since the last time this variant was selected)
  * ***Tags*** — an array of tags that can be used later to disable event by activating the **DisableRandomEvent** node.  New tags can be defined in "*Tables\RandomEvent\RandomEventTag.xml*"
  * ***NPC Groups** — a list of NPC groups that are spawned when this variant is selected*
    * ***Soul pool*** — which soul pool to use for this NPC group
    * ***Tag points*** — an asset for tag points, where NPCs would be spawned
    * **NPC Asset name** — an asset to store a reference to spawned NPCs
    * **Scheduler proxy** — an asset name string of a LinkableObject that acts as a scheduler proxy for the spawned NPCs
    * **Count** — defines howв many NPCs should be spawned from the soul pool

# *Variant inheritance*

When a variant node is placed inside another variant node, it inherits its properties if they are not defined, otherwise, it overrides them. When a variant has at least one subvariant, it's automatically removed from the pool of valid variants to spawn, becoming an abstract variant. If you still want this supervariant to spawn, you can disable that behavior by unchecking the ***Abstract*** checkbox in the **Random event variant** node.

When a variant is spawned, it triggers its ***OnSpawn*** input trigger inside the **Random event variant** node, so you can react to it in your variant logic. When inheritance is involved, all variant's supervariants up to the event node is also calling their ***OnSpawn*** trigger. That's how you can share common logic for all subvariants by defining it in a supervariant and reacting to its spawn trigger. To be able to distinguish which variant is actually spawned, you can use ***IsSpawned*** bool port, which returns *True* only for the actual variant that is spawned. For example, imagine we have the following variant inheritance structure of the "*Prepadeni Na Ceste*" event:

![](https://youtrack.warhorsestudios.cz/api/files/235-11004?sign=MTc0MjE2OTYwMDAwMHwyNi02NTd8MjM1LTExMDA0fEl4TkJ1UTlSRldmdWV4elBTQjhKSWdOZlJEWVpMajktcWhqV2tUSU5UNFUNCg&updated=1676035486076)

*The Horse* is a subvariant of *Raubritter* and *Raubritter* is a subvariant of *HoldUp*. Because *HoldUp* is an abstract variant, the event system would only spawn *Raubritter* or *Horse* variant. Let's see what happens when the player goes through the trigger area and the event system randomly chooses *Raubritter* as a variant to spawn:

![](https://youtrack.warhorsestudios.cz/api/files/235-11005?sign=MTc0MjE2OTYwMDAwMHwyNi02NTd8MjM1LTExMDA1fDFJYWppN2RKRzl2ZGRkLUgtLTdNazF4NndJaDdUVThKbnFBV3A4SXVUMGsNCg&updated=1676035486076)

As you can see ***OnSpawn*** port triggers on every module starting from the *Raubritter* variant and up to the event node. The *Horse* variant would not trigger its ***OnSpawn*** port, and its ***IsSpawned*** port would return *False*. Now let's see what would happen if the Horse variant is spawned?

![](https://youtrack.warhorsestudios.cz/api/files/235-11006?sign=MTc0MjE2OTYwMDAwMHwyNi02NTd8MjM1LTExMDA2fGdLUmdGckc0d2VveGZ2YUd6OXBkdXpKRTdUTEhyOGdvMi1PX2pnQzg3XzgNCg&updated=1676035486076)

By spawning the *Horse* variant, we are going through the whole inheritance path and calling all ***OnSpawn*** ports, but still, returning ***IsSpawned*** as *True* only for the *Horse* variant.