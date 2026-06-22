# How to create a Generic Random Event
## Skald

Place *GenericRandomEvent* concept node anywhere in the graph (not in EventPlace nor Library).
Set *GenericEventType* and *Cooldown* properties.

Add *RandomEventVariant* inside the event node. And set it's properties. You should probable set the *CooldownOverride* property as the default is most likely too high (the default is shared for all variant types).
You can theoretically have multiple variants in every event node. And then variant would be chosen the same way (based on weight and cooldown) as for normal random events. You can also have multiple *GenericRandomEvent* with the same *GenericEventType* type. But I expect you won't need more than one.  Maybe in the future you could get the name of the node that was selected as a variable in the AI node, but currently it does not work like that.

If you reload concept graph you should now see the event and it's variant(s) in the random
events debug. In the debug all generic events are under the "fake" Event place *GenericEvents*.
Here <http://localhost:1403/player/randomEvents>
You can also see there all the cooldown values including the global *Generic* cooldown at the top.
![](https://youtrack.warhorsestudios.cz/api/files/235-16586?sign=MTc0MjE2OTYwMDAwMHwyNi02NTd8MjM1LTE2NTg2fEhxd0xHYXBpaS1qTjZjZ1JKMXZ2M3BwQi1xQkdLeWdTWlRRUEtMWlBiMjQNCg&updated=1724066114334)  

## AI

Now you need to add *FastTravelGenericRandomEvent* barrier node (Player category) in NPCs behavior.
You can select the *EventType*. And whether FastForward should be called.
This node has 2 out bools.

* *FastTravelContinuesOut* - This is true when fast travel continues after the barrier opens. Either player succesfully evaded or no event/variant was available (most likely due to one of the 3 types of cooldown).
* *EvadeFailedOut* - This is true only when player tried to evade and it failed (if player agreed to stop it will be false). I expect this to be used as a crime indicator.

If this node is executed without receiving perception message from Random event system (it should be the same as normal perception message) and player chooses to stop. Player will be moved to 0 0 0. This is on purpose because it should never happen.
If the Node is executed when player is not fast traveling, the barrier opens immediately and both out values will be *false*.
![](https://youtrack.warhorsestudios.cz/api/files/235-16587?sign=MTc0MjE2OTYwMDAwMHwyNi02NTd8MjM1LTE2NTg3fDFKYlpPNGtBTmp1b25uUmltVnFzaDJVSFg1MHd3UXFlcUdLSm9JWWNZVVkNCg&updated=1724066109558)  

If you want to test fast travel (and map still doesn't work), you can use the CVar
`wh_pl_FastTravelTo <entityName>` or `wh_pl_FastTravelTo x y z`
or in case fast travel is not allowed (for example when time is stopped) `wh_pl_FakeFastTravelTo`