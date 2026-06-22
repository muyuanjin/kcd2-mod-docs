# Links
Any references between entities is handled by entity links. All entity links are processed on export based on their type.

## AI Links

AI Links are universal links that can carry data and can be queried from AI behavior trees. Each link has a tag - this can be any string, however if a tag is defined in data/AI/LinkTagDefinitions.xml (or in game code), it can carry data. The links tag and data are defined in the format tagName[data].

An important tag is asset['assetName'] - asset links are used by concept to resolved assets into actual in-game entities.

### Scheduler links

Scheduler is a system that selects NPC activities, both for quests and openworld behaviors. Scheduler searches for a behavior using links between entities, starting at the NPC (or "scheduler proxy" for player and spawned NPCs). Scheduler runs a search only when NPC finished a behavior and needs a new one (unless there are links with Urgency, which should be used sparingly).

Links have a specific format. All scheduler links always start with _, followed by comma separated parameters. Parameters \*must\* be in this specific order, all of them are optional (`_` is a working scheduler link):

| Parameter | Format | Description |
| --- | --- | --- |
| alias | `@aliasName` | Use parameters from Data/Libs/Tables/ai/SchedulerAlias.xml, can still be overriden on this link |
| time | `h:mm-h:mm` | Day of time when this links is valid |
| time variation | `~h:mm` | **time** will be extended (in both directions) by random value between 0 and **time variation** |
| role | `roleIn\|roleOut` | both `roleIn\|` `\|roleOut` are also valid. `role` can be any arbitrary string. RoleOut defines a "role" which the npc will have in any further links, RoleIn defines a role NPC must have to use this link (must have from a previous link). |
| sex | `M` or `F` | Only allows males or females. All animals are unisex, this condition will always fail. |
| aliveness | `A`, `D`, `U`, `I`,`L`, `O` | Only allows Dead(`D`), Unconscious (`U`), Incapacitated (`I`) (dead or alive), Living `L` (alive or unconscious), Dead Or Alive (`O`), or Any `A`. If not present, only allows alive NPCs |
| Priority | `0` - `255` | Priority of links, higher priority will always be selected over lower priority links |
| Sequence | `1.` - `15.` | When links with Sequence are linked from same hub, they will be executed in sequence |
| Attraction | `h:mm` | Time for which this NPC will keep selecting this link. `88:88` is a special time that means "infinite" |
| Repulsion | `!h:mm` | After finishing activity, link won't be selected for this time |
| Global repulsion | `Rh:mm` | After finishing this activity, no NPC will select this link for this time |
| quest tag | `#tagName` or `#!tagName` | Link must be explicitly activated by Schedule concept node |
| buff | `+buffTag` | NPC must have a buff with this AI tag |
| angriness | `%value` or `%<value` | angriness must be higher (or lower) than given value |
| minNPC | `>N` | If less than this number of NPCs are doing some activity on target hub, this link will be soft-prioritized |
| maxNPC | `<N` | If N or more NPCs are doing some activity on target hub, this link will be invalid |
| social class | `$socialClass` | Only ncps with given social class will be able to use this link |
| once | `!once` | Link will be invalid, if it was the last activity NPC did |
| halt | `!halt` | if any of this links parameters becomes invalid at any point, activity end immediatelly |
| override | `!override` | behavior will be called from this links target. Search will continue, and the next found behavior will be used as "resource" |
| urgency | `!slow`, `!fast`, `!instant` | If this link becomes valid, NPC will immediatelly try to switch to this activity (assuming this activity has higher priority than previous activity). Action search will use Fast or Instant urgency |
| privilege | `!priv` | If the behavior pointed to is used by other NPC, that NPC will be kicked out |
| sun | `!sun` | Only valid if it is sunny weather |
| rain | `!rain` | Only valid if it is raining |
| home | `!home` | as long as this link is valid, a Home AI link will be created along this link |
| corpse ignore | `!corpse` | this link can be used even if there are corpses around |
| fast forward | `!ff` | link is only valid if NPC is currently in Fast Forward mode |
| behavior name | `name` | This link ends search (unless !override is used), and NPC executes specified behavior on the target of this link |
