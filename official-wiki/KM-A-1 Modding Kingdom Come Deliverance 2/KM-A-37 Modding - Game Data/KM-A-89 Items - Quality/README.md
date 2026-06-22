# Items - Quality
Items (such as armours, weapons, clothes, shields) in the game have health (a value between 0 and 1) that affects it stats. The health is not directly visible in the game, but it can be calculated from the quality and condition of the item.

Weapons, armours and clothes have 4 qualities and the health is distributed among them in the following way:

| Quality | Lower bound | Upper bound |
| --- | --- | --- |
| 1 | 0 | 0.1 |
| 2 | 0.075 | 0.3 |
| 3 | 0.225 | 0.6 |
| 4 | 0.45 | 1 |

The 4th quality is the Henry's quality and it can be obtained only through crafting. Other items have 4 qualities only for consistency.

## Weapons

The health affects only the price and attack of the weapon in the following way:

`CurrentAttack = Attack*(sqrt(health)*WeaponStatusToAttackCoef+1-WeaponStatusToAttackCoef)`, where `WeaponStatusToAttackCoef` is an RPG constant currently set to 0.6

`CurrentPrice = Price*(health*ItemHealthPriceStatusWeight+1-ItemHealthPriceStatusWeight)`, where `ItemHealthPriceStatusWeight` is an RPG constant currently set to 0.99 (it has to be less than 1)

In the database all the values are stored for the item at its max health. Moreover, prices are stored in decigroschen (1 groschen = 10 decigroschen), so all the prices in the game are divided by 10 compared to the database.

## Armors

The health affects the defense stats, charisma and price of the armor in the following way:

`CurrentDefense = Defense*(sqrt(health)*ArmorStatusToDefenseCoef+1-ArmorStatusToDefenseCoef)`, where `ArmorStatusToDefenseCoef` is an RPG constant currently set to 0.6.

`CurrentCharisma = Charisma*(sqrt(health)*ArmorStatusToCharismaCoef+1-ArmorStatusToCharismaCoef)`, where `ArmorStatusToCharismaCoef` is an RPG constant currently set to 0.6

Armor price is calculated in the same way as weapon price.