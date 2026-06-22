# RPG Constants/Params
Use full width page layout for easier browsing
![](image.png)

Values exported 14/1/2025

| RPG Param | Help | Units | Value |
| --- | --- | --- | --- |
| AttackStamModMin | attack strength/power stamina modifier minimum (0stam-\>Xattack) | [-] | 0.5 |
| AttackRequiredStamRatio | actual/cost stamina ratio must be \> than this value for attack to be allowed | [-] | 0 |
| BaseAttackStaminaCost | how much stamina will attack cost | [stamina] | 26 |
| MaxStatToAttackStaminaCostMult | max stamina cost mult for a low stat | [-] | 2 |
| MinStatToAttackStaminaCostMult | min stamina cost mult for a high stat | [-] | 0.8 |
| MaxStatToAttackStaminaCostStatDiff | stat difference for max/min cost multiplier | [stat] | 10 |
| BaseDodgeStaminaCost | how much stamina will dodge cost | [stamina] | 20 |
| DodgeRelArmorLoadThreshold | relative armor load threshold for dodge distance computation | [-] | 0.62 |
| DodgeRelDistanceThreshold | relative distance threshold refering to DodgeRelArmorLoadThreshold | [-] | 0.7 |
| HeavyWeaponWeight | used to deduce 'attack weight' | [lb] | 99 |
| StrToEqwArmorLoad | maximal gain on level cap, GDD: 17/218 | [-] | 40 |
| AgiToEqwArmorLoad | maximal gain on level cap, GDD: 17/218 | [-] | 40 |
| VitToEqwArmorLoad | maximal gain on level cap, GDD: 17/218 | [-] | 0 |
| ArmorLoadDiffToMax | GDD: 17/218 | [-] | 60 |
| MaxArmorLoad | #ArmorLoad | [-] | 0.2 |
| HeavyLightArmorThreshold | should be between -MaxArmorLoad and MaxArmorLoad. #ArmorLoad | [-] | 0.05 |
| AttackSpeedPlayerRelative | 1 - attack speed is always calculated using the player, 0 - using opponents skill | [-] | 1 |
| AttackSpeedNormal | normal attack speed, 0-min, 1-max | [-] | 0.5 |
| AttackSpeedNormalAgi | agility required for the normal attack speed | [agi] | 5 |
| MaxAttackSpeedMod | maximal relative change in the attack speed for NPC vs player | [-] | 0.2 |
| MaxAttackSpeedPlayerMod | maximal relative change in the attack speed for player vs NPC | [-] | 0.25 |
| MaxAttackSpeedNpcVsNpcMod | maximal relative change in the attack speed for NPC vs NPC | [-] | 0.1 |
| AgiDiffToAttackSpeed | relative attak speed gain for one agi level difference | [speed/agi] | 0.1 |
| SkillDiffToAttackSpeed | relative attak speed gain for one skill level difference | [speed/skill] | 0.05 |
| WeaponStatusToAttackCoef | weapon health to status multiplicative coef | [-] | 0.6 |
| ArmorStatusToDefenseCoef | health to armor defense multiplicative coef | [-] | 0.6 |
| ArmorStatusToCharismaCoef | health to armor defense multiplicative coef | [-] | 0.6 |
| ArmorDirtToCharismaCoef | health to armor defense multiplicative coef | [-] | 0.8 |
| AttSkillToHorsePullDown | relative attacker skill to horse pull down | [-] | 0.5 |
| AttStrengthToHorsePullDown | relative attacker stat to horse pull down | [-] | 0.5 |
| RiderSkillToHorsePullDown | relative riding skill skill to horse pull down | [-] | 0.5 |
| RiderAgilityToHorsePullDown | relative rider agility to horse pull down | [-] | 0.5 |
| HorseMaxAttackCoef | [1,inf) maximal multiplicative coef a rider will gain when attacking on HorseMaxAttackSpeed | [-] | 2.5 |
| HorseAttackMaxSpeed | speed of the attacking rider to gain maximal attack bonus | [m/s] | 7 |
| HorseridingSkillXPForKillFromHorseback | Amount XP to horseriding gained for killing opponent from horseback | [xp] | 30 |
| CombatLevelMinToCombatRPGBonus | starting combat level for bonus in attack and health hit, KCD2-492146 | [-] | 0.3 |
| CombatLevelToRelativeAttackIncrease | relative attack increase for max combat level, KCD2-492146 | [-] | 0.35 |
| CombatLevelToRelativeHealthLossDecrease | relative health hit decrease for max combat level, KCD2-492146 | [-] | 0.35 |
| SkillXPLevelBase | base value (additive) to calculate XPs needed for the next level #level | [-] | 25 |
| SkillXPLevelDiff | multiplicative value to calculate XPs needed #level | [-] | 35 |
| SkillCap | max skill level, also effects of a general skill are maximal at this level | [skill] | 30 |
| SkillXPHit | weapon XP gain after a hit | [-] | 3 |
| SkillXPComboHit | weapon XP gain after a hit in a combo | [-] | 4 |
| SkillXPKill | weapon XP gain after a kill see GDD: 42/218 | [-] | 20 |
| SkillXPBlock | XP gain after a successful block | [-] | 0.5 |
| SkillXPPerfectBlock | XP gain after a successful perfect block | [-] | 2.5 |
| SkillXPRiposte | successful riposte (attack after perfect block) | [-] | 4 |
| SkillXPDrinkAlcohol | XP gain per 1 alcohol content drinked | [-] | 2.5 |
| SkillXPUseRepairKit | XP gain per 1 health repaired by repairkit | [-] | 1.5 |
| SkillToFencingBase | a1 of the geometric progression | [-] | 0.8 |
| MinStatToAttackMult | minimal relative attack multiplier (for a low stat) | [-] | 0.5 |
| MaxStatToAttackMult | maximal relative attack multiplier (for a high stat) | [-] | 1.1 |
| MaxStatToAttackStatDiff | stat difference for max/min relative attack multiplier | [stat] | 10 |
| SkillToDmgConstA |  | [-] | 250 |
| SkillToDefense | GDD: 23/218 | [-] | 0.0285714 |
| SkillToPerfectBlockPowTo | slot = relativeSkill ^ this, see GDD: #defense | [-] | 0.5 |
| MinPerfectBlockSlot01 | the smallest PB slot for the lowest level | [-] | 0.3 |
| StatsToDodgePowTo | slot = relativeStats ^ this, see GDD: #defense | [-] | 0.5 |
| BigZoneDistanceSlotMod | temporary solution, slot mod for distance \> 1 | [-] | 0.8 |
| MaxPerfectBlockSlotModifier | modifier of PB slot window - determined as (t_hit - t_pbslot) from attack \* this value. | [%] | 0.85 |
| MaxSpecialPerfectBlockSlotModifier | modifier of SPB slot window - determined as (t_hit - t_pbslot) from attack x this value. | [%] | 0.85 |
| AgilityXPLevelBase | see GDD 44/218 | [-] | 25 |
| AgilityXPLevelDiff | see GDD 44/218 | [-] | 40 |
| StrengthXPLevelBase | see GDD 44/218 | [-] | 25 |
| StrengthXPLevelDiff | see GDD 44/218 | [-] | 40 |
| VitalityXPLevelBase | see GDD 44/218 | [-] | 25 |
| VitalityXPLevelDiff | see GDD 44/218 | [-] | 35 |
| SpeechXPLevelBase | see GDD 44/218 | [-] | 25 |
| SpeechXPLevelDiff | see GDD 44/218 | [-] | 40 |
| StoryProgressXPLevelBase | see GDD 44/218 | [-] | 20 |
| StoryProgressXPLevelDiff | see GDD 44/218 | [-] | 30 |
| PrestigeXPLevelBase | see GDD 44/218 | [-] | 20 |
| PrestigeXPLevelDiff | see GDD 44/218 | [-] | 30 |
| StatCap | max stat level | [stat] | 30 |
| StatToMainLevelBase | a1 of the geometric progression | [-] | 0.5 |
| StatXPHit | xp gain after a hit | [-] | 2 |
| StatXPComboHit | xp gain after a hit | [-] | 6 |
| StatXPKill | xp gain after a kill | [-] | 12 |
| StatXPAgilityPerDodge | xp gain after a slot dodge to agility | [-] | 10 |
| StatXPAgilityPerDodgeOutsideSlot | xp gain after dodge outside slot to agility | [-] | 0 |
| StatXPVitalityPerDodge | xp gain after a each dodge to vitality | [-] | 3 |
| StatXPSpeechPerSequence | speech xp gain after selecting an unused sequence (multiplied by speech_coef of that sequence) | [-] | 1 |
| StatXPSpeechPersuadeCoerceSuccessMax | maximal xp gain for persuade success | [xp] | 40 |
| StatXPSpeechSkillCheckSuccessMax | maximal xp gain for a non persuade skillcheck success | [xp] | 25 |
| StatXPSpeechSkillStatSkillCheckSuccessMax | maximal xp gain for a skill or stat skillcheck success | [xp] | 18 |
| StatXPSpeechSkillCheckFailMax | maximal xp gain for a skillcheck fail | [xp] | 12.5 |
| StatXPSpeechSkillStatSkillCheckFailMax | maximal xp gain for a skill or stat skillcheck fail | [xp] | 9 |
| SkillXPSkillCheckSuccess | skill xp gain for a skillcheck success | [xp] | 3 |
| SkillXPSkillCheckFail | skill xp gain for a skillcheck fail | [xp] | 1 |
| GeneralPropertyDiffToSkillCheckResult | \> 0; scaled soul property diff for result = -1/1 | [] | 0.25 |
| MajorSuccessSkillCheckLevel | everything above this level from the given range is considered a Major Success | [] | 0.75 |
| SuccessSkillCheckLevel | everything above this level from the given range is considered a Success | [] | 0.5 |
| MajorFailSkillCheckLevel | everything below this level from the given range is considered a Major Fail | [] | 0.25 |
| BadassnessDifficultyModifier | convert general difficulty to badassness range | [] | 0.1 |
| SkillcheckReputationPenalty | If below this reputation the skillcheck will be harder | [] | 0.5 |
| PersuadeSkillcheckSpeechWeight | Weight of speech in persuade skillcheck | [] | 0.8 |
| CoerceSkillcheckSpeechWeight | Weight of speech in coerce skillcheck | [] | 0.8 |
| ImpressSkillcheckSpeechWeight | Weight of speech in impress skillcheck | [] | 0.2 |
| DominateSkillcheckSpeechWeight | Weight of speech in dominate skillcheck | [] | 0.2 |
| DreadSkillcheckBloodinessWeight | Weight of bloodiness in dread skillcheck | [] | 0.15 |
| DreadSkillcheckDirtinessWeight | Weight of dirtiness in dread skillcheck | [] | 0.1 |
| EasyDifficultySkillcheckOpponentValue | Value of the opponent's skillcheck for which the skillcheck is considered easy in UI | [] | 11 |
| MediumDifficultySkillcheckOpponentValue | Value of the opponent's skillcheck for which the skillcheck is considered moderate in UI | [] | 17 |
| HardDifficultySkillcheckOpponentValue | Value of the opponent's skillcheck for which the skillcheck is considered hard in UI | [] | 24 |
| ResetPublicFriendsRelationshipMin | minimal relationship for the alied forces after reset | [] | 0.35 |
| ResetNearbyRelationshipRange | range for relationship reset | [] | 50 |
| RelationshipToImpressCharisma | [0,inf]: how much is the repuation used to raise charisma | [] | 0.4 |
| RelationshipToPersuadeSpeech | [0,inf]: how much is the repuation used to raise speech | [] | 0.4 |
| RelationshipToThreatenBadassness | [0,inf]: how much is the repuation used to raise badassness | [] | 0.4 |
| RelationshipToGeneralSkillCheck | [0,inf]: how much is the repuation used to raise a general skill | [] | 0.4 |
| ThreatenStrenghtWeight | [0,1]: 0 - full weight to morale; 1- full weight to strength | [] | 0.5 |
| HighbornWealthThreshold | social class wealth threshold for perks | [] | 10 |
| StatXPVitalityPerKill | vitality xp gain after a kill | [-] | 10 |
| StatXPVitalityPerDistance | vitality xp gain after sprinting AthleticXPAwardDistance | [-] | 6.39844 |
| HorseRidingXPPerDistance | horse riding xp gain after riding HorseRidingAwardDistance | [-] | 15 |
| StatXPVitalityPerJump | vitality xp gain for each jump | [-] | 1.5 |
| StatXPStrAndVitPerDistanceEncumbered | Strength and vitality xp gain after walking EncumberanceXPAwardDistance meters while encumbered | [-] | 8 |
| SecondaryStatXPRatio | secondary weapon stat ratio | [-] | 1 |
| StatXPVitalityPerVault | vitality xp gain for each vault over a ledge | [-] | 2 |
| HoundmasterXPHit | dog companion master xp gain | [xp] | 45 |
| HoundmasterXPKill | dog companion master xp gain | [xp] | 300 |
| HoundmasterXPAnimalKill | dog companion master xp gain | [xp] | 120 |
| HoundmasterXPFeed | dog companion master xp gain | [xp] | 39 |
| HoundmasterXPPOIDiscovery | dog companion master xp gain | [xp] | 150 |
| HoundmasterXPPlay | dog companion master xp gain | [xp] | 0 |
| HoundmasterXPContextCommand | dog companion master xp gain | [xp] | 15 |
| HoundmasterXPFetch | dog companion master xp gain | [xp] | 60 |
| HoundmasterXPDistraction | dog companion master xp gain | [xp] | 90 |
| HoundmasterXPPraise | dog companion master xp gain | [xp] | 30 |
| SprintCost | stam cost of sprint | [stam/s] | 3.5 |
| SprintStaminaSavingLowerBound | When the NPC stops sprinting to conserve stamina | [stam] | 10 |
| SprintStaminaSavingUpperBound | When the NPC starts sprinting again after conserving stamina | [stam] | 80 |
| StamRegenBase | base regeneration speed | [stam/s] | 22 |
| StamRegenRelativeDiff | maximal relative difference to the base speed on low/high stamina | [-] | 0.666667 |
| StamRegenBlockMod | relative stam regen speed during active block or raised weapon | [-] | 0.6 |
| StamRegenMoveMod | relative stam regen speed during movement | [-] | 0.75 |
| StamRegenFromVit | how our VIT stat affects stamina regeneration | [-] | 0.8 |
| MaxAgilityToMovementSpeedAddition | max positive addition (for maximal vit), the same amount is subtracted on level 0 | [-] | 0.15 |
| HorseRidingToHorseStamina | how the rider's horse riding skill lowers sta consumption of his horse on max skill level | [sta/lvl] | 0.45 |
| HorseRidingToHorseCourage | how the rider's horse riding skill increases courage of his horse | [sta/lvl] | 0.01 |
| RiderThreatToHorseMorale | morale decrease per one rider threat | [mor] | 0.1 |
| HorseMoraleToThrowOffRider | if the horse mor is below this, it throws off the rider | [mor] | 0.01 |
| HorseMoraleOverspurrHitAmount | Morale hit for each horse overspurr. | [mor] | \-0.1 |
| HorseForcedRearMoraleHitRange | Range of moral hit to nearby enemies, when you force rear on your horse. | [m] | 8 |
| HorseDashBufferLength | Maximum length of the horse's dash buffer. | [s] | 21 |
| HorseSpurDashIncrement | How much will rider's horse dash buffer increase per one spur. | [s] | 7 |
| HorseSlowdownTimeSlowSpeed | How long does it take forthe horse to start slowing down from run or walk if we do not hold any key. | [s] | 0.5 |
| HorseSlowdownTimeSprint | How long does it take for the horse to start slowing down from sprint if we do not hold any key. | [s] | 1 |
| HorseSlowdownTimeSprintIfDashed | How long does it take for the horse to start slowing down from sprint if it dashed previously. | [s] | 2 |
| HorseSlowSpeedStaminaRegen | The additional stamina that player's horse should regenerate in speeds smaller than sprint. | [sta/s] | 1 |
| HorseStaminaDrainPerSpurLevel | How much stamina the horse should lose per each exceeded level of spur. | [sta/s] | 4 |
| HorseSpurDebuffLength | How long does the overspur debuff remain active. | [s] | 5 |
| HorseDashSlowdownThreshold | The horse will start slowing down (from dash to sprint) if the dash buffer drops below this value. | [s] | 1 |
| HorseMagnetismTurnSlowdown | This is how much the horse's speed decreases during sharp turns when the road magnetizer is on. | [%] | 0.5 |
| HorseJumpHeightModifier | Horse Jump Height = wh_horse_JumpHeight \* (vitality/30 + 1) \* this. | [-] | 0 |
| RiderHorseStaminaCoef | the ratio between stamina consumption of a horse and its rider | [-] | 0.75 |
| HorseMountMaxRelativeEncumberance | maximum allowed relative encumberance for player mounting a horse | [%] | 1 |
| HorseForcedRearingStaminaCost | stamina cost taken by forced rearing | [-] | 100 |
| RiderForcedRearingStaminaCost | stamina cost taken by forced rearing | [-] | 30 |
| RunSpeedBaseGuiMin | Minimum value in transformation function of run speed to GUI | [-] | 0.6 |
| RunSpeedBaseGuiMax | Maximum value in transformation function of run speed to GUI | [-] | 1.1 |
| RunSpeedBaseGuiMinHorse | Minimum value in transformation function of run speed to GUI for horse | [-] | 0.847 |
| RunSpeedBaseGuiMaxHorse | Maximum value in transformation function of run speed to GUI for horse | [-] | 0.951 |
| CallActionCooldown | Minimum time until horse call action / stealth lure can be activated again | [s] | 1 |
| ArmorLoadToSprint | how armor load coefficient affects sprint | [-] | 1 |
| ArmorLoadToRun | how armor load coefficient affects running speed | [-] | 0.5 |
| JumpCostBase | stamina cost of one jump | [-] | 9 |
| ArmorLoadToJumpCost | how armor load coefficient affects the stamina jump cost (times base) | [-] | 1.8 |
| EncumberedToSpeedSurfaceCoef | Coef that controls terrain/surface influence in encumbered speed mod #encumbered | [-] | 0.3 |
| EncumberanceForSecondaryModifiers | when the buff will activate the secondary group | [-] | 0.5 |
| SurfaceToSpeedCoef | Global multiplier used when applying surface speed multipler | [-] | 1 |
| AgilityLevelForNonClumsyLedges | Minimal agility required for normal (non-clumsy) ledges | [-] | 0.5 |
| GoodWeaponDefense | mainly for AI, used to judge weapon | [defense] | 300 |
| GoodWeaponDefenseCoef | block prob modifier when victim has good weapon defense | [defense] | 1.4 |
| GoodWeaponAttack | mainly for AI, used to judge weapon | [attack] | 90 |
| GoodArmorDefense | mainly for AI, used to judge armor | [defense] | 100 |
| MaxDamage | all stam and health damages are clamped | [-] | 200 |
| MinDmgR | min DmgR | [-] | \-100 |
| BlockingDmgRBonus | bonus for blocking weapon when dmgr is \> 0 | [-] | 2 |
| BlockingDmgRCoef | dmgr coefficient for blocking weapon | [-] | 0.4 |
| MinStaminaDamage | min stamina damage | [-] | 15 |
| MaxStaminaDamage | max stamina damage | [-] | 40 |
| MinStaminaDmgR | min DmgR for stamina | [-] | \-50 |
| MaxStaminaDmgR | max DmgR for stamina | [-] | 80 |
| LethalDmgR | DmgR that is known to cause death | [-] | 300 |
| StamDamage | see: rpglib::calcStaminaDamageCost, GDD: 21/218 | [-] | 8 |
| AverageArmorDefenseWeight | 0 = only body part defense, 1 = only average defense | [-] | 0.25 |
| UnarmedHitArmorDamageCoef | relative to armed combat | \- | 0.25 |
| WeakBlockStamCoef | see: rpglib::calcStaminaDamageCost, GDD: 21/218 | [-] | 2 |
| HealthToKnockOut | threshold for unarmed combat, health cannot reach this level | [hp] | 0 |
| DmgRToHealthCoefA |  | [-] | 7 |
| DmgRToHealthCoefB |  | [-] | 0.05 |
| StaminaDeficitHealthDamageA | HP damage caused by insufficent stamina (DmgR \> 0) | [-] | 0.05 |
| StaminaDeficitHealthDamageB | HP damage caused by insufficent stamina (DmgR \< 0) | [-] | 0.075 |
| MaxFencingWeaponUsageMod | relative weapon status damage for max fencing | [-] | 0.2 |
| ArmorDefenseToAttackingWeaponStatus | how opponet's defense value damages my weapon - hit to armor | [status/defense] | 0.002 |
| WeaponDefenseToAttackingWeaponStatus | how opponet's defense value damages my weapon - hit to weapon/block | [status/defense] | 0.001 |
| MissileWeaponDamageStatus | how missile weapon is damaged after each shot | [status] | 0.1 |
| DamageToArmorStatusHigherLayers | for layers above the stopping layer | [status/damage] | 0.375 |
| DamageToArmorStatus | for the stopping layer | [status/damage] | 0.3 |
| DamageToArmorStatusLowerLayers | for layers below the stopping layer | [status/damage] | 0.0075 |
| DamageToArmorStatusMinimalValue | minimal normalized Dmgr value for damage to armor calculations | [-] | 0.5 |
| AttackEnergyModifier | #energie utoku | [-] | 2 |
| StaminaDamageToInjury | note: stamina is [0-100] but injury is [0-1] | [/%] | 0 |
| HealthDamageToInjury | note: health is [0-100] but injury is [0-1] | [/%] | 0.02 |
| HealthDeltaAbsLimit | abs max of health delta | [hp/s] | 1000 |
| CollisionVelocityDeltaToDmgR |  | [attack/ms-1] | 0.25 |
| CollisionDmgRBias | DmgR offset for collision hits. | \- | 1 |
| UnarmedBlockDefense | defense value for unarmed block | [] | 3 |
| UnarmedAttackReqStrBase | for attack with relative stam cost = 1 | [] | 2 |
| UnarmedAttackReqAgiBase | for attack with relative stam cost = 1 | [] | 1 |
| CombatDangerCooldown | how long is the combat danger active after last enemy stops to be a threat | [s] | 0.5 |
| CombatDmgRBonusFromBehind | multiplicative DmgR bohus for attacks from behind | [-] | 1.2 |
| FromBehindAngle | minimal angle to classify the attack as 'from behind' - 0 face, PI back | [rad] | 2.35619 |
| HeadHitKnockOutBaseProbability | for hits dealing a hp damage | [] | 0 |
| FallDamageMultiplierAtMaxAgility | fall damage multiplier when agility is maxed out | [-] | 0.666667 |
| HarmlessFallHeight | falling height below which no health or stamina damage is taken at agility 0 | [m] | 1.5 |
| InjuringFallHeight | falling height above which health damage is taken at agility 0 | [m] | 2.2 |
| FatalFallHeight | falling height above which fatal health damage is taken at agility 0 | [m] | 8 |
| FallDamageEnabledNpcCombatCooldown | how long after combat with player NPC has enabled fall damage | [s] | 60 |
| StaminaDrainRatioStriking | ratio of AttackCost when striking begun (weapon raised is complement) | [%] | 0.7 |
| StaminaDrainRatioCharging | ratio of AttackCost when charging | [%] | 0.5 |
| AttackChargingBeginCooldown | cooldown before actual charging is started | [s] | 0.2 |
| AttackChargingCooldown | cooldown of charging to maximum value | [s] | 1.4 |
| AttackChargingAttMod | damage modification in maximum charge | [%] | 0.1 |
| SurvivalSkillAttackToAnimalOnMaxLevel | attack modifier to animals on maximum survival skill level | [] | 0.6 |
| HealthFull | maximum health | [%] | 100 |
| ImmortalHealthMin | min health for immortal souls | [%] | 1 |
| LowHealthThreshold | threshold for low health effects (for npcs) | [%] | 40 |
| DefaultWorldTimeRatio | default world time ratio useed to calculate game time ration in superspeed skiptime | [-] | 15 |
| DawnTime | Time when night ends, used by rpg (default 05:00) | [h] | 4.7 |
| DuskTime | Time when night begins, used by rpg (default 21:00) | [h] | 21.3 |
| NightTransitionPeriod | Symmetric offset to dusk / dawn time. | [h] | 2.6 |
| FoodHealthThreshold | Health threshold for possitive/negative food effect | [0-1] | 0.2 |
| FoodFull | you are full | [%] | 100 |
| FoodOverEat | you cannot eat more | [%] | 150 |
| CaffeineFromFoodCoef | how much caffeine is added from a unit refresh | [caf/exh] | 2 |
| FoodSaltOrSmokePerkDecayModif | food decay perk modif | [mod] | 0.75 |
| FoodPreserverHealthIncreaseAmount | this amount is added to food's health when food preserver is applied | [-] | 0.5 |
| FoodWitcherPerkNutritionModif | potion nutrition wicher perk modif | [mod] | 0.7 |
| MaxAggregatedItemAmountPerPoison | maximum number of aggregated items affected when applying a single poison | [mod] | 5 |
| FoodDecayModif | food decay modif | [mod] | 1 |
| DigestionSpeed | amount of food 'lost' per world-time second (global base value) | [%/s] | 0.000578704 |
| ShortTermNutritionDigestionSpeedMultiplier | digestion multiplier for part of the food with low nutrition value | [-] | 5 |
| SurvivalXpRewardPerCookedItem | XP reward to survival skill for every cooked item | [xp] | 1 |
| SurvivalXpRewardPerDriedItem | XP reward to survival skill for every dried item | [xp] | 0.5 |
| SurvivalXpRewardPerSmokedItem | XP reward to survival skill for every smoked item | [xp] | 3 |
| MetabolismDigestSpeed | food/alcohol digested(added) in world time | [s] | 0.0244 |
| MetabolismDigestSpeedMultiplier | accelerate digest speed multiplier to_digest = max_poisoning | [] | 1.5 |
| MetabolismAbsorbSpeed | food/alcohol metabolised(removed) in world time | [s] | 0.003 |
| FoodPoisoningMaxValue | Max amount of food poisoning | [foodPoisoning] | 100 |
| FoodPoisoningThreshold | threshold for food posioning to start taking affecting | [foodPoisoning] | 0.0005 |
| FoodPoisoningMinHealthEffectSpeed | minimum loose of health per sec for food poisoning | [health/s] | 0.1 |
| FoodPoisoningMaxHealthEffectSpeed | Maximum loose of health per sec for food poisoning | [health/s] | 0.5 |
| FoodPoisoningMaxStatPenalty | maximum temporary penalty for affected stats while food poisoning | [stats penalty] | 10 |
| AlcoholBlackoutThresholdBase | Amount of alcohol needed to blackout = AlcoholBlackoutThresholdBase + drinking skill x AlcoholBlackoutThresholdSkillMultiplier | [alcohol] | 32 |
| AlcoholBlackoutThresholdSkillMultiplier | Amount of alcohol needed to blackout = AlcoholBlackoutThresholdBase + drinking skill x AlcoholBlackoutThresholdSkillMultiplier | [coeff] | 2 |
| AlcoholMoodThreshold | threshold for alcohol mood from max alcohol poisoning | [coef] | 0.0001 |
| AlcoholDrunkThreshold | threshold for drunkenness mood from max alcohol poisoning | [coeff] | 0.32 |
| AlcoholDrunkThresholdNPC | threshold for drunkenness for NPCs | [coeff] | 0.5 |
| AlcoholMaxSTREffect | max negative/positive stat effect | [stat] | 4 |
| AlcoholMaxAGIEffect | max negative/positive stat effect | [stat] | 2 |
| AlcoholMaxVITEffect | max negative/positive stat effect | [stat] | 4 |
| AlcoholMaxSPCEffect | max negative/positive stat effect | [stat] | 4 |
| AlcoholMaxCHAEffect | max negative/positive stat effect | [stat] | 4 |
| AlcoholMaxCONEffect | max negative/positive stat effect | [stat] | 3 |
| AlcoholMoodMaxExhaustPossitiveEffect | max positive exhaust effect while in mood | [stat/s] | 0.0002 |
| AlcoholDrunkMaxExhaustNegativeEffect | max negative exhaust effect while drunk | [stat/s] | 0.005 |
| AlcoholBlackoutDuration | blackout unconscious duration | [s] | 14400 |
| AlcoholBaseHangoverDuration | base max duration for hangover (after blackout) in world time | [s] | 80000 |
| AlcoholHangoverOffsetModif | starting hangover negative effects are modified by this offset | [coeff] | 1.1 |
| AlcoholMaxDrinkingSkillHangoverDurationModifier | hangover duration modifier for max=best drinking skill | [-] | 0.05 |
| AlcoholDigestSpeedModfifOnEmptyStomache | multiplier for alc. digest speed on empty stomache | [coeff] | 2 |
| AlcoholDigestSpeedModfifOnFullStomache | multiplier for alc. digest speed on full stomache | [coeff] | 0.5 |
| AlcoholContentFPAntidoteThreshold | food with alcohol content above this threashold have anti food poisoning effect. | [alcohol] | 60 |
| AlcoholMoodToDrunkUIFill | Drunkenness changes from Mood to Drunk at 50, but we want to visually fill from 0 -\> for the first AlcoholMoodToDrunkUIFill s, show only a portion of the real value, gradually increasing to the full value. | [s] | 13 |
| AlcoholismLevel1 | Amount of alcoholism points that will start addiction. | [alcohol] | 300 |
| AlcoholismLevel2 | Threshold of alcoholism points for second level of alcohol addiction. | [alcohol] | 450 |
| AlcoholismLevel3 | Threshold of alcoholism points for third level of alcohol addiction. | [alcohol] | 550 |
| AlcoholismLevel4 | Threshold of alcoholism points for fourth level of alcohol addiction. | [alcohol] | 700 |
| AlcoholismLevel5 | Threshold of alcoholism points for fifth level of alcohol addiction. | [alcohol] | 800 |
| AlcoholismLevel6 | Threshold of alcoholism points for sixth level of alcohol addiction. | [alcohol] | 900 |
| AlcoholismRemoveSpeed | alcoholism removed per world-time second (default 100 / 4days) | [alcoholism/s] | 0.001 |
| AlcoholismCravingLevel1 | After a level 1 alcoholic has a drink, this many seconds pass until they get a debuff (need another drink). Game time. | [s] | 3600 |
| AlcoholismCravingLevel6 | Like AlcoholismCravingLevel1, but for level 6. Remaining levels are linearly interpolated. Game time. | [s] | 600 |
| AlcoholUnconsciousRandomItemChance | Chance that a player will get a random item when waking up from alcohol-induced unconsciousness | [%] | 0.3 |
| AlcoholUnconsciousRandomItemIsGoodChance | Chance that a item obtained from alcohol-induced unconsciousness will be from the set of good items. | [%] | 0.3 |
| AlcoholUnconsciousAddedDirt | Dirt added to someone who passed-out from alcohol. | [%] | 0.3 |
| AlcoholPerkBacchusHangoverEffectMod | hangover effects mod | [] | 1.3 |
| AlcoholPerkCorrectResistanceModif | alcohol content modif for correct resistance | [] | 0.5 |
| AlcoholPerkWrongResistanceModif | alcohol content modif for wrong resistance | [] | 2 |
| AlcoholPerkLooseTongueSpcCha | speech and charisma bonus/malus for loose tongue perk | [] | 1 |
| EventViewRadiusWeightVariantVsPlace | event view radius (EVR) is [this weight x variant VR + (1-weight) x place VR]. must be \<0-1\> | [] | 0.5 |
| EventConcealWeightRadiusVsVisibility | event concealment (how easily event detects player) is [this weight x EVR + (1-weight) x player's visibility]. must be \<0-1\> | [] | 0.5 |
| FTRadiusWeightViewRadiusVsSurvival | view radius of player during fast travel (how easily player detects event) is [this weight x PVR + (1-weight) x player's survival]. must be \<0-1\> | [] | 0.5 |
| EventEvadeWeightVisibility | weight V for computing event evade chance = V\*(1-visibility) + s*survival + e*eventDetectionResult / (V+s+e) | [] | 1 |
| EventEvadeWeightSurvival | weight S for computing event evade chance = v\*(1-visibility) + S*survival + e*eventDetectionResult / (v+S+e) | [] | 1 |
| EventEvadeWeightDetectionResult | weight E for computing event evade chance = v\*(1-visibility) + s*survival + E*eventDetectionResult / (v+s+E) | [] | 1 |
| EventAmbushWeightVisibility | weight V for computing event ambush chance = V\*(1-visibility)  + s*stealth + e*eventDetectionResult / (V+s+e) | [] | 1 |
| EventAmbushWeightStealth | weight S for computing event ambush chance = v\*(1-visibility) + S*stealth + e*eventDetectionResult / (v+S+e) | [] | 1 |
| EventAmbushWeightDetectionResult | weight E for computing event ambush chance = s*stealth + v*(1-visibility) + E\*eventDetectionResult / (v+s+E) | [] | 1 |
| EventFleeWeightVitality | weight V for computing event flee chance = V*vitality + e*(1- | eventDetectionResult | ) / (V+e) |
| EventFleeWeightDetectionResult | weight E for computing event flee chance = v*vitality + E*(1- | eventDetectionResult | ) / (v+E) |
| MaxStabBuffApplyChance | chance to apply buff on stab when giving max hp damage | [-] | 999 |
| MaxSlashBuffApplyChance | chance to apply buff on slash when giving max hp damage | [-] | 999 |
| MaxSmashBuffApplyChance | chance to apply buff on smash when giving max hp damage | [-] | 999 |
| MinWeaponBuffCharge | max number of uses | [-] | 15 |
| MaxWeaponBuffCharge | max number of uses | [-] | 30 |
| MinRelativeStaminaMax | short-term stamina maximum relative to long-term maximum | [-] | 0.3 |
| VigourFull | maximum vigour | [%] | 100 |
| ExhaustionSpeed | amount of energy/vigour 'lost' per world-time second (global base value) | [%/s] | 0.000578704 |
| FoodHealSpeed | hp regen speed | [%/s] | 2 |
| StarvationHealthLossSpeed | by design the same speed as the digestion | [%/s] | 0.001 |
| StarvationThreshold |  | [%/s] | 50 |
| StarvationHugeThreshold |  | [%/s] | 25 |
| StarvationExtremeThreshold |  | [%/s] | 0 |
| BaseInventoryCapacity | base inventory capacity | [lb] | 90 |
| MaxBaseInventoryCapacity | Base maximum of inventory capacity without taking the archetype multiplier into account | [lb] | 600 |
| StrengthToInventoryCapacity | derives the inventory capacity from the strength stat | [lb/str] | 10 |
| InjuryLowThreshold | limb is considered healthy if below this treshold | [-] | 0.6 |
| InjuryHighThreshold | limb is bleeding if above this threshold | [-] | 0.8 |
| InjuryRegenInterval | injuries fade-out, the time required to regen 1% of injury | [s] | 20 |
| InjuryBleedingInterval | bleeding interval, the time required to lose 1HP | [s] | 6 |
| DefaultStateDeltaSpeed | any soul state regen / loosing speed | [%/s] | 1 |
| SleepHealthRegenBaseSpeed | full regen after 8 world-time hours | [%/s] | 0.00347222 |
| StarvationPlayerEffectMinMin | the shortest interval between effects for low hunger stat | [s] | 90 |
| StarvationPlayerEffectMaxMin | the longest interval between effects for low hunger stat | [s] | 120 |
| StarvationPlayerEffectMinMax | the shortest interval between effects for high hunger stat | [s] | 45 |
| StarvationPlayerEffectMaxMax | the longest interval between effects for high hunger stat | [s] | 75 |
| ExhaustedThreshold | player will have the 'exhausted' debuff when 'exhaust' stat is lower or equal to this value (in percents) | [%] | 50 |
| ExhaustedPlayerEffectMinMin | the shortest interval between effects for low exhaust stat | [s] | 10 |
| ExhaustedPlayerEffectMaxMin | the longest interval between effects for low exhaust stat | [s] | 30 |
| ExhaustedPlayerEffectMinMax | the shortest interval between effects for high exhaust stat | [s] | 30 |
| ExhaustedPlayerEffectMaxMax | the longest interval between effects for high exhaust stat | [s] | 60 |
| ExtremeExhaustionFaintAveragePeriod | How often (on average, in real time) should player faint when extremely exhausted (exhaust stat is on 0). | [s] | 300 |
| ExtremeExhaustionFaintDuration | Length of unconsciousness in seconds (world time), when player faints (due to having exhaust 0). | [s] | 3600 |
| MinHealthToBeAbleToSleepOrSkiptime | player will not be able to go sleep or skiptime if his health would go under this threshold during the sleep or skiptime | [%] | 30 |
| MinPossibleSleepTime | player will reject to lie into bed when he will not be able to sleep at least this long (due to bleeding/hunger/etc, in hours) | [h] | 1.001 |
| OversleepnessFillTime | how long (in game hours) does it take to fill the oversleepness stat (max time player can sleep) | [h] | 12 |
| OversleepnessEmptyTime | how long (in game hours) does it take to empty the oversleepness stat (time player have to be awake to be able to sleep max time again) | [h] | 12 |
| InactiveTimeToDestroyOversleep | how long to let inactive oversleep buff survive (in game seconds) (we have this threshold so that the buff will not be destroyed right after being created in SkipTime class) | [s] | 8 |
| OverreadnessFillTime | how long (in game hours) does it take to fill the oversleepness stat (max time player can read) | [h] | 8 |
| OverreadnessEmptyTime | how long (in game hours) does it take to empty the oversleepness stat (time player have to be not reading to be able to read max time again) | [h] | 16 |
| ReadingXpPerHour | how much xp in reading skill player gets after one hour of reading with reading speed 100% | [xp] | 30 |
| ReadingSpeechXPBase | how much base xp in speech player gets after reading a book | [xp] | 20 |
| ReadingSpeechXPScholarshipMultiplier | after reading a book, player gets speech xp based on scholarship | [xp] | 10 |
| SleepToSaveThreshold | sleeping at least this time triggers autosave. | [h] | 1 |
| SleepToAfterBuff | sleeping at least this time gives buff affter waking up. | [h] | 4 |
| AvidReaderReadingSpeed | AvidReader soul ability advances reading progress on one book in inventory during sleep or skiptime. This constant determines speed of reading (reading spot is always None). | [.] | 0.35 |
| ImprovedSleepMultiplier | How much better better (Rest regeneration speed) is SleepImproved than Sleep buff. This buff is used for reading when player has perk InTheFlow. | [.] | 2 |
| DefaultReadingQuality | Reading quality when doing nothing special (standing). | [.] | 0.5 |
| SkipTimeCacheValidityThreshold | duration for which the skip time cache remains valid | [] | 15 |
| SkipTimeCacheSize | size of skip time cache in skip time dialogue, default is 24 hours | [] | 24 |
| NonSkillBookXP | XP rewarded for reading non-skill books | [xp] | 30 |
| SmellBuffDirtinessLevel | Dirtiness level required to activate Smell buff | [-] | 0.8 |
| SpeechMulOnExtremeExhaustion | Player will have this speech multiplied by this value when he has exhaust equal to 0. Speech will not be changed when exhaust is 50. Linear interpolation on multiplier is applied when exhaust is between 0 and 50; | [%] | 0.75 |
| CharismaMulOnExtremeExhaustion | Player will have this charisma multiplied by this value when he has exhaust equal to 0. Charisma will not be changed when exhaust is 50. Linear interpolation on multiplier is applied when exhaust is between 0 and 50; | [%] | 0.75 |
| StrengthMulOnExtremeExhaustion | Player will have this strength multiplied by this value when he has exhaust equal to 0. Strength will not be changed when exhaust is 50. Linear interpolation on multiplier is applied when exhaust is between 0 and 50; | [%] | 0.75 |
| AgilityMulOnExtremeExhaustion | Player will have this agility multiplied by this value when he has exhaust equal to 0. Agility will not be changed when exhaust is 50. Linear interpolation on multiplier is applied when exhaust is between 0 and 50; | [%] | 0.75 |
| SharpeningMinEfficiencyHealth | health you can achieve with the worst efficiency | [-] | 0.3 |
| SharpeningSuccessfulConditionDelta | change in weapon condition at which the sharpening is considered successful | [-] | 0.01 |
| SharpeningMinIdealAngle | [0,1] | [stam] | 0.2 |
| SharpeningMaxIdealAngle | [0,1] | [stam] | 0.55 |
| SharpeningMinDestructionAngle | [0,1] | [stam] | 0.7 |
| SharpeningMaxDestructionAngle | [0,1] | [stam] | 0.99 |
| SharpeningWeaponBouncingMaxOffset | Maximum angle offset that is set to rotation of the weapon [0,1] | [-] | 0.029 |
| SharpeningZoneConditionForPerkEffects | At which item zone condition the perk effects are applied [0,1] | [-] | 0.98 |
| SharpeningFullPositiveHealthXP |  | [xp] | 125 |
| SharpeningFullNegativeHealthXP |  | [xp] | 15 |
| MinPedalCost | pedaling STA cost (pressure 0) | [stam] | 1 |
| MaxPedalCost | pedaling STA cost (pressure 1) | [stam] | 2 |
| HourglassTimeout | the time until all the sand goes down | [s] | 10 |
| PicklockDmgSpeed | how fast is picklock durability decreasing (will be multiplied by the relative distance) | [dmg/s] | 10 |
| LockPickingToleranceBaseCoef | lockpicking sweet spot size: base value | [-] | 0.55 |
| LockPickingToleranceDifficultyCoef | lockpicking sweet spot size: difficulty coefficient | [-] | 0.34 |
| LockPickingToleranceSkillCoef | lockpicking sweet spot size: skill coefficient | [-] | 0.49 |
| LockPickingToleranceSkillExpCoef | lockpicking sweet spot size: skill exponential coefficient | [-] | 0.06 |
| LockPickingAppropriateTolerance | the lock is considered too hard to pick, if the tolerance is smaller than this | [-] | 0.048 |
| LockPickingAdequateTolerance | locks on a similar level as the player have adequate tolerance | [-] | 0.17 |
| ControllerLockPickingToleranceBaseCoef | gamepad/controller: lockpicking sweet spot size: base value | [-] | 0.57 |
| ControllerLockPickingToleranceDifficultyCoef | gamepad/controller: lockpicking sweet spot size: difficulty coefficient | [-] | 0.32 |
| ControllerLockPickingToleranceSkillCoef | gamepad/controller: lockpicking sweet spot size: skill coefficient | [-] | 0.5 |
| ControllerLockPickingToleranceSkillExpCoef | gamepad/controller: lockpicking sweet spot size: skill exponential coefficient | [-] | 0.06 |
| ControllerLockPickingAppropriateTolerance | gamepad/controller: the lock is considered too hard to pick, if the tolerance is smaller than this | [-] | 0.062 |
| LockPickingCursorShakeSpeed | how fast does cursor shake during lock picking | [-] | 5.32 |
| LockPickingCursorShakeRangeMin | how much does cursor shake during lock picking (for min lock difficulty) | [-] | 0.08 |
| LockPickingCursorShakeRangeMax | how much does cursor shake during lock picking (for max lock difficulty) | [-] | 0.34 |
| LockPickingSkillToShakeRel | how much does the skill decrease the cursor shake (skill \* this is relative to maximum/base) | [xp^-1] | 0.028 |
| LockPickingSuccessXPMulCoef | multiplicative constant to derive XP reward for a successfully opened lock | [-] | 60 |
| LockPickingSuccessXPDivCoef | constant used in the denominator to derive XP reward for a successfully opened lock | [-] | 0.046875 |
| LockPickingStealthXP | xp to stealth for each successful lock-pick | [-] | 8 |
| LockPickingAgilityXP | xp to agility for each successful lock-pick | [-] | 8 |
| LockPickingTurnBackMulCoef | multiplicative constant to derive the turnback speed of a lock | [-] | 5 |
| LockPickingTurnBackDivCoef | constant used in the denominator to derive the turnback speed of a lock | [-] | 0.1 |
| LockpickingSoundIntensityMin | minimal multiplier the lockpicking minigame will generate | [-] | 0.3 |
| LockpickingRelDistanceToSoundIntensity | how relative distance influences sound | [inten/dist] | 0.5 |
| LockpickingFailSoundIntensity | one-shot intensity relative to the database | [inten] | 1 |
| LockpickingLockpickBreakChance | base lockpick break chance | [inten] | 1 |
| LockPickingFailRelativeXPMulCoef | multiplicative constant to derive XP reward relative to the success | [-] | 0.101562 |
| HerbGatherSkillToCount | multiplied by sqrt(skill level) to modify the number of collected herbs (#herb) | [xp^-1] | 0.25 |
| HerbGatherSkillToRadius | multiplied by skill level to calculate radius (#herb) | [m/xp] | 0.04 |
| HerbGatherSkillToRadiusAdd | modify the base radius of collected herbs at first skill level (#herb) | [m] | 0.4 |
| HerbGatherXP | final XP reward for one herb gathering(#herb) | [xp] | 5 |
| HunterLootAmountAddCoef | add coef, the fixed portion (#hunter) | [-] | 0.1 |
| HunterXPKill | hunter skill XP gain after a kill, multiplied by the game db coef and level | [xp] | 20 |
| HunterXPLoot | hunter skill XP gain after a loot, multiplied by the game db coef and level | [xp] | 8 |
| ButcheringMaxDistance | Butchering action is shown only when player is closer than this to the animal's bounding box. | [m] | 0.45 |
| MinAnimalWeightToWithstandGunshot | Animals that weigh less than this will be turned into bloody mess by gunshot and have a special inventory assigned instead of their regular loot inventory. | [lb] | 10 |
| AlchemyXPPerFailedBrewing | how many XP you get when failed brew a potion | [xp] | 5 |
| AlchemyXPMultiplierSecondQualityPotion | multiple the basic amount of XP for brewing potion of the second quality | [xp] | 1.35 |
| AlchemyXPMultiplierThirdQualityPotion | multiple the basic amount of XP for brewing potion of the third quality | [xp] | 2 |
| AlchemyToleranceBase | base brewing tolerance on level 0 | [-] | 0.2 |
| AlchemyToleranceMaxLevel | base brewing tolerance on max level | [-] | 0.7 |
| AlchemyRecipeStepsTolerance | how many recipe steps might fail in order to successfully brew the recipe | [-] | 4 |
| AlchemyTrialEndErrorPerkTolerance | Additional tolerance gained by having Train And Error perk. | [-] | 1 |
| AlchemyPotionBaseQualityWeight | How much the quality of the base is reflected in the result of cooking | [-] | 0 |
| AlchemyResourcesQualityWeight | How much the quality of the resources is reflected in the result of cooking | [-] | 0.2 |
| AlchemyResultCoefToFirstQuality | Minimum brew result coefficient to create the best possible quality potion | [-] | 0.9 |
| AlchemyResultCoefToSecondQuality | Minimum brew result coefficient to create the second best possible quality potion | [-] | 0.7 |
| AlchemyDryHerbQuality | Quality of dried herb used in alchemy cooking | [-] | 0.3 |
| AlchemyFreshHerbQuality | Quality of fresh herb used in alchemy cooking | [-] | 1 |
| AlchemyDecayedHerbQuality | Quality of decayed herb used in alchemy cooking | [-] | 0.01 |
| BundleAlchemistPerkAdd | Addition of potions created with Bundle Alchemist perk | [-] | 1 |
| HerbsInInventoryForFlowerPowerPerk | number of herbs in inventory needed for FlowerPower perk to be active (#herb) | [#] | 30 |
| HerbsInHorseInventoryForHorsenipPerk | number of herbs in horse inventory needed for Horsenip perk to be active (#herb) | [#] | 30 |
| EquippedWeightSubWithWellWornPerk | when player has Well Worn perk, weight of items is lowered when they are equipped; equippedWeight=standardWeight\*(1.0 - EquippedWeightSubWithWellWornPerk) | [.] | 0.333333 |
| MaxCloudAverageForShiningArmor | used by perk Knight in a shining armor; this is maximal current cloud average that still allows this perk to be active | [.] | 0.3 |
| MaxPerkPoints | total number of perk points player will gain per stat/skill | [-] | 13 |
| MinPerkPoints | no leftovers if the number of perk points would be \<= than this | [-] | 5 |
| MinLevelForPerkPoints | at what minimum level will perk points be earned | [-] | 6 |
| MinLeftoverPerks | preferred number of leftovers | [-] | 0 |
| AutolearnCombatTechniqueReliability | The probability that the soul will have the autolearnable combat technique perk | [-] | 0.8 |
| BlacksmithingMinIntensity | minimal intensity value | [-] | 0.5 |
| BlacksmithingMaxIntensity | maximal intensity value | [-] | 1.4 |
| BlacksmithingMinTemperature | minimal temperature for any effectiveness | [C] | 400 |
| BlacksmithingMaxTemperature | maximal temperature for max effectiveness | [C] | 1000 |
| BlacksmithingMinEffectivityToQualityLoss | min effectiveness for quality loss - loss is maximal | [-] | 0 |
| BlacksmithingMaxEffectivityToQualityLoss | max effectiveness for quality loss - loss is minimal | [-] | 0.9 |
| BlacksmithingMaxQualityLossFactor | maximal quality loss per stroke | BlacksmithingMinTemperature [-] | 0.017 |
| BlacksmithingMaxCompletionGainFactor | maximal completion gain per stroke | [-] | 0.02 |
| BlacksmithingIntensityToStamina | stroke intensity to stamina drain | [-] | 16 |
| BlacksmithingEffectivityToXP | effectiveness to XP gain | [-] | 0.75 |
| BlacksmithingStrokeGain | stroke gain to potential | [-] | 0.9 |
| BlacksmithingStrokeLoss | stroke loss to potential | [-] | 0.6 |
| BlacksmithingRhythmicBonus | percentual gain to effectivity when rhythmic bonus is active | [%] | 8 |
| BlacksmithingMinimalCover | minimal cover value when stroke is 100 percent effective | [%] | 0.2 |
| BlacksmithingAlmostCriticalQualityOffset | quality when workpiece is almost broken | \- | 0.1 |
| BlacksmithingOverheatQualityLossCoef | coef for quality loss during overheating effect | \- | 0.003 |
| BlacksmithingFinishingXP | XP gained after minigame was successfuly finished when quality is maximum | \- | 135 |
| BlacksmithingStamRegenMin | regen of stamina at minimal skill level | [-] | 0.5 |
| BlacksmithingStamRegenMax | regen of stamina at maximal skill level | [-] | 1.2 |
| BlacksmithingMinCondition | min condition of product | [-] | 0.1 |
| BlacksmithingMaxCondition | max condition of product | [-] | 0.8 |
| DiceGameTypeScoreBeggar | Beggar game type score | \- | 2000 |
| DiceGameTypeScoreWagoner | Wagoner game type score | \- | 4000 |
| DiceGameTypeScoreCraftsman | Craftsman game type score | \- | 6000 |
| DiceGameTypeScoreCourtier | Courtier game type score | \- | 8000 |
| DiceGameTypeScorePeasant | Peasant game type score | \- | 2000 |
| DiceGameTypeScoreMiner | Miner game type score | \- | 4000 |
| DiceGameTypeScoreNovice | Novice game type score | \- | 6000 |
| DiceGameTypeScoreSoldier | Soldier game type score | \- | 4000 |
| DiceGameTypeScorePriest | Priest game type score | \- | 6000 |
| DiceGameTypeScoreKnight | Knight game type score | \- | 6000 |
| DiceGameTypeScoreCardinal | Cardinal game type score | \- | 4000 |
| DiceGameTypeScoreLord | Lord game type score | \- | 6000 |
| DiceGameTypeScoreKing | King game type score | \- | 10000 |
| DiceGameTypeScoreEmperor | Emperror game type score | \- | 10000 |
| DiceAntibustHighThreshold | if this threshold is lower than currentScore or scoreRatio use antibust right away | \- | 0.75 |
| DiceDoubleTakeMultiplier | double take value by which score is multiplied | \- | 2 |
| DiceMultiplyingHighThreshold | if this threshold is lower than currentScore or scoreRatio use antibust right away | \- | 0.75 |
| DiceAvailableCountWeight | weight by which available count is devided in double take | \- | 30 |
| DiceBadgeUseThreshold | express in percentage how big should the gain be to use the set dice badge | \- | 0.5 |
| DiceSetDiceAbsoluteThreshold | Minimum score that has to be reached to use the set dice badge | \- | 300 |
| HoleDiggingDirtiness | Determines how dirty player will be after digging a hole/grave | \- | 0.45 |
| AimPainlessDelay | aiming without stam. loss | [s] | 2 |
| BowAimStamCost | after painless delay, stam loss | [%/s] | 20 |
| CrossbowAimStamCost | stam loss | [%/s] | 8 |
| RifleAimStamCost | stam loss | [%/s] | 5 |
| AimSpreadMinRatio | aiming spread min relative to max - this value is used right after entering the painless zone | [-] | 0.3 |
| AimSpreadMax | aiming spread due to low stam and skill - max angle - used right before all the stamina is lost | [deg] | 15 |
| AimSpreadSkillDecrease | relative decrease of MAX aim spread on max skill level | [-] | 1 |
| ForcedFireAimSpreadMalus | spread added when the rpg forces the firing on low stamina | [deg] | 7 |
| AimZoomBase | aim zoom (=fov decrease) after reaching some skill level | [deg] | 10 |
| AimZoomBaseSkill | minimal skill level required to benefit from the zoom effect | [] | 10 |
| AimZoomMax | maximal aim zoom (=fov decrease) | [deg] | 25 |
| AimSkillToZoom | zoom increase by each skill level above the base | [deg/skill] | 1.5 |
| AimCiriticalLimitTime | time limit after when AI is notified about low stamina when aiming | [s] | 0.75 |
| BowChargeDurationMin | minimum duration of bow charge animation | [s] | 1.2 |
| BowChargeDurationMax | maximum duration of bow charge animation | [s] | 2 |
| BowPowerToChargeDuration | nominal charge duration for bow with power = 1 | [s] | 0.05 |
| RangedWpnMinPowerCoef | the power coef for a really weak soul (the stats are far below requirements) | [-] | 0.1 |
| RangedWpnMinStrCoef | if the curr/req strength ratio goes below this, the power is minimal, GDD: 25/222 | [-] | 0.5 |
| RangedWpnPowerConstA | used to convert strength requirements to the resulting power, GDD: 25/222 | [-] | 1.85 |
| RangedWpnPwrToSpeed | total power to launch speed | [m/s] | 1 |
| RangedWpnPwrToEnergy | Coefficient weapon draw length to energy (lb-to-N (4.44) \* drawlength (50cm) / 2 (aproximates the loss of draw weight over draw length) ) | [-] | 1.2 |
| RangedWpnSpeedToAttack | attack mod deduced from impact speed | [s/m] | 0.021 |
| RangedWpnCosThetaToAttackMin | cos(theta) lieary lowers the attack in the range [this,1] | [-] | 0.7 |
| RangedWpnSelfHarmCoef | Special constant used in self harm equation. | [-] | 15 |
| RangedWpnOptimalDistanceToMinamal | ratio between the database attack distance and the minimal range for the AI | [-] | 0.5 |
| RangedWpnLimbResistanceEffect | Determines how much limb resistance affects arrow speed. No effect at zero. At 100, the formula becomes basically arrowWeight/limbResistance. | [-] | 0.8 |
| RangedWpnWeightNormalization | Average arrow weight, used to normalize damage. | [g] | 50 |
| RangedWpnRadiusForMoraleHit | Morale hit radius from gunshot fire. | [m] | 30 |
| SkillToRangedWpnAIRange | how the relative skill influences the weapon range for the AI | [-] | 0.5 |
| ProjectileMaxBreakProb | probability of breaking an arrow if a rock-solid material is hit | [] | 0.7 |
| MatPierceableMin | OBSOLETE: projectiles with stab damage can stab into | [] | 6 |
| MatPierceableMaxArmor | armor of a rock-solid material | [] | 200 |
| MatPierceableReduction | armor reduction per one point of piercability | [] | 16 |
| PerceptionMinFov | the minimal field of view a deaf NPC will have | [deg] | 90 |
| PerceptionMaxFov | the maximal field of view a superman NPC will have | [deg] | 100 |
| HearingToFov | an increase of FOV caused by the hea stat | [deg/hea] | 1 |
| MinViewRadius | the minimal view radius an almost blind NPC will have, also threshold for instant detection | [m] | 2.5 |
| MaxViewRadius | the maximal view radius a superman NPC will have | [m] | 50 |
| MinViewRadiusTimeOfDayCoef | Relative impact of night on view radius will not be worse than this. | [-] | 0.5 |
| MinViewRadiusFogCoef | Relative impact of fog on view radius will not be worse than this. | [-] | 0.5 |
| BlindViewRadiusFakeRelative | for blinded (mostly sleeping) NPC we have to calculate stealth XP somehow, so we calculate this fake radius | [-] | 0.8 |
| VisionToViewRadius | an increase of FOV caused by the hea stat | [m/vis] | 1.35 |
| MinModVisibility | final modified visibility stat minimum (the most invisible actor) | [vis] | \-2 |
| MaxModVisibility | final modified visibility stat maximum (the most visible actor) | [vis] | 3.5 |
| MinModConspicuousness | final modified conspicuousness stat minimum (the least conspicuous actor) | [con] | \-1 |
| MaxModConspicuousness | final modified conspicuousness stat maximum (the most conspicuous actor) | [con] | 1 |
| RecognitionTimePCoef | recognition time for a character with conspicuousness = 0 | [s] | 4 |
| RecognitionTimeKPositiveCoef | multiplicative coef for positive values of conspicuousness #perception | [s/vib] | \-2 |
| RecognitionTimeKNegativeCoef | multiplicative coef for negative values of conspicuousness #perception | [s/vib] | \-4 |
| RecognitionTimeDistanceGain | perlin gain for the distance influencing the recognition time | [-] | 0.1 |
| RecognitionSpeedNotVisible | must be negative, how the recognition is decreased | [recog/s] | \-0.5 |
| PerceptionSecondaryCrowdMembers | When the crowd around player is this large they become invisible for secondary perception | [alive humans] | 4 |
| PerceptionSecondaryCrowdRadius | People this far from the player are considered a crowd for secondary perception | [m] | 0 |
| PerceptionSecondaryDecayTime | Amount of time needed for NPCs to become unaware of the player after secondary perception drops to 0 | [s] | 4 |
| NonPlayerRecognitionTimeMod | Multiple recognition time of everything but the player | [] | 0 |
| CombatHitUnconsciousDepth | depth after a combat hit | [depth] | 480 |
| CombatHitImmortalUnconsciousDepth | depth for immortal knock-out | [depth] | 480 |
| StealthAttackFailXp | xp gain for failed stealth kill or take-down | [xp] | 10 |
| StealthAttackMinXp | xp gain for successful stealth kill or take-down, weakest enemy | [xp] | 30 |
| StealthAttackMaxXp | xp gain for successful stealth kill or take-down, strongest enemy | [xp] | 50 |
| StealthKnockOutUnconsciousDepthBase | the base unconsciousness depth for stealth knockout | [depth] | 400 |
| StealthToUnconsciousDepth | modifies the time victim is unconscious | [depth] | 600 |
| UnconsciousDepthFadeoutSpeedBase | how fast is the depth consumed | [depth/s] | 1 |
| VitalityToUnconsciousDepthFadeoutSpeed | relative vitality | [depth/s] | 1 |
| UnconsciousTimeWhenTimeIsNotRunning | if world time is not running, skiptime can not be started when player is unconscious; screen will only fade for this long instead; this is slightly modified by some rpg stats | [s] | 8 |
| StealthSkillToFootstepSoundMult | how much how much are footsteps attenuated for the max skill #perception | [-/skill] | 0.6 |
| FootstepSoundMultHeadroomFactor | multiply fsm before clamping to give it some headroom #perception | [] | 0.5 |
| StealthSkillToRecogTime | how much is the required time extended on max skill level (relative) #perception | [-/skill] | 0.6 |
| StealthSkillToViewRadiusDecr | how much is the view radius decreased on max skill level (relative) #perception | [-/skill] | 0.3 |
| StealthSneakCheckRadius | npc query radius when sneaking, #perception | [m] | 15 |
| StealthSneakBaseXp | base xp gain when sneaking, #perception | [xp] | 10 |
| StealthSneakBaseDistance | sneaked distance that triggers stealth leveling, #perception | [m] | 4 |
| StealthSneakXpSumCoefA | combine xps from more npcs, #perception | [] | 5 |
| StealthSneakXpSumCoefB | combine xps from more npcs, #perception | [] | 4 |
| StatXpAgilityForStealth | agility XP gain for been undetected in stealth, #perception | [xp] | 10 |
| StealthKillDamage | damage given to the victim | [hp] | 100 |
| StealthKillProbCoefA | stealth kill/knock-out probability formula | [] | 0.1 |
| StealthKillProbCoefB | stealth kill/knock-out probability formula | [] | 1 |
| StealthKillProbCoefC | stealth kill/knock-out probability formula | [] | 1 |
| StealthKillMinSlot | min slot duration for stealth kill/knock-out | [] | 0.05 |
| StealthKillMaxSlot | max slot duration for stealth kill/knock-out | [] | 0.4 |
| StealthBackoffMinTime | min duration for stealth backoff | [] | 0.1 |
| StealthBackoffMaxTime | max duration for stealth backoff | [] | 1.5 |
| StealthCooldown | after last detector npc stops seeing player | [] | 5 |
| MinStealthHitSoundMultiplier | intensity multiplier for max stealth level | [] | 0.06 |
| MaxStealthHitSoundMultiplier | intensity multiplier for min stealth level | [] | 0.22 |
| TrueRelationDistThresholdRel | distance, relative to observers maximum distance, required to see the true faction #perception | [-/skill] | 0.333333 |
| MinTrueRelationDistThreshold | minimal distance required to see the true faction #perception | [-/skill] | 1.5 |
| PerceivedSuperfactionImportanceThresholdRel | superfaction items must occupy more than this for the soul to look like the superfaction #perception | [-] | 0.333333 |
| PerceivedSocialClassImportanceThresholdRel | social class items must occupy more than this for the soul to look like the social class #perception | [-] | 0.333333 |
| MaxWeatherSoundAttenuationCoef | 0 - allow weather conditions to mute the sounds, 1 - no influence | [-] | 0.2 |
| MaxHearingSoundAttenuationCoef | minimal attenuation for non-zero hearing stat | [-] | 0.02 |
| HuntingAlarmSoundSkillToSmellRatio | How much more valuable is full skill than smell, when computing hunting alarm sound loudness | [-] | 1.5 |
| HuntingAlarmSoundMinimalMultiplier | Minimal multiplier of hunting alarm sound loudness. | [-] | 0.6 |
| HuntingAlarmSoundMaximalMultiplier | Maximal multiplier of hunting alarm sound loudness. | [-] | 0.9 |
| PerceptionPriorVisPeople | target priority estimation, #perception | [] | 3 |
| PerceptionPriorVisItems | target priority estimation, #perception | [] | 0.5 |
| PerceptionPriorVisCrimes | target priority estimation, #perception | [] | 6 |
| PerceptionPriorDist | target priority estimation, #perception | [] | 2 |
| PerceptionMeanDist | target priority estimation, #perception | [] | 5 |
| PerceptionPriorConsp | target priority estimation, #perception | [] | 6 |
| PerceptionPriorFriendRelationship | target priority estimation, #perception | [] | \-4 |
| PerceptionPriorEnemyRelationship | target priority estimation, #perception | [] | \-15 |
| PerceptionPriorEnemyRelationshipBonus | target priority estimation, #perception | [] | 20 |
| PerceptionPriorCha | target priority estimation, #perception | [] | 0.15 |
| PerceptionBaseCha | target priority estimation, #perception | [] | 15 |
| PerceptionPriorGender | target priority estimation, #perception | [] | 2 |
| PerceptionPriorNotHumanRace | target priority estimation, #perception | [] | \-15 |
| PerceptionPriorWeapon | target priority estimation, #perception | [] | 6 |
| PerceptionPriorDead | dead or unconscious, #perception | [] | 25 |
| PerceptionPriorBoostRangedWeapon | boost for ranged weapons (multiplied by PriorWeapon!), #perception | [] | 4.2 |
| PerceptionPriorCrimeLoot | priority boost for crime #perception | [] | 12 |
| PerceptionPriorCrimeLockpick | priority boost for crime #perception | [] | 12 |
| PerceptionPriorCrimeCarryCorpse | priority boost for crime #perception | [] | 12 |
| PerceptionPriorBoostPlayer | boost for player #perception | [] | 20 |
| PerceptionPriorBoostScriptContext | Boost perception priority from soul A to soul B defined by a script context. | [] | 30 |
| PerceptionInnerConeMinRelSize | Minimal relative size of perception inner cone. #perception | [-] | 0.4 |
| PerceptionInnerConeMaxRelSize | Maximal relative size of perception inner cone. #perception | [-] | 1 |
| PerceptionInnerConeNervousnessLimit | When nervousness reaches this value the inner cone should be the largest. #perception | [-] | 1 |
| VisibilityDecrementDaytimeInterior | Limited by MinModVisibility and MaxModVisibility. Implicit constant for DaytimeExterior defaults to 0. See also NightTransitionPeriod. #perception | [-] | \-0.3 |
| VisibilityDecrementNighttimeInterior | Limited by MinModVisibility and MaxModVisibility. See also NightTransitionPeriod. #perception | [-] | \-0.5 |
| VisibilityDecrementNighttimeExterior | Limited by MinModVisibility and MaxModVisibility. See also NightTransitionPeriod. #perception | [-] | \-0.7 |
| VisibilityDecrementInFog | Multiply by fog amount and add to visibility while outside. #perception | [-] | \-0.5 |
| VisibilityDecrementInVisArea | Hide in tall grass. #perception | [-] | \-0.35 |
| DistractVerticalViewLimit | While holding a decoy during the distract minigame, the player can only look this low or high. | [deg] | 45 |
| InformationVersionRefresh | If identical information is created after this amount of time, it is considered as new. | [s] | 30 |
| InformationExpirationBase | Multiply by a modifier from crime table to get amount of time after which an information expires. | [day] | 1 |
| InformationBroadcastPeriod | Information is broadcast in a faction subtree periodically after this amount of time. | [day] | 1 |
| InformationBroadcastIgnoreRadius | NPCs around the player will not receive information from periodic broadcasts. | [m] | 30 |
| InformationBroadcastDelay | Fresh information will broadcast only if it is at least this old. | [min] | 0.3 |
| AthleticXPAwardDistance | award xp for traveling some distance | [m] | 200 |
| HorseRidingAwardDistance | award xp for traveling some distance on horse | [m] | 200 |
| CarriedBodyWeightCoef | how much of the carried body weight is added to the carried weight of the carrier | [-] | 0.25 |
| CarriedCarriedWeightCoef | how much of the carried weight of the carried NPC is added to the carried weight of the carrier | [-] | 0.5 |
| CarriedBodyMaxStamConsumption | uses encumberence to interpolate from 0 to this | [-] | 10 |
| MinEncumberanceXPAwardDistance | Distance that has to be covered while minimally encumbered to get StatXPStrAndVitPerDistanceEncumbered (linear interpolation with EncumberanceXPAwardDistanceMax). | [m] | 50 |
| MaxEncumberanceXPAwardDistance | Distance that has to be covered while encumbered by at least double of carry weight to get StatXPStrAndVitPerDistanceEncumbered (linear interpolation with EncumberanceXPAwardDistanceMin). | [m] | 10 |
| ShoeHealthUpdateDistance | shoe health is update after traveling N m | [m] | 50 |
| ShoeHealthDecrease | status delta per traveled m | [status/m] | 0.0001 |
| HorseEquipHealthUpdateDistance | horse equip health is update after traveling N m | [m] | 100 |
| HorseEquipHealthDecrease | status delta per traveled m | [status/m] | 0.001 |
| QuestMoneyRewardScaleConstant | scale constant for quest reward item amount | [-] | 1.025 |
| ItemHealthPriceStatusWeight | item health status weight price coef | [-] | 0.99 |
| WorthlessItemPrice | The most despicable items are with this value or lower | [gr] | 0 |
| TreasureItemPrice | starting price of treasure items | [grosh] | 1000 |
| BaseItemDisappearingTime | base game time for dropped items to auto disappear | [s] | 172800 |
| ItemDisappearingMulti | multiplier 1/x - x limit(up/down) for item disappearing speed in extremes (cheap vs. expensive, small vs. large) | [s] | 3 |
| MaxItemDisappearingTime | max game time for dropped items to disappear | [s] | 187200 |
| DefaultVisVolume | default item size-volume that have no visibility recognition penalty | [dm3] | 0.03 |
| BestVisVolume | object volume for maximum recognition bonus | [dm3] | 10000 |
| StealVisVolumeConspicuousnessMin | Minimum conspicuousness for perceptible volume of type steal. | [-] | \-1 |
| StealVisVolumeConspicuousnessMax | Maximum conspicuousness for perceptible volume of type steal. | [-] | 1 |
| StealVisVolumeVisibilityMin | Minimum visibility for perceptible volume of type steal. | [-] | \-1 |
| StealVisVolumeVisibilityMax | Maximum visibility for perceptible volume of type steal. | [-] | 1 |
| StealVisVolumeWorthlessItemTime | Steal volumes for the most despicable items will last this long | [s] | 180 |
| StealVisVolumeTreasureItemTime | Steal volumes for the most precious items will last this long | [s] | 480 |
| PerceivedStateRecognitionDistanceMin | At this relative distance in the perception cone all perceived states are recognized immediately. | [-] | 0.4 |
| PerceivedStateRecognitionDistanceMax | Beyond this relative distance in the perception cone all perceived states are never recognized. | [-] | 1 |
| PerceivedStateThreatDistance | Anyone closer than this with a drawn weapon is considered a threat. | [m] | 2 |
| RestockRepairPerDay | Automatically repair default non-player items by this many % (up to their default value). | [%] | 0.05 |
| RestockPeriodSoul | How many days it takes to fully restock a soul's inventory from nothing to its default items. 0 to disable. | [day] | 7 |
| ItemOwnerFadePriceToHours | world time hours per decigrosh | [h/decigrosh] | 0.015 |
| ItemOwnerFadeConspicuousnessToHours | world time hours | [h/con] | 0 |
| ItemOwnerNeverFadesToSuspiciency | basket suspiciency calculation | [-] | 10 |
| ItemOwnerFadeCoefToSuspiciencyMul | basket suspiciency calculation | [-] | 1 |
| ItemOwnerFadeCoefToSuspiciencyExp | basket suspiciency calculation | [-] | 1 |
| ItemOwnerDescFadeToSuspiciencyExp | basket suspiciency calculation | [-] | 1 |
| ItemOwnerFactionDistanceInnerRadius | basket suspiciency calculation: items stolen closer than this get max faction distance suspiciency | [m] | 600 |
| ItemOwnerFactionDistanceOuterRadius | basket suspiciency calculation: items stolen further than this get min faction distance suspiciency | [m] | 1800 |
| ItemOwnerFactionDistanceToSuspiciencyMin | basket suspiciency calculation | [-] | 0.15 |
| ItemOwnerFactionDistanceToSuspiciencyMax | basket suspiciency calculation | [-] | 1 |
| ItemOwnerRelationshipToSuspiciencyMin | basket suspiciency calculation | [-] | 0.1 |
| ItemOwnerIsShopkeeperToSuspiciency | basket suspiciency calculation | [-] | 10 |
| ItemOwnerSpatialFadeThreshold | If distance part of basket suspiciency calculation falls below this, the item is locally faded. Tune with ItemOwnerFactionDistanceToSuspiciencyMin in consideration. | [-] | 0.15 |
| BarterDominanceSpcWeightA | barter dominance calculation 'a' coef | [-] | 3 |
| BarterDominanceRelationshipWeightB | barter dominance calculation 'b' coef | [-] | 1 |
| BarterDominanceChaWeightC | barter dominance calculation 'c' coef | [-] | 0.1 |
| BarterDominanceSpcWeightD | barter dominance calculation 'd' coef | [-] | 10 |
| BarterDominanceChaBaseE | barter dominance calculation 'e' coef | [-] | 5 |
| BarterCoefWeightA | shopkeeper shop barter calculation 'a' coef | [-] | 0.875 |
| BarterCoefWeightB | shopkeeper shop barter calculation 'b' coef | [-] | 80 |
| BarterAngrinessCoefWeightA | shopkeeper shop barter calculation 'a' coef | [-] | 1 |
| BarterAngrinessCoefWeightB | shopkeeper shop barter calculation 'b' coef | [-] | 0.7 |
| ShopLargeTransaction | Percentage of total price of default items, if player spends more than this amount of money, large transaction barks are played. | [%] | 0.2 |
| BarterPriceSellRepCoef | sell reputation coef | [-] | 1.5 |
| BarterPriceSellRepMultip | sell reputation multiplier | [-] | \-0.5 |
| BarterPriceSellRepBuying | price sell vs buy mod | [-] | 1.5 |
| RepairShopSkillPriceMultiplier | Ratio between skill of shopKeeper and repair price increase | [-] | 0.005 |
| RepairPriceModif | Default repairing shop price modif | [-] | 0.45 |
| RepairShopMinSkillForQuality2 | Minimal skill to repair item of quality 2 in shop. | [-] | 3 |
| RepairShopMinSkillForQuality3 | Minimal skill to repair item of quality 3 in shop. | [-] | 5 |
| RepairShopMinSkillForQuality4 | Minimal skill to repair item of quality 4 in shop. | [-] | 15 |
| RepairKitMinSkillForQuality2 | Minimal skill to repair item of quality 2 with repairkit. | [-] | 5 |
| RepairKitMinSkillForQuality3 | Minimal skill to repair item of quality 3 with repairkit. | [-] | 12 |
| RepairKitMinSkillForQuality4 | Minimal skill to repair item of quality 4 with repairkit. | [-] | 16 |
| RepairKitMaxSkillCapacityCoef | Max skill coef for repair kit total capacity. | [-] | 1.5 |
| RepairKitCapacity | Repair kit capacity to repair | [grosh] | 600 |
| RepairKitItemPerkBuffHealthThreshold | Buffs added by repair kit perks wont be functional under this item health | [-] | 0.3 |
| RazorSharpBuffHealthThreshold | Buff on sharpened weapon will not be functional under this item health | [-] | 0.75 |
| WashSoapCostMod | Minimum cost modifier for soap cost calculation | [-] | 0.05 |
| WashSoapCostSkillCoef | Skill coefficient for soap cost calculation | [-] | 0.1 |
| WashDirtLimitMin | Possible dirt that can be washed on the minimum skill level. | [-] | 0.3 |
| WashDirtLimitMax | Possible dirt that can be washed on the maximum skill level. | [-] | 0.8 |
| WashItemsCraftsmanshipXpReward | XP reward to craftsmanship skill for washing items in washing minigame | [xp] | 10 |
| AddedDirtOnCarryItem | Dirt added on player when picking or putting down an item through the carry item action (the sack carrying feature). | [%] | 0.04 |
| WashItemDirtPriceStatusWeight | item dirt status weight price coef for washing | [-] | 0.5 |
| BasketSuspiciencyHaggleThreshold | Haggle reaction 1 threshold (haggle more difficult) | [-] | 0.1 |
| BasketSuspiciencyNoDealThreshold | Haggle reaction 2 threshold (transaction refused) | [-] | 0.5 |
| ItemHealthOverlapCoef | Percentual overlap between two quality intervals. | [-] | 0.25 |
| ItemQualityDecreaseProbabilityThreshold | Threshold when probability of quality decrease begins grow (relatively to overlap). | [-] | 0.5 |
| ItemQualityDecreaseProbabilityCoef | Maximum probability when min health is reached (relatively to current interval). | [-] | 0.8 |
| ItemDestroyProbabilityThreshold | Threshold determines HP value where prob is growing in the last quality interval. | [-] | 0.05 |
| ItemDestroyProbabilityCoef | Maximal probability when item reached the lowest HP. | [-] | 0.7 |
| RifleDestroyDamage | HP damage to the user when riffle is destroyed. | [hp] | 35 |
| ItemHealthAlmostBrokenThreshold | Relative threshold where UI notification appears (stage 2). | [-] | 0.2 |
| ItemHealthDamagedThreshold | Relative threshold where UI notification appears (stage 1). | [-] | 0.4 |
| ItemHealthDamagedBuffThreshold | Relative threshold where buff appears in HUD. | [-] | 0.4 |
| MaximalItemQualityForDamage | Maximal quality of item which is counted to the item damage (for decal visualization). | [-] | 3 |
| ArmorConditionThresholdForDamage | Threshold of armor condition where armor damage is increasing. | [-] | 0.3 |
| WeaponConditionThresholdForDamage | Threshold of weapon condition where weapon damage is increasing. | [-] | 0.7 |
| StashRobbedValueDecayRate | Decay rate of value of items stolen from a stash. | [grosh/h] | 1 |
| StashRobbedValueBottomThreshold | If the robbed value drops to this threshold, it is no longer considered noteworthy. | [grosh] | 0 |
| NPCRobbedValueDecayRate | Decay rate of value of items stolen from a NPC. | [grosh/h] | 1 |
| NPCRobbedValueBottomThreshold | If the robbed value drops to this threshold, it is no longer considered noteworthy. | [grosh] | 0 |
| AngrinessArmingThreshold | If Angriness is higher, NPCs will start equipping weapons everywhere. | [-] | 0.67 |
| ConfiscateItemsInRadius | Items laying this far from the player will be considered when confiscating. | [m] | 3 |
| InvestigatingNPCRadius | NPCs investigating this far from the player will trigger the Investigating icon. | [m] | 100 |
| CombatActiveNPCRadius | When NPC is closer than the value Active combat icon is used else only Danger icon is set. | [m] | 10 |
| FriskProbabilityMod | Modifier for the frisk probability | [] | 1 |
| ReputationPropagationCoefCap | Maximum propagation from faction to its parent | [coef] | 0.15 |
| FrozenRenownValue | Fixed value for frozen renown | [] | 0 |
| NPCRepWeight | Weight of player - npc reputation (reputation median) | [] | 5 |
| FactionRepWeight | Weight of player - faction reputation (reputation median) | [] | 3 |
| SuperFactionRepWeight | Weight of superfaction reputation (reputation median) | [] | 1 |
| FactionAngrinessMinimum | Faction angriness minimum. | [] | 0 |
| FactionAngrinessMaximum | Faction angriness maximum. | [] | 1 |
| FactionAngrinessDecayRate | Faction angriness decay rate. 1e-6 means decay 1-\>0 in about 12 days. | [1/s] | 8e-06 |
| FactionAngrinessPropagationCoef | Faction angriness is propagated through space between factions. | [] | 1 |
| FactionAngrinessPropagationScale | Faction angriness propagation distance scale. | [] | 0.1 |
| FactionAngrinessPropagationCutoff | Faction angriness propagation distance cutoff. | [] | 0.01 |
| FactionAngrinessDelay | Time until an angriness change takes effect. | [h] | 12 |
| NervousnessMinimum | Nervousness minimum. | [] | 0 |
| NervousnessMaximum | Nervousness maximum. | [] | 1 |
| AngrinessFromNervousnessCoef | Angriness gain from nervousness change. | [] | 0.2 |
| NervousnessDecayRate | Nervousness decay rate. 1e-5 means decay 1-\>0 in about 1 day. | [1/s] | 0.0001 |
| NervousnessPropagationCoef | Nervousness is propagated through space between NPCs. | [] | 0.1 |
| NervousnessPropagationRadius | Nervousness propagation radius. | [m] | 10 |
| NervousnessCourageousWeight | Courageous characters only get this much of each nervousness change. \<0, 1\>. | [] | 0.5 |
| ReputationPropagationTime | propagation time from npc to faction/superfaction (world time) | [s] | 10800 |
| ReputationPropagationBiasTime | random bias to propagation time (world time) | [s] | 1800 |
| ReputationSpatialPropagationDistance | max distance to propagate reputation to nearby factions | [m] | 400 |
| ReputationSpatialPrapagation | mod amount propagated to nearby factions | [m] | 0.25 |
| GreatReputationIconThreshold | reputation threshold above which a faction will be very friendly with the player | [] | 0.8 |
| HighReputationIconThreshold | reputation threshold above which a faction will be friendly with the player | [] | 0.6 |
| NeutralReputationIconThreshold | reputation threshold above which a faction will be neutral to the player | [] | 0.4 |
| LowReputationIconThreshold | reputation threshold above which a faction will be little hostile to the player | [] | 0.2 |
| IndulgencePriceFactor | Multiply by total reconcile reputation improvement | [] | 720 |
| IndulgencePriceMin | Minimum indulgence price. 0 means no reconciliation necessary | [grosh] | 10 |
| IndulgencePriceMax | Maximum indulgence price. | [grosh] | 10000 |
| StolenKeyExpirationTime | NPCs change their locks after this amount of time since the keys were stolen | [day] | 3 |
| StolenKeyExpiraitionBlockRadius | NPCs will not change a lock unless it is further from the player than this | [m] | 30 |
| StolenKeyLockChangePeriod | NPCs take this long between checking whether they should change locks | [day] | 1 |
| MinMorale | min deriv stat value | [cou] | 0 |
| MaxMorale | max deriv stat value | [cou] | 1 |
| SoulCourageMoraleWeight | Weight of soul courage affecting morale | [] | 6 |
| ClassCourageMoraleWeight | Weight of soul class courage affecting morale | [] | 0 |
| BadassnessMoraleWeight | Weight of badassness affecting morale | [] | 3 |
| SkirmishPredominanceWeight | Weight of skirmish predominance affecting main morale | [] | 0.1 |
| SkirmishCheckThreatLevel | Threat level for skirmish morale checks | [] | 0.5 |
| HealthToBadassnessMinCoef | multiplicative coef for health = 0 | [-] | 0.2 |
| OverallArmorDefenseBadassWeight | Weight of normalized oad affecting badassness | [] | 4 |
| OverallWeaponAttackBadassWeight | Weight of normalized attack affecting badassness | [] | 6 |
| OverallStatsBaddassWeight | Weight of stats affecting badassness | [] | 2 |
| StrengthBaddassWeight | Weight of relative strength affecting badassness | [] | 0.4 |
| AgilityBaddassWeight | Weight of relative agility affecting badassness | [] | 0.4 |
| RiderBaddassWeight | Weight of relative rider skill affecting badassness | [] | 0.3 |
| MoraleContextFadingSpeed | Speed of Morale context increasing/decreasing to 0 | [] | 0.05 |
| MoraleDecisionReliability | Reliability of morale checks | [] | 0 |
| MoraleLinearShiftBase | Biasing of morale checks | [] | 0.3 |
| MoraleLinearShiftFactor | Biasing of morale checks | [] | 1.5 |
| MaxCourageMoraleContextFadingMod | how much can courage affect morale context fading | [] | 0.03 |
| MoraleForCombat | how much must an NPC have to not flee from combat | [] | 0.2 |
| CombatAutoSyncRiposteWeight | KCD_TechDesignDefenseControl | [] | 0.5 |
| CombatNoBlockProb0 | KCD_TechDesignDefenseControl | [] | 0.3 |
| CombatNoBlockProb1 | KCD_TechDesignDefenseControl | [] | 0 |
| CombatNormalBlockProb0 | KCD_TechDesignDefenseControl | [] | 0.7 |
| CombatNormalBlockProb1 | KCD_TechDesignDefenseControl | [] | 0.2 |
| CombatPerfectBlockProb0 | KCD_TechDesignDefenseControl | [] | 0 |
| CombatPerfectBlockProb1 | KCD_TechDesignDefenseControl | [] | 2.5 |
| CombatPerfectBlockPowTo | KCD_TechDesignDefenseControl | [] | 1.5 |
| CombatPerfectBlockNPCvsNPCCoef | KCD_TechDesignDefenseControl | [] | 1.5 |
| CombatPerfectBlockZoneDistanceCoef | KCD_TechDesignDefenseControl | [] | 0.45 |
| CombatPerfectBlockOnRiposteCoef | KCD_TechDesignDefenseControl | [] | 1.5 |
| CombatSyncPerfectBlockProb0 | KCD_TechDesignDefenseControl | [] | 0 |
| CombatSyncPerfectBlockProb1 | KCD_TechDesignDefenseControl | [] | 0.7 |
| CombatMasterStrikeProb0 | KCD_TechDesignDefenseControl | [] | 0 |
| CombatMasterStrikeProb1 | KCD_TechDesignDefenseControl | [] | 3 |
| CombatMasterStrikePowTo | KCD_TechDesignDefenseControl | [] | 2 |
| CombatDodgeProb0 | KCD_TechDesignDefenseControl | [] | 0 |
| CombatDodgeProb1 | KCD_TechDesignDefenseControl | [] | 0.3 |
| CombatDodgeProbCoef | KCD_TechDesignDefenseControl | [] | 2 |
| CombatAutoReactionDelayRangeSpread | of the maximal range | [] | 0.3 |
| CombatAutoTrickReactionStaWeight | KCD_TechDesignDefenseControl | [] | 1 |
| CombatAutoTrickReactionSkillWeight | KCD_TechDesignDefenseControl | [] | 4 |
| CombatAutoTrickReactionMinDelay | KCD_TechDesignDefenseControl | [s] | 0.1 |
| CombatAutoTrickReactionMaxDelay | KCD_TechDesignDefenseControl | [s] | 8 |
| CombatAutoAggressionDiffScale | the bigger number the bigger difference in aggresion for skill differnce | [-] | 2 |
| ComboNextStepProbBlocked | combo prob dec when opponent blocks | [-] | 0.1 |
| ComboNextStepProbHit | combo prob dec when opponent hit | [-] | 0.3 |
| ComboNoActionNeutralProb | combo prob for no action | [-] | 0.25 |
| ComboMinProb | minimal combo prob when combo count \> 0 | [-] | 0.1 |
| ComboMinSteps | minimal combo step count | [-] | 3 |
| ComboPerComboProb | per combo prob increase | [-] | 0.4 |
| ComboStepPerFen | per fencing level step increase | [-] | 4 |
| ComboStepSyncActionMod | modifier of combo steps when attacker is in sync action | [-] | 0.7 |
| ComboHitCancelProb | prob to cancel combo when hit opponent | [-] | 0.05 |
| CombatAutoMaxAttackDelay | mean delay between attacks for a defensive AI | [s] | 2 |
| CombatAutoNPCOpponentAtkDelayCoef | shortening attack delay when opponent is npc | [%] | 0.5 |
| CombatAutoAttackDelayIncreasePerAttacker | how many times is the period increased for each attacker | \- | 0.8 |
| CombatAutoAttackDelayIncreasePerAttackerHorse | CombatAutoAttackDelayIncreasePerAttacker if the victim is on horse | \- | 0.1 |
| CombatAutoAttackDelayIncreasePerAttackerMissile | CombatAutoAttackDelayIncreasePerAttacker if the victim has a missile wpn | \- | 0.2 |
| CombatAutoScaleDefensivenessDelayRel | relative to attack delay, time to override defensiveness and go near | [-] | 2 |
| CombatAutoAttackDelaySigma | attack delay variation | [s] | 4 |
| CombatAutoTrickNoAttackProb | [0-1] no attack prob for the first step | [-] | 0.1 |
| CombatAutoTrickAttackProb | [0-1] attack prob for the first step | [-] | 0.8 |
| CombatAutoTrickMaxProb | [0-1] max trick prob for the first step | [-] | 0.5 |
| CombatAutoTrickInvalidBlockAttackMaxProb | [0-1] max trick prob for a skilled AI if the block is invalid | [-] | 0.5 |
| CombatAutoTrickMinMaxDelay | lower bound of the max delay | [s] | 0.8 |
| CombatAutoTrickDelayVariability | added to the lower bound | [s] | 0.3 |
| CombatAutoEasyZoneWeight | [0-1] how much are easy zones favored by the lame AI (1 = favored) | [-] | 0.8 |
| CombatAutoMinDefenseModeWeight | [0-1] the lowest weight for the defense mode | [-] | 0.4 |
| CombatAutoZoneChangeDelayMinMin | zone change timeout minimal minimum | [s] | 2 |
| CombatAutoZoneChangeDelayMinMax | zone change timeout minimal maximum | [s] | 6 |
| CombatAutoZoneChangeDelayMaxMin | zone change timeout maximal minimum | [s] | 5 |
| CombatAutoZoneChangeDelayMaxMax | zone change timeout maximal maximum | [s] | 10 |
| CombatAutoOppZoneAdaptDelayMinMin | reaction delay minimal minimum | [s] | 0.1 |
| CombatAutoOppZoneAdaptDelayMinMax | reaction delay minimal maximum | [s] | 0.5 |
| CombatAutoOppZoneAdaptDelayMaxMin | reaction delay maximal minimum | [s] | 1 |
| CombatAutoOppZoneAdaptDelayMaxMax | reaction delay maximal maximum | [s] | 2 |
| CombatAutoZoneAdaptMinDefense | minimal defense where npc begins some adaptation | [-] | 0.3 |
| CombatAutoZoneAdaptDefenseWeight | modifier for global adaptation weight dependent on defense | [-] | 8 |
| CombatAutoZoneAdaptMSWeight | modifier for MS adaption weight dependent on fencing | [-] | 0.8 |
| CombatAutoClinchReactionDelayMinMin | minimal minimum | [s] | \-1 |
| CombatAutoClinchReactionDelayMinMax | minimal maximum | [s] | \-0.5 |
| CombatAutoClinchReactionDelayMaxMin | maximal minimum | [s] | 0.5 |
| CombatAutoClinchReactionDelayMaxMax | maximal maximum | [s] | 1 |
| CombatAutoClinchAlternativeMinFencing | minimal fencing level for alternative guard | [-] | 5 |
| CombatAutoClinchAlternativeMaxProbability | prob of transition to alternative guard on max skill level | [-] | 0.8 |
| CombatAutoMasterGuardOffset | offset to max distance | [m] | 1 |
| CombatAutoLameGuardOffset | offset to max distance | [m] | 3 |
| CombatAutoGuardHysteresis |  | [m] | 1.5 |
| CombatAutoForcedPeriodicalAttackStaminaLimit | stamina threshold | [-] | 0.2 |
| CombatAutoForcedComboStaminaLimit | stamina threshold | [-] | 0.7 |
| CombatAutoMaxAimDuration | the longest aim time for the lowest skill | [s] | 3 |
| CombatAutoMaxAimDurationRandomAdd | max random time added to the aim duration | [s] | 1 |
| CombatAutoMoveActivityDecreasePerAttacker | my activity decrease per opponents aditinal attackers | [ma] | 0.5 |
| CombatAutoMinHuntAttackDuration | minimal time the NPC is hunting/chasing | [s] | 15 |
| CombatAutoMaxHuntAttackDuration | maximal time the NPC is hunting/chasing | [s] | 60 |
| CombatAutoMaxAtkDistOffset | offset from max attack distance defined in percentage from attack range | [%] | 0 |
| CombatAutoMoveProficiencyHPCoef | HP coefficient for movement proficiency | [-] | 1 |
| CombatAutoMoveProficiencySkillCoef | Skill coefficient for movement proficiency | [-] | 1 |
| CombatMoveApproachSprintMinStamina | do not allow sprint during the approach | [sta] | 1 |
| StealthTimeWarpSpeed | Stealth kill timewarp speed. | [] | 0.5 |
| TimeWarpPBFadeSpeedForPlayer | Speed of PB time warp when player is doing PB. 1 - disabled | [] | 1 |
| TimeWarpPBFadeSpeedForOpp | Speed of PB time warp when player has opened PB slot on riposte. 1 - disabled | [] | 0.4 |
| TimeWarpMSFadeSpeedForOpp | Timewarp speed during oppponent MS action. | [] | 1 |
| TimewarpStealthPBSpeedForOpp | Timewarp speed during sync PB slot in sync guards. | [] | 1 |
| TimewarpSyncPBSpeedForOpp | Timewarp speed during sync PB slot in sync guards. | [] | 0.4 |
| PickpocketingMinChargeTime | min charge time needed | [s] | 2 |
| PickpocketingMaxSkillChargeTime | max charge time with best skill | [s] | 30 |
| PickpocketingMaxSkillChargeSpeedRatio | charge speed ratio boost with best skill | [s] | 6 |
| PickpocketingItemUncoverTimePerWeight | time to uncover item per weight unit | [s] | 0.021 |
| PickpocketingXP | XP for each successful pickpocketing | [-] | 30 |
| PickpocketingStealthXP | XP to stealth for each successful pickpocketing | [-] | 12 |
| PickpocketingTreasurePriceXP | additional XP gain calculated by stolen items total value | [xp/value] | 110 |
| PickpocketingStartedAgilityXP | XP to agility for starting pickpocketing | [xp] | 5 |
| PickpocketingFailXPMod | XP modified on fail | [-] | 0.3 |
| PickpocketingNPCSleepingTimeChanceMod | Modifies TimeChancePenalty when sleeping | [-] | 0.5 |
| PickpocketingNPCDrunkTimeChanceMod | Modifies TimeChancePenalty when drunk | [-] | 0.5 |
| PickpocketingNPCHurtTimeChanceMod | Modifies TimeChancePenalty when hurt | [-] | 0.75 |
| PickpocketingTimeChancePenaltyBest | penalty in pickpocketing chance in best case (s) | [%] | 0.0133 |
| PickpocketingTimeChancePenaltyWorst | penalty in pickpocketing chance in worst case (s) | [%] | 0.1 |
| PickpocketingAngleChancePenalty | penalty in (0-1) to chance pickpocketing for each angle from optimal possition exactly from behind victim (180 max) | [%] | 0.0027 |
| PickpocketingRobbedAngrinessChancePenalty | penalty in (0-1) to pickpocketing chance for each time victim was robbed before | [%] | 0.05 |
| PickpocketingComradePerkBonus | max bonus in (0-1) to pickpocketing for comrade perk | [%] | 0.3 |
| PickpocketingIndicatorSharpness | 0 - precise slow change, 1 - sharp change | [] | 0 |
| PickpocketingDistance | Max pickpocketing range (not starting interactor range) | [m] | 2.4 |
| PickpocketingMisstargetingTolerance | Time tolerange for temporary misstargeting your victim. | [ms] | 2250 |
| PickpocketingRandomChanceRollMinCap | Worst random rolls will alawys be capped to this minimum change 0-1 | [%] | 0.1 |
| PickpocketingRosetteMinSpeed | Speed of moving between two rosette tiles at minimal thievery skill (speed is linearly interpolated between min and max by thievery). | [s] | 0.5 |
| PickpocketingRosetteMaxSpeed | Speed of moving between two rosette tiles at max thievery skill (speed is linearly interpolated between min and max by thievery). | [s] | 0.2 |
| PickpocketingOneTileUncoveredAtSkill | If thievery is higher than this but lower than PickpocketingThreeTilesUncoveredAtSkill, one random tile in rosette will be uncovered from the start. | [-] | 8 |
| PickpocketingThreeTilesUncoveredAtSkill | If thievery is higher than this but lower than PickpocketingAllTilesUncoveredAtSkill, three random tiles in rosette will be uncovered from the start. | [-] | 12 |
| PickpocketingAllTilesUncoveredAtSkill | If thievery is higher than this, all tiles in rosette will be uncovered from the start. | [-] | 16 |
| PickpocketingLooterPerkExtraMoneyRewardMin | Min extra money reward from pickpocketed victim | [-] | 3 |
| PickpocketingLooterPerkExtraMoneyRewardMax | Max extra money reward from pickpocketed victim (also depends on victim social class) | [-] | 10 |
| PerkBalancedDietActivationTime | hours until BalancedDiet perk bonuses are activated | [h] | 72 |
| ThunderstormBuffRainIntensity | rain intensity threshold when Thunderstorm buff bonuses are activated | [-] | 0.3 |
| PerkBloodRushDuration | duration of BloodRush perk bonuses after an enemy is killed with melee weapon | [s] | 30 |
| PerkUndauntedCavalierCharismaLimit | minimal charisma for Undaunted cavalier perk activation | [-] | 20 |
| PerkCarriedBodyGravediggerWeightMul | carried body weight multiplier for gravedigger perk | [-] | 0.5 |
| LocalHeroInfamousReputationThreshold | above this rep local hero, under infamous | [-] | 0.6 |
| PerkManlyOdourDirtinessThreshold | above this dirtiness manly odour perk bonuses are activated | [-] | 0.5 |
| PerkBrutusCombatDmgRBonusFromBehind | brutus perk multiplicative base Dmg (CombatDmgRBonusFromBehind) | [] | 1.3 |
| StillBuffDuration | duration of standing still after which Still buff bonuses are activated (in worldtime seconds) | [s] | 600 |
| PerkTauntAttackerMoraleMultiplier | multiplier for 'combat_dodge_attacker' morale change when victim has Taunt perk | [-] | 3 |
| JailRecoveryDebuffMaxHours | hours spent in jail after JailRecovery debuff reaches its maximal values | [h] | 240 |
| JailRecoveryDebuffDurationMultiplier | duration of JailRecovery debuff is calculated as jail duration \* this multiplier | [-] | 0.2 |
| HealthFadingFromLimitValue | health percentage to activate health fading buff | [-] | 0.75 |
| AdditionalAttackerCountForMaxFadingBuff | for AdditionalAttackerCountFading buff | [-] | 1 |
| PerkLastGaspLongTermCooldown | how fast can the perk be activated again | [s] | 3000 |
| PerkLastGaspShortTermDuration | how long the buff stays on the player | [s] | 43200 |
| PerkLastGaspCooldown | how fast can the perk be activated again | [s] | 600 |
| PerkNoRestForTheWickedCooldown | how fast can the perk be activated again | [s] | 120 |
| PerkNoRestForTheWickedStaminaLimit | If horse stamina falls bellow this level the perk can be activated | [] | 0.3 |
| HorseExhaustedStaminaLimit | If horse stamina falls bellow this level it becomes exhausted | [] | 0.1 |
| HorseDropRiderStaminaLimit | If the rider's relative stamina drops to this value then it falls from the horse | [%of max stamina] | 0.005 |
| PerkRageDuration | how long are buffs active after the perk is triggered | [s] | 30 |
| PerkRageHealthThreshold | activation health | [%] | 0.25 |
| PerkChainStrikeMaxChain | maximal successive strikes | [-] | 5 |
| DefaultLocationMonitorHysteresis | switch the state after this timeout | [s] | 2.5 |
| StillAndHiddenHysteresis | switch the state after this timeout | [s] | 1.5 |
| SteadyAimHysteresis | switch on perk Steady aim after this timeout | [s] | 2 |
| DuringFaderHysteresis | the in-fader state is kept for how longer | [s] | 1 |
| SleepwalkerPerkChance | probability for the Sleepwalker perk to trigger | [] | 0.2 |
| InteriorCrouchHysteresis | switch the perk state after this timeout | [s] | 1 |
| InteriorDrunkHysteresis | switch the perk state after this timeout | [s] | 1 |
| ExteriorCrouchHysteresis | switch the perk state after this timeout | [s] | 1 |
| CrimeDoorSoundMod | switch the perk state after this timeout | [] | 0.5 |
| PerkLuckyFindTriggerChance | Chance that a random item will be found | [] | 0.05 |
| BordererSprintBuffChargingDuration | Sprint time for which the BordererSprint buff is activated | [s] | 10 |
| BordererSprintBuffCooldownDuration | How long the BordererSprint buff is active after finishing sprint | [s] | 2 |
| RevenantBuffMaxHealthRegeneration | Up to what percentage will regenerate health in revenant perk | [] | 0.5 |
| CreativeSoulExhaustPerSec | Amount of rest added to player each second while in minigame with CreativeSoul perk | [] | 0.1 |
| IsCleanBuffMaxDirtiness | The maximum dirtiness that we consider the soul to be clean | [] | 0.25 |
| CleanlinessIsNextToGodlinessWashHeal | Amount of health regenerated after washing | [] | 10 |
| BlackArtsApprenticeBuffStartTime | Time when buff for perk Black arts apprentice start to be activated | [h] | 0 |
| BlackArtsApprenticeBuffEndTime | Time when buff for perk Black arts apprentice stop to be activated | [h] | 4.5 |
| FinestGoodsMinItemHealth | Minimum item health that is considered good in Finest Goods perk buff | [] | 0.98 |
| TireEmToTakeEmRequiredTime | Required time to activate buff | [s] | 30 |
| NeverSurrenderBuffHealthThreshold | HP threshold when NeverSurrender buff triggers | [%] | 0.25 |
| BedQualityModificationCap | Bed quality modifiers (eg. perk buffs) can only increase the bed quality until this cap. | [%] | 0.5 |
| PerkVeteranChargeCount | Number of charges for Veteran z kosova pole perk. | [] | 5 |
| TheyWillNeverKnowPerkStealthXp | XP gained to stealth skill after They will never know perk activaction | [xp] | 10 |
| ItsaTrapPerkStealthXp | XP gained to stealth skill after It's a trap perk activaction | [xp] | 10 |
| CraftsmanshipXPOverride | Multiply XP gained for this skill | [] | 1 |
| ThieveryXPOverride | Multiply XP gained for this skill | [] | 1 |
| SurvivalXPOverride | Multiply XP gained for this skill | [] | 1 |
| AlchemyXPOverride | Multiply XP gained for this skill | [] | 1 |
| HoundmasterXPOverride | Multiply XP gained for this skill | [] | 1 |
| HorseRidingXPOverride | Multiply XP gained for this skill | [] | 1 |
| FullClothDirtyingOnFullSpeed | how far do we walk with full speed (1.0 walk speed) to get 100% dirty | [m] | 35000 |
| FullClothDirtyingOnZeroSpeed | how far do we walk with half speed to get 100% dirty (other speeds than FullSpeed and HalfSpeed are linearly interpolated) | [m] | 500 |
| ClothesBloodSoakOnMaxBleeding | After how many seconds will clothing become completely bloody when bleeding with max intensity (the injury has bleeding value 1), speed at lower intensity is linearly interpolated (0 at intensity 0). | [s] | 240 |
| TransferedBloodToAttackerMin | Minimum amount of blood transferred to attacker from an injury they inflicted in melee combat. | [%] | 0.05 |
| TransferedBloodToAttackerMax | Maximum amount of blood transferred to attacker from an injury they inflicted in melee combat. | [%] | 0.1 |
| TransferedBloodToVictimMin | Minimum amount of blood transferred to victim from an injury they inflicted in melee combat. | [%] | 0.3 |
| TransferedBloodToVictimMax | Maximum amount of blood transferred to victim from an injury they inflicted in melee combat. | [%] | 0.5 |
| TransferedBloodToAttackerWeaponMin | Minimum amount of blood transferred to attacker weapon from an injury they inflicted in melee combat. | [%] | 0.05 |
| TransferedBloodToAttackerWeaponMax | Maximum amount of blood transferred to attacker weapon from an injury they inflicted in melee combat. | [%] | 0.1 |
| TransferedBloodToAttackerSecondaryWeaponMin | Minimum amount of blood transferred to attacker secondary weapon from an injury they inflicted in melee combat. | [%] | 0.2 |
| TransferedBloodToAttackerSecondaryWeaponMax | Maximum amount of blood transferred to attacker secondary weapon from an injury they inflicted in melee combat. | [%] | 1 |
| ButcheringBloodPerPound | For adding blood on player when butchering animal, addedBlood = animalWeight x bloodPerPound x bloodOffset. | [] | 0.005 |
| ButcheringBloodOffsetMin | AddedBlood when butchering = animalWeight x bloodPerPound x bloodOffset, bloodOffset is random between \<ButcheringBloodOffsetMin; 1\> . | [] | 0.2 |
| FabricCombinedFoleyThreshold | Play combined foley if fabric is the second most important surface and covers this surface ratio | [] | 0.3 |
| ChainmailCombinedFoleyThreshold | Play combined foley if chainmail is the second most important surface and covers this surface ratio | [] | 0.3 |
| PlateCombinedFoleyThreshold | Play combined foley if plate is the second most important surface and covers this surface ratio | [] | 0.3 |
| TrackedAreasNPCRadius | While tracking NPCs present in areas only consider those that are this far from the player. | [m] | 50 |
| RespawnPeriod | a dead soul is respawned after this many days after death | [days WorldTime] | 7 |
| RespawnPeriodPublicEnemies | see RespawnPeriod, used for souls from factions that are public enemies | [days WorldTime] | 3 |
| CorpseDisappearanceTimeUndiscovered | time before an NPC corpse is hidden when undiscovered | [seconds GameTime] | 3600 |
| CorpseDisappearanceTimeDiscovered | time before an NPC corpse is hidden when discovered | [seconds GameTime] | 300 |
| NPCSpawnMinDistanceFromPlayer | distance from player below which a corpse will never disappear or respawned NPC appear | [m] | 30 |
| StolenGoodsForcedDiscount | price multiplier for when merchant detects that the sold items are stolen | [-] | 0.4 |
| CombatDistanceFromStartPointForForcedUncertain | distance from the point where the combat started beyond which Uncertain is forced | [m] | 500 |
| HorseWithMinStatsPrice | price for a horse with all stats equal to zero | [groshen] | \-1300 |
| HorseWithMaxStatsPrice | price for a horse with all stats equal to the maximum possible stat value | [groshen] | 6000 |
| HorseMinFinalPrice | minimum horse price | [groshen] | 100 |
| TimeBasedAchievementTRCompliantProlongation | after loading a save in which the conditions of a time based achievement are already fulfilled, you must wait this long to unlock the achievement (TRC R4126) | [h] | 1 |
| PerfectionistAchievementIncomeLimit | income needed to unlock Perfectionist achievement | [groshen] | 2000 |
| CompanionMerchantFeeCoeficient | price multiplier representing a percentage fee for the vendor | [-] | 0.5 |
| CompanionPriceReputationScale | reputation multiplier for price when bying/selling a companion | [-] | 0.2 |
| CompanionLegalizationPriceCoeficient | price multiplier for legalization of a companion | [-] | 0.8 |
| DogMoraleDefaultMin | starting value for morale (with lowest hound master skill) | [-] | 0.5 |
| DogMoraleDefaultMax | default dog morale for maximal hound master skill | [-] | 0.85 |
| DogMoraleBuffFeed |  | [mor] | 0.15 |
| DogMoraleBuffPlay |  | [mor] | 0.1 |
| DogMoraleBuffPraise |  | [mor] | 0.1 |
| DogMoraleBuffContextCommand |  | [mor] | 0.01 |
| DogMoraleBuffPOIDiscovery |  | [mor] | 0.05 |
| DogMoraleBuffKill |  | [mor] | 0.05 |
| DogMoraleBuffAnimalKill |  | [mor] | 0.05 |
| DogMoraleBuffFetch |  | [mor] | 0.05 |
| DogMoraleBuffDistraction |  | [mor] | 0.05 |
| DogMoraleBuffSigma |  | [mor] | 0.1 |
| DogMoraleFromHitDamage | morale change for full health damage | [mor] | \-1 |
| DogMoraleEventBuffCooldown | how long it takes to recharge the buff | [s] | 120 |
| DogMoraleDecreaseWithoutInteraction |  | [mor/s] | 0.0005 |
| DogMoraleDecreaseWithoutInteractionFasterRelative | faster fadeout of buffed morale relative to the base speed | [-] | 1.5 |
| DogMoraleIncreaseSkipTime | how fast it grows during skiptime or fast-travel | [mor/s] | 0.00022 |
| DogPOISearchRadiusMin | minimal search radius (for lowest hound-maser) | [m] | 10 |
| DogPOISearchRadiusMax | maximal search radius (for highest hound-maser) | [m] | 35 |
| DogTargetSearchRadiusMin | minimal search radius (for lowest hearing) | [m] | 15 |
| DogTargetSearchRadiusMax | maximal search radius (for highest hearing) | [m] | 30 |
| DogDisobeyTimeout | how long the dog will be unavailable after its morale reaches zero | [s] | 300 |
| DogDisobeyMoraleThreshold | morale must be \<= this value to disobey, set to -1 to disable the feature | [mor] | 0 |
| DogTargetPriorityBoostEnemy | positive number will increase priority | [m] | 45 |
| DogTargetPriorityBoostPrey | positive number will increase priority | [m] | 10 |
| DogTargetPriorityBoostCurrent | implements hysteresis (new target has to have higher priority) | [m] | 5 |
| DogCommandMoraleThreshold | morale must be greater than this value for the dog to obey interactor commands | [-] | 0.3 |
| RiderDogThreatToHorseMoraleRelative | relative to RiderThreatToHorseMorale | [-] | 2 |
| ClinchBackOffDmgRWeight | formula from DLC-8619 |  | 0.1 |
| ClinchBackOffSkillWeight | formula from DLC-8619 |  | 0.1 |
| DogGuardAlarmRadius | Distance from enemy, where dog in Guard mode can start Alarm objective by itself | [m] | 25 |
| DogGuardAttackRadius | Distance from enemy, where dog in Guard mode can start MeleeCombat objective by itself | [m] | 15 |
| DogDistractInitialWaitTime | Time after which the dog starts barking after starting the Distract objective | [s] | 3 |
| DogDistractBarkTime | Time after which the dog spends barking after the initial wait | [s] | 25 |
| DogDistractFleeRadius | If an enemy comes any closer the dog flees. | [m] | 5 |
| DogDistractFleeDistance | The distance the dog flees. | [m] | 100 |
| DogFoundEventHoundmasterXp | Amount of experience the player gets when dog found event during fast travel | [] | 0 |
| DogXpAntiExploitTimeout | After this time the dog XP antiexploit mechanism resets. | [s] | 30 |
| InfoTextNotificationCooldown | cooldown for UI notification | [s] | 30 |
| RPGContextInjuredHealthThreshold | Health threshold that soul is considered as injured | [-] | 50 |
| RPGContextSkillIntervalVariationRelative | Variation of skill intervals when computing current skill | [%] | 0.15 |
| SoulPoolCombatLevelNormalDistributionSigma | Standard deviation of combat level normal distribution when spawning npc from soul pool | [CombatLevel] | 0.03 |
| SchedulerHealPerSecond | Amount of HP healed every second that scheduler healing effect is active. | [HP/s] | 0.1 |
| SchedulerSoilPerSecond | Amount of dirt gained per second through scheduler effect. | [dirt/s] | 3.5e-05 |
| SchedulerDrunkednessPerSecond | Amount of drunkedness gained per second through scheduler effect. | [drunk%/s] | 0.0016 |
| SimpleDrunkednessFadeSpeed | Amount of drunkedness faded per second for SimpleDrunkedness | [drunk%/s] | 0.001 |
| SurvivalSkillXPPerDiscoveredPOI | Amount XP to survival gained for discovering POI | [xp] | 5 |
| MarksmanshipSkillXPShootingTargetHitPerDistance | Amount XP to marksmanship gained for shooting target | [xp] | 1.75 |
| PrimaryStatXPShootingTargetHitPerDistance | Amount XP to primary stat gained for shooting target | [xp] | 1 |
| SecondaryStatXPShootingTargetHitPerDistance | Amount XP to secondary stat gained for shooting target | [xp] | 1 |
| XPShootingTargetHitMinDistance | Minimum distance in which soul get XP for shooting target | [m] | 4 |
| XPShootingTargetHitDistanceMod | XP bonus modifier for distance from shooting target | [m] | 0.5 |
| HardcoreModeHerbCollectingDebuffProbability | Probability of getting a movement speed debuff after collecting herbs | [%] | 0 |
