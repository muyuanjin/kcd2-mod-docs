# Static ports
Event system in Skald works like these:

1. Define event module in library
2. Instantiate this module in event place

There is a problem though: there are a lot of event places with their event instances. Imagine now you need to get some data from the quest in your event. You cant just pass this info to definition and expect it to work, because definition is just a template that you instantiate. Actual event logic is running inside instances, and each instance has its own state. In other words, if you have your event instantiated in 50 event places across all Trosecko and one of the event variant want to know if player has won the tournament... then you have to connect tournament module to every event instance to pass that data to the variant. You also should not forget to do it for every new instance that would be added in future. This is unsafe and not very readable. Thats why static ports were created.

Static ports allow us to automate this wiring. It is basically the impossible thing from the previous paragraph ;) It allows us to communicate with every instance through its definition, without needing to speak to each instance separatly. So imagine you have a quest event inside your quest. And you need to get triggers from that event to change something in your quest. Well you just add these triggers as static ports to the event definition by clicking the grey "Add static port" button near the normal "Add port" button:
![](https://youtrack.warhorsestudios.cz/api/files/235-18129?sign=MTc0MjE2OTYwMDAwMHwyNi02NTd8MjM1LTE4MTI5fF9URDdPVXQ4bXo4eS0zOWJWNDE3WXd4QUFWcURmR2N5dzgyeDBPR0pfLWcNCg&updated=1724041228986)

Those blue ports would be implicitly rewired to every instance for you. In other words, when any event instance would send trigger to this ports like this:
![](https://youtrack.warhorsestudios.cz/api/files/235-18131?sign=MTc0MjE2OTYwMDAwMHwyNi02NTd8MjM1LTE4MTMxfDBVSVJGdDFELXVtU0p0RDZLQUR6aFphMmZoVjVua2lGT0dUWndLQWw5SGsNCg&updated=1724041225942)  

it would trigger at definition library inside you quest, where you could easily react to it without a spaghetti of links:

![](https://youtrack.warhorsestudios.cz/api/files/235-18132?sign=MTc0MjE2OTYwMDAwMHwyNi02NTd8MjM1LTE4MTMyfFYyRVNGNE9ha051TlpaYUVXZDNRMmFLNGNDR2NkdUxrdzZjdTZ5cXptR1UNCg&updated=1724041224570)  

Same goes for input data. Whenever event instance need some info from the quest, it just look at input static port:
![](https://youtrack.warhorsestudios.cz/api/files/235-18135?sign=MTc0MjE2OTYwMDAwMHwyNi02NTd8MjM1LTE4MTM1fGs4WTdtMUVGLXl2blBSNU0xNXhYU2E1aFBCeDgxUGZDME1ESm1uRFhJelUNCg&updated=1724041223290)

which is implicitly wired to definition:

![](https://youtrack.warhorsestudios.cz/api/files/235-18136?sign=MTc0MjE2OTYwMDAwMHwyNi02NTd8MjM1LTE4MTM2fEMwcG16dkFJUWhKMGR1eXNRTDhsUzgxN3F6UWpLVUxheE9jaF9YOE80QWcNCg&updated=1724041221723)  

Which allows us to connect this data only once to the definition instead of connecting it to every event instance.