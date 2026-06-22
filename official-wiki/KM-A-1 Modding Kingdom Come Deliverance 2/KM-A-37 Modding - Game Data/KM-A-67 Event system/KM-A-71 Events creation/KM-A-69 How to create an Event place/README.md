# How to create an Event place
**Before creating a completely new *event place*, be sure that you really need it**. Event places are shared between events, therethrough it make no sense to create two different event places at the exact same location (8x8m area) in the level. Before continuing, I recommend you to open the editor and load nearby layers to make sure there is no already existing event place! If there is, skip this tutorial.



At this point you are completely sure that there is no event place at your desired location. Now you have a burden on your shoulders to create one. You've procrastinated a lot, but deadline is coming. I'll try to make this journey as painless as possible. So turn on your pomodoro timer and lets dive in:

 1. Choose a name for the *event place*. It should properly describe the location. If there's nothing you can come up with, you can choose from the following general ones:

    * road
    * roadJunction

    The full event place name with region code would be \<region code\>_\<location name\>. For example tzda_road

    It is possible, that there is already an event place with such name under that region. In such case add a number to the end of the name. For examle: tzda_road2

 2. Create an *event place* module in Skald

    * In Trosecko level it should be done under Barbora-\>trosecko-\>eventPlaces
    * In Kutnohorsko level it should be done under Barbora-\>kutnohorsko-\>eventPlaces

 3. Set its "Parent node" properties:

    1. Set name: \<region code\>_\<location name\>, Example: tvid_road2
    2. Set design name (in czech): \<Region\> \<location name\>, Example: Vidlak cesta 2

 4. Enable it by checking the *IsEnabled* input port.

 5. Switch to the editor. Under the desired region create a new layer. Name it "eventPlace_\<location name\>". Example: eventPlace_roadJunction. Set it's color to orange rgb(223,121,52) or use color pick tool on existing event place layer.

 6. Right click on the layer, choose *Insert Layer Template* and select *eventPlace* template. A new layer would be created with a prefab placed right in front of the camera.

 7. Select the prefab and rename to \<region code\>_\<location name\>_eventPlace, Example: tvid_road2_eventPlace

 8. Before we move on to placing the prefab in the editor, let's review some event place theory. An event place is a defined area in the level (usually not bigger than an 8m x 8m square) where an event can take place. Each event place has a center point (marked by a "fastTravel_close" tagpoint), where the player is teleported if their fast travel is interrupted by an event.

    If two events are more than \~25m apart, it's important to create separate event places for each of them. This is because each event place needs its own center point, and it's not possible to define a single center point for events that are too far apart. Creating separate event places also gives us more control over spawning these events, as we can use different trigger areas for each event. This is particularly important in tighly packed areas like cities or villages. Another reason for creating a separate event place is that it is not possible to have two events of the same type in one event place. Keep this in mind when deciding whether two events can share an event place.

 9. Players should not be able to see the center of the event place when they enter the trigger area. If necessary, adjust the trigger area to ensure this. Sometimes it may not be possible to achieve this with only one trigger area. For example, in a large open space, it is propably better to have several small trigger areas on the roads to limit the directions from which the player can spawn the event. In such cases, you should duplicate the existing trigger area and link it to the eventPlace entity with the link name "asset['RandomEventPlaceTrigger']".

10. In the eventPlace prefab, you'll find tagpoints that define where the player will appear if fast travel is interrupted. Make sure you position them correctly. If you're making an event place in a village or city, you can skip this step since those events won't interrupt fast travel. However, it's still a good idea to make a separate event place for events that are far away to have better control over the trigger area.

    1. fastTravel_close place it at the center of event place.
    2. fastTravel_far[1-4] place them on the roads about 30m far from the event place center. One per road. They should face the direction of the event. You can delete tagpoint which you didn't use.

11. Link concept entity with newly created event place:

    1. For Trosecko level you can find concept entity at *Main/_quest/_script* under the name *trosecko*.
    2. Create a link from it to the *in_concept* prefab port of *eventPlace* prefab.
    3. Name it module['\<region code\>_\<location name\>']. Example: module['tvid_road2']

12. Set newly created layer to be included in **events** profile:

    ![](https://youtrack.warhorsestudios.cz/api/files/235-21226?sign=MTc0MjE2OTYwMDAwMHwyNi02NTd8MjM1LTIxMjI2fEh3U2NQU01ITmRQRU9YWEdZd3FaU2FDV21keUtXQlhvN2R5eFhQbnUwN3MNCg&updated=1723967436497)  

13. You're done! Great job! 😎😎😎