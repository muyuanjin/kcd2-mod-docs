
SocialClass =
{
	data = {}
}

-- =============================================================================
SocialClass.defaultValues =
{
	-- Whether the NPC can go to pub in Eater behavior. There is a low chance to choose pub instead of home.
	lunchInPub = true,

	-- For social classes with the 'soldier' crime role, but which should not watch over corpses until the grave-digger arrives
	suppressWatchCorpse = false,

	-- Crime punishment (fine/jail) can be more or less severe for stealing from / assaulting / murdering / etc. particular social classes
	crimePunishmentMultiplier = 1,

	-- Minimum and maximum bet for dice minigame
	diceMinimumBet = 10,
	diceMaximumBet = 1000,

	-- Cumans
	isCuman = false,

	-- When persuading NPC with money to talk to the player even though he has a low reputation, this multiplies the default price
	persuadeToTalkWithLowReputationPriceMultiplier = 1,

	-- Dirt multiplier
	dirtMultiplier = 1,

	-- Whether the NPC will purchase stolen items from player
	dealsWithStolenItems = false,

	-- Never accepts player's surrender
	neverAcceptsSurrender = false,

	-- Identifying NPCs that should be considered wealthy. Values are true or false. Currently used only in bathhouses.
	wealthyCustomer = false,

	-- Greet with wave
	greetMeWithWave = true,
}

-- =============================================================================
function SocialClass.GetSocialClassData (socialClassName)

	return SocialClass.data[socialClassName] or SocialClass.defaultValues

end

-- =============================================================================
function SocialClass.GetEntitySocialClassData (ent)

	return SocialClass.GetSocialClassData(ent.soul:GetSocialClass().Name)

end

-- =============================================================================
local function setSocialClassData (name, values)

	setmetatable(values, { __index = SocialClass.defaultValues })
	SocialClass.data[name] = values

end

setSocialClassData('apothecary', {

	dirtMultiplier = 0,
	persuadeToTalkWithLowReputationPriceMultiplier = 5,
	wealthyCustomer = true,

})

setSocialClassData('armorer', {

	dirtMultiplier = 0.7,
	crimePunishmentMultiplier = 1.5,
	persuadeToTalkWithLowReputationPriceMultiplier = 4,
	wealthyCustomer = true,

})

setSocialClassData('bailiff', {

	dirtMultiplier = 0,
	crimePunishmentMultiplier = 5,
	persuadeToTalkWithLowReputationPriceMultiplier = 5,
	wealthyCustomer = true,

})

setSocialClassData('baker', {

	dirtMultiplier = 0.3,
	persuadeToTalkWithLowReputationPriceMultiplier = 2

})

setSocialClassData('bandit', {

	persuadeToTalkWithLowReputationPriceMultiplier = 2

})

setSocialClassData('bartender', {

	dirtMultiplier = 0.3,
	persuadeToTalkWithLowReputationPriceMultiplier = 3

})

setSocialClassData('bathhouseAbbess', {

	dirtMultiplier = 0,
	persuadeToTalkWithLowReputationPriceMultiplier = 3

})

setSocialClassData('bathhouseMaid', {

	dirtMultiplier = 0,
	persuadeToTalkWithLowReputationPriceMultiplier = 2

})

setSocialClassData('beggar', {

	persuadeToTalkWithLowReputationPriceMultiplier = 0.5

})

setSocialClassData('blacksmith', {

	dirtMultiplier = 0.7,
	crimePunishmentMultiplier = 1.5,
	persuadeToTalkWithLowReputationPriceMultiplier = 3,
	wealthyCustomer = true,

})

setSocialClassData('blacksmithApprentice', {

	dirtMultiplier = 0.7,
	persuadeToTalkWithLowReputationPriceMultiplier = 2

})

setSocialClassData('butcher', {

	dirtMultiplier = 0.5,
	persuadeToTalkWithLowReputationPriceMultiplier = 2

})

setSocialClassData('circator', {

	dirtMultiplier = 0,
	crimePunishmentMultiplier = 2,
	persuadeToTalkWithLowReputationPriceMultiplier = 5

})

setSocialClassData('collier', {

	persuadeToTalkWithLowReputationPriceMultiplier = 1

})

setSocialClassData('craftsman', {

	dirtMultiplier = 0.5,
	persuadeToTalkWithLowReputationPriceMultiplier = 2

})

setSocialClassData('cuman', {

	isCuman = true,
	persuadeToTalkWithLowReputationPriceMultiplier = 2

})

setSocialClassData('renegade', {

	dirtMultiplier = 0.5,

})

setSocialClassData('fake_soldier', {

	dirtMultiplier = 0.5,
	persuadeToTalkWithLowReputationPriceMultiplier = 3

})

setSocialClassData('fightClubFighter', {

	persuadeToTalkWithLowReputationPriceMultiplier = 2

})

setSocialClassData('fortuneTeller', {

	dirtMultiplier = 0.3,
	persuadeToTalkWithLowReputationPriceMultiplier = 1

})

setSocialClassData('herbalist', {

	dirtMultiplier = 0.5,
	persuadeToTalkWithLowReputationPriceMultiplier = 1

})

setSocialClassData('innkeeper', {

	dirtMultiplier = 0.3,
	persuadeToTalkWithLowReputationPriceMultiplier = 3

})

setSocialClassData('lumberjack', {

	persuadeToTalkWithLowReputationPriceMultiplier = 1

})

setSocialClassData('mason', {

	dirtMultiplier = 0.7,
	persuadeToTalkWithLowReputationPriceMultiplier = 1

})

setSocialClassData('mercenary', {

	persuadeToTalkWithLowReputationPriceMultiplier = 3

})

setSocialClassData('merchant', {

	dirtMultiplier = 0,
	crimePunishmentMultiplier = 1.5,
	persuadeToTalkWithLowReputationPriceMultiplier = 3,
	wealthyCustomer = true,

})

setSocialClassData('miller', {

	dirtMultiplier = 0.5,
	persuadeToTalkWithLowReputationPriceMultiplier = 2

})

setSocialClassData('miner', {

	persuadeToTalkWithLowReputationPriceMultiplier = 1

})

setSocialClassData('monk', {

	dirtMultiplier = 0,
	persuadeToTalkWithLowReputationPriceMultiplier = 2

})

setSocialClassData('nobleman', {

	dirtMultiplier = 0,
	lunchInPub = false,
	crimePunishmentMultiplier = 12.5,
	persuadeToTalkWithLowReputationPriceMultiplier = 10,
	wealthyCustomer = true,
	greetMeWithWave = false,

})

setSocialClassData('officer', {

	dirtMultiplier = 0,
	lunchInPub = false,
	suppressWatchCorpse = true,
	crimePunishmentMultiplier = 2.5,
	persuadeToTalkWithLowReputationPriceMultiplier = 6,
	wealthyCustomer = true,

})

setSocialClassData('poacher', {

	persuadeToTalkWithLowReputationPriceMultiplier = 1

})

setSocialClassData('priest', {

	dirtMultiplier = 0,
	crimePunishmentMultiplier = 1.5,
	persuadeToTalkWithLowReputationPriceMultiplier = 5

})

setSocialClassData('quarryman', {

	persuadeToTalkWithLowReputationPriceMultiplier = 1

})

setSocialClassData('renegade', {

	neverAcceptsSurrender = true

})

setSocialClassData('refugee', {

	persuadeToTalkWithLowReputationPriceMultiplier = 0.5

})

setSocialClassData('ruffian', {

	persuadeToTalkWithLowReputationPriceMultiplier = 1

})

setSocialClassData('scribe', {

	dirtMultiplier = 0,
	persuadeToTalkWithLowReputationPriceMultiplier = 4,
	wealthyCustomer = true,

})

setSocialClassData('security', {

	dirtMultiplier = 0.5,
	persuadeToTalkWithLowReputationPriceMultiplier = 5,
	neverAcceptsSurrender = true

})

setSocialClassData('shoemaker', {

	dirtMultiplier = 0.3,
	persuadeToTalkWithLowReputationPriceMultiplier = 3

})

setSocialClassData('shootmaster', {

	dirtMultiplier = 0.5,
	persuadeToTalkWithLowReputationPriceMultiplier = 3

})

setSocialClassData('soldier', {

	dirtMultiplier = 0.5,
	crimePunishmentMultiplier = 2.5,
	persuadeToTalkWithLowReputationPriceMultiplier = 3

})

setSocialClassData('tailor', {

	dirtMultiplier = 0.3,
	persuadeToTalkWithLowReputationPriceMultiplier = 3

})

setSocialClassData('tanner', {

	dirtMultiplier = 0.7,
	persuadeToTalkWithLowReputationPriceMultiplier = 2

})

setSocialClassData('townsman', {

	dirtMultiplier = 0,
	persuadeToTalkWithLowReputationPriceMultiplier = 3

})

setSocialClassData('villager', {

	dirtMultiplier = 0.7,
	persuadeToTalkWithLowReputationPriceMultiplier = 1

})

setSocialClassData('wanderer', {

	persuadeToTalkWithLowReputationPriceMultiplier = 1

})

setSocialClassData('watchman', {

	dirtMultiplier = 0.5,
	crimePunishmentMultiplier = 2.5,
	persuadeToTalkWithLowReputationPriceMultiplier = 3

})

setSocialClassData('weaponsmith', {

	dirtMultiplier = 0.7,
	crimePunishmentMultiplier = 1.5,
	persuadeToTalkWithLowReputationPriceMultiplier = 4,
	wealthyCustomer = true,

})