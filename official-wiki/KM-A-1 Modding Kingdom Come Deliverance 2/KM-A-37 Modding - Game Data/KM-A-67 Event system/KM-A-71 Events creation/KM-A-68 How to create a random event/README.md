# How to create a random event
# Events debug

Web debugger connects to the running instance of editor/game and can be used to manually spawn events and tweak spawn settings for debug purposes. It also visualize probability curves and other data.

<http://localhost:1403/player/randomEvents>

# Skald nodes

The event system provides several new nodes in Skald. All of them are of module type:

* [Random event node](https://youtrack.warhorsestudios.cz/articles/KCD2-A-9094/Random-event-node)
* [Random event variant node](https://youtrack.warhorsestudios.cz/articles/KCD2-A-9095/Random-event-variant-node)
* [Random event place node](https://youtrack.warhorsestudios.cz/articles/KCD2-A-9096/Event-place-node)

# Event creation tutorial

The event creation pipeline consists of the following steps:

1. Create a *random event* node (event definition) in Skald:
2. Create a *random event variant* node inside your newly created *random event* node.
3. Create or reuse an *event place* module
4. Instantiate your *random event* node in the chosen *event place* module
5. Create and link event entities in the level

Let's look into each step in detail.

## 1\. Create an event definition

Firstly, we need to create an event definition. If it's a quest event, create a library inside your quest module. Your event definition would be located there.

If it's a general event, then use already created library in the root. All general events definitions are located in the library at "Barbora/random_events":

![](https://youtrack.warhorsestudios.cz/api/files/235-10569?sign=MTc0MjE2OTYwMDAwMHwyNi02NTd8MjM1LTEwNTY5fFhnbDYyOXBfQmdaQklabHk4X0ZUdDZxbmFxVE1zMzJXOENrVzdPVXBCR3MNCg&updated=1676035409636)  

Inside the library, create a *random event* definition node. Convention for event naming is the same as with quests and is decribed here: KCD2-A-8335.

Change the default name to lowerCamelCase. In our example that would be *crimeScene.*

*(Please ignore englishness of the event name in this particular example...* 🤫)

![](https://youtrack.warhorsestudios.cz/api/files/235-10675?sign=MTc0MjE2OTYwMDAwMHwyNi02NTd8MjM1LTEwNjc1fGVFUDRLS0laZ2lmUmJHRURZYXk0UHlsU0h4QlFGdm90Zk9aT2gtX1g1Wk0NCg&updated=1676035409636)  

Select it and set its Cooldown and Tags properties if needed. Or leave them with default values for now:

![](https://youtrack.warhorsestudios.cz/api/files/235-11267?sign=MTc0MjE2OTYwMDAwMHwyNi02NTd8MjM1LTExMjY3fGE3MnNuSGNoQ1ZvUF9GcnVhMlZSVVJrRWxhRmNXRHRvUWgyMzdNRjB0Vm8NCg&updated=1676035409636)  

## 2\. Create an event variant

Open an event definition in the random events library at "Barbora/random_events" and create a *random event variant* node there:

![](https://youtrack.warhorsestudios.cz/api/files/235-10679?sign=MTc0MjE2OTYwMDAwMHwyNi02NTd8MjM1LTEwNjc5fDE5RXpPWjJqNXJTMDE3NnZJYm5yVnNlQUtULWhjZmRjektNUmFELUlfQ00NCg&updated=1676035409636)  

Select your newly created variant and set its properties.

### Create NPC group and soul pool

If your event should spawn NPCs add a new NPC group under the variant's properties:

![](https://youtrack.warhorsestudios.cz/api/files/235-11165?sign=MTc0MjE2OTYwMDAwMHwyNi02NTd8MjM1LTExMTY1fG11TUppY3N0R01aOGVCa0pDbnM3RUk0dWhiOHRqUGtVYmNFdUlPQ0pqLWMNCg&updated=1676035409636)  

Once created:

![](https://youtrack.warhorsestudios.cz/api/files/235-11166?sign=MTc0MjE2OTYwMDAwMHwyNi02NTd8MjM1LTExMTY2fDFSMlZVV1ljUkhzbUJkSjZQMmtrSUVpREZJeThqX3JwMkhiSlZWZlQxdUENCg&updated=1676035409636)  

To specify which souls should be spawned you can choose between two properties: *soul name* or *soul pool.* If you only need to spawn a particular static soul, just fill its name in *soul name* property and skip *soul pool.* If you need to spawn a random soul from a predefined pool of possible souls, skip *soul name* property and choose a *soul pool* from the list.

**Soul pool** is just an array of soul names, defined in an XML file at "Tables\\rpg\\SoulPool.xml". Open it and there you will find all existing soul pools in the game. For structuring and separating soul pools from different events, I recommend using a comment tag at the top of the soul pools block, just to describe where these soul pools are used.

*Soul name* property is just a shortcut for soul pool, it creates an one-entry soul pool under the hood automatically.

**NPC Group** also defines additional spawning settings:

* Tag points — an asset for tag points, where NPCs would be spawned
* NPC Asset name — an asset to store a reference to spawned NPCs
* Scheduler proxy — an asset name string of a LinkableObject that acts as a scheduler proxy for the spawned NPCs
* Count — defines how many NPCs should be spawned from the soul pool
* Count SD — standard deviation of the normal distribution defined around *count* property. If set to zero, normal distribution is not used and exact count would be spawned

A variant can have several NPC Groups, that allows you to define different scheduler proxy and spawn points for specific NPCs in your event if needed.

## 3\. Create or reuse Random event places

Event places are tied to the level, so decide if you need Trosecko or Kutnohorsko. For Trosecko you can find all event places in module "Event places" at "Barbora/Trosecko/eventPlaces":

![](https://youtrack.warhorsestudios.cz/api/files/235-18122?sign=MTc0MjE2OTYwMDAwMHwyNi02NTd8MjM1LTE4MTIyfDZaRXRtOTN1LUhaTUFKQlZsWnlHUFVNTzNrX3lkRjhNcDNnQ1hVU25mTmcNCg&updated=1724041235890)  

(For Kutnohorsko it's the same, you can find all event places at "Barbora/Kutnohorsko/eventPlaces")

Open the gameplay module and you'll see all the existing event places in the level Trosecko:

![](https://youtrack.warhorsestudios.cz/api/files/235-18123?sign=MTc0MjE2OTYwMDAwMHwyNi02NTd8MjM1LTE4MTIzfHB4ay1WcWVFUi0ycklzTjZjbUQ3a1Q3WFlDWGw0ckRHc3B0OEhnM3A3cUUNCg&updated=1724041235026)  

All of these modules are instantiated *random event place* nodes. If you want your event to take place on an already existing event place, just open the module you need and proceed to the next step.

If you need a new event place, welcome to the KCD2-A-9462

## 4\. Instantiate Random event definition inside the Event place module

Open the event place module and instantiate the previously created random event definition node there:

![](https://youtrack.warhorsestudios.cz/api/files/235-10694?sign=MTc0MjE2OTYwMDAwMHwyNi02NTd8MjM1LTEwNjk0fGFJekRySzJIWVRqSU9NaFFLQ3c0OTIyNnJxZVRDVzg3RmNZbERvVndpWUkNCg&updated=1676035409636)  

This is an instance of the event definition. It is tied to an actual event place in the level. When you meet an event in the game, you trigger an instance, not a definition. It has its own state separated from other instances. That allows you to communicate with a particular instance of event. For example, if you want to disable only one specific instance, you can create an additional input port on the event definition that would disable the event, and later connect this port only to specific instances which are located under event place modules.

## 4\. Create and link event entities in the level

Once the event is instantiated in Skald, we need to connect it to the actual event entities in level. Let's create an event layer under the event place and name it after event. To illustrate how several events under the same event place are organized, I have also created dummy layers for other events *prepadeniNaCeste* and *ztratyANalezy*.

![](https://youtrack.warhorsestudios.cz/api/files/235-10718?sign=MTc0MjE2OTYwMDAwMHwyNi02NTd8MjM1LTEwNzE4fGI3THNZM3pMYVYtUVk3eDFZa012RkllZE55ZEttcmVGa3FHbkpjRVdBcTgNCg&updated=1676035409636)  

Inside the event layer there is a structure of layers:

* static
  * _script
  * _enviro
  * _common
* streamed
  * variant1
    * _script
    * _enviro
    * _common
  * variant2
    * _script
    * …

All static things that exist in the level all the time, like random event entities or spawn points, are placed under the *static/* layer. Things that are streamed when the specific variant of the event is spawned are placed under *streamed/\<variant_name\>/* layers:

![](https://youtrack.warhorsestudios.cz/api/files/235-10719?sign=MTc0MjE2OTYwMDAwMHwyNi02NTd8MjM1LTEwNzE5fFFxWDAyRkFraHJ5ejRNaXoydU1lcWY2aVFyaExXeVJqd2VvNkJUaE1OMjQNCg&updated=1676035409636)  

### Event entities

Add a Random event entity to the previously created *static/_script* layer. You can find the entity in the editor under the "Object/Entity" tab. You can filter the entities by name *RandomEvent*.

Name it regionСode_eventPlaceName_eventName. In our case it's *tvid_road2_crimeScene*.

Create a link from the event place entity to the event entity and name it *module\['\<event_name_in_skald\>'\]*:

![](https://youtrack.warhorsestudios.cz/api/files/235-11274?sign=MTc0MjE2OTYwMDAwMHwyNi02NTd8MjM1LTExMjc0fFFBSUZRRTZRejRhSVZqRlZ5VFdRTkJvUElHR1J1QTk4Y0hNS29FRWhRMVUNCg&updated=1676035409636)  

### Variant profile holders

TODO: write about dynamic profiles and event global profile

Now let's create a profile for our bandits variant layer, to be able to stream it once the variant is spawned. The convention for naming is: event_regionCode_eventPlaceName_eventName_variantName. In our case it's *event_tvid_road2_crimescene_bandits*. Make *game* and *events* profile as parent profiles and select *bandits* as a streaming layer.

**Switch to Skald**. Create a new asset of *Profile* type. Choose it in *Profile* property on the variant properties pane and select your newly created profile from the dropmenu. When the event system would choose this variant to spawn, it will also stream the selected profile.

![](https://youtrack.warhorsestudios.cz/api/files/235-18124?sign=MTc0MjE2OTYwMDAwMHwyNi02NTd8MjM1LTE4MTI0fE5NUmFvb1VpUGQwOWxSVXZnajhRcVN1a3ZDVnc4UVZXWVhTSGlrS0hXV1ENCg&updated=1724041234243)  

### Spawn points

Now let's add some spawn points for event NPCs. Create two tag points inside static/_script layer and link them from random event entity by asset name of your choice.

![](https://youtrack.warhorsestudios.cz/api/files/235-11276?sign=MTc0MjE2OTYwMDAwMHwyNi02NTd8MjM1LTExMjc2fFJqa3hGVFhYcjRsTlBFQ3JubVhPRkdUQ2kwa0NxcFAyOWRFeENEVkpWRE0NCg&updated=1676035409636)  

Once created, lets switch to the Skald and create asset for them there. I want to reuse these spawn points for all variants, so I'll create an asset in Random event module instead of a particular variant module:

![](https://youtrack.warhorsestudios.cz/api/files/235-10732?sign=MTc0MjE2OTYwMDAwMHwyNi02NTd8MjM1LTEwNzMyfEtKN3AtU0toZzRoZ3dWdUppQ0NPQlNiWVNGVTdQbXh3Vmk5SGN2dFgwN0UNCg&updated=1676035409636)  

These spawn points can now be used in *Tag points* property of NPC Group, to define where would NPC from that group spawn:

![](https://youtrack.warhorsestudios.cz/api/files/235-11278?sign=MTc0MjE2OTYwMDAwMHwyNi02NTd8MjM1LTExMjc4fE5mUV9mWXdUbm1hQW5YeFU5NTJrZGF2M3dwQWFHRUZwMDkwTGtPMlItVncNCg&updated=1676035409636)  

### Scheduler proxy

Scheduler proxy is used to define scheduler links for spawned NPCs. For scheduler proxy lets add another tag point to static/_script and link it from random event entity:

![](https://youtrack.warhorsestudios.cz/api/files/235-11277?sign=MTc0MjE2OTYwMDAwMHwyNi02NTd8MjM1LTExMjc3fGNHSk5USG9aWkhuN2d5SXVfdFpxNGNIX2E5TjNEa0ZtckdiR2R2TS1FR2sNCg&updated=1676035409636)  
![](https://youtrack.warhorsestudios.cz/api/files/235-11279?sign=MTc0MjE2OTYwMDAwMHwyNi02NTd8MjM1LTExMjc5fFhJNWJNWTViUU5iTGp5X0RvUXMxRnNfbk1NREVsN1BDaE54b0txNk9QcEUNCg&updated=1676035409636)  