-- keep in sync with C_DialogInstance::E_HaggleReason (DialogInstance.h)
NegotiationReason = Enum.new
{
	Haggle      = { index = 1 },
	Bribe       = { index = 2 },
	Sleepover   = { index = 3 },
	Trainer     = { index = 4 },
	Bathhouse   = { index = 5 },
}

NegotiationReactionKind = Enum.new
{
	Accept  = { index = 1 },
	Counter = { index = 2 },
	Mock    = { index = 3 },
	Refuse  = { index = 4 }
}

NegotiationOrientation = Enum.new
{
	PlayerBuysOnly = {},
	PlayerSellsOnly = {},
	Barter = {}
}

-- =============================================================================
-- Negotiation proposition
-- =============================================================================
NegotiationProposition = {}
NegotiationProposition.__index = NegotiationProposition

-- =============================================================================
function NegotiationProposition.new (price, impatience)

	local new = {}
	setmetatable(new, NegotiationProposition)

	new.price = price
	new.impatience = impatience

	return new

end

-- =============================================================================
function NegotiationProposition:GetPrice()

	return self.price

end

-- =============================================================================
function NegotiationProposition:GetImpatience()

	return self.impatience

end

-- =============================================================================
-- Negotiation
-- =============================================================================
Negotiation = {}
Negotiation.__index = Negotiation

-- =============================================================================
function Negotiation.new (merchant)

	local new = {}
	setmetatable(new, Negotiation)

	new.merchant = assert(merchant)
	new.impatience = 0
	new.round = 1

	new:Init()

	return new

end

-- =============================================================================
-- Init
-- =============================================================================
function Negotiation:Init()

	local playerBuysValue        = GameUtils.GetLocalVar('negotiation_input_playerBuysValue')
	local playerSellsValue       = GameUtils.GetLocalVar('negotiation_input_playerSellsValue')
	local suspiciousness         = GameUtils.GetLocalVar('negotiation_input_basketSuspiciousness')
	local suspiciousnessReaction = GameUtils.GetLocalVar('negotiation_input_basketSuspiciousness_reaction')

	self.playerBuysValue = playerBuysValue
	self.playerSellsValue = playerSellsValue

	self:RecalcIntermediateValues()

	self.suspiciousness = suspiciousness
	if suspiciousnessReaction > 0 then

		self:RecalcPlayerSellsValue()

	end

	self.step = self:CalcStep()
	self.basePrice = self:Round(self.basePrice, self.step)

	if playerBuysValue > 0 and playerSellsValue > 0 then
		self.orientation = NegotiationOrientation.Barter
	end

	if playerBuysValue > 0 and playerSellsValue <= 0 then
		self.orientation = NegotiationOrientation.PlayerBuysOnly
	end

	if playerBuysValue <= 0 and playerSellsValue > 0 then
		self.orientation = NegotiationOrientation.PlayerSellsOnly
	end

	local reason = Variables.GetGlobal('negotiation_input_reason')
	self.reason = NegotiationReason:FromIndex(reason)

	self.playerMoney = self:GetPlayerMoney()
	self.merchantMoney = self:GetMerchantMoney()

	self.secondChancesPerks = {}
	self.secondChances = player.soul:GetDerivedStat('hac', {}, self.secondChancesPerks)

end

-- =============================================================================
function Negotiation:RecalcPlayerSellsValue()

	local merchant = self.merchant
	local playerSellsValue = self.playerSellsValue
	local volume = self.volume
	local suspiciousness = self.suspiciousness

	local suspiciousnessFactor = 1
	local dominance = self:CalcDominance()

	newPlayerSellsValue = playerSellsValue * RPG.StolenGoodsForcedDiscount
	newImpatience = 0.15 - dominance * 0.1

	self.playerSellsValue = newPlayerSellsValue
	self.impatience = newImpatience

	self:RecalcIntermediateValues()

end

-- =============================================================================
function Negotiation:RecalcIntermediateValues()

	self.basePrice = self.playerBuysValue - self.playerSellsValue
	self.volume = self.playerBuysValue + self.playerSellsValue

end

-- =============================================================================
function Negotiation:CalcStep()

	local volume = self.volume

	if volume < 100 then
		return 1
	end

	if volume < 500 then
		return 5
	end

	if volume < 1000 then
		return 10
	end

	if volume < 5000 then
		return 50
	end

	return 100

end

-- =============================================================================
-- Calculations
-- =============================================================================
function Negotiation:CalcReaction (proposedPlayerPrice)

	local merchant = self.merchant
	local basePrice = self.basePrice
	local lastMerchantPrice = self.lastMerchantPrice
	local lastPlayerPrice = self.lastPlayerPrice
	local impatience = self.impatience
	local volume = self.volume
	local suspiciousness = self.suspiciousness
	local round = self.round

	-- The player has proposed a price equal to or better
	-- than the merchant's previous offer: auto accept.
	if proposedPlayerPrice >= self.lastMerchantPrice then

		return NegotiationReactionKind.Accept

	end

	-- In second and later rounds: If the player makes the same  proposition
	-- than the last time, the merchant just mocks his weird haggling manners.
	if round > 1 and proposedPlayerPrice == self.lastPlayerPrice then

		local newImpatience = self.impatience + 0.3
		if self:CheckImpatienceOverLimit(newImpatience) then

			if self:HasSecondChance() then

				self:SpendSecondChance()

			else

				return NegotiationReactionKind.Refuse

			end

		end

		local proposition = NegotiationProposition.new(lastMerchantPrice, newImpatience)
		return NegotiationReactionKind.Mock, proposition

	end

	-- Merchant approaches the proposition.
	local priceRatio = self:CalcPriceRatio()
	local newMerchantPrice = self:Round(math.Lerp(lastMerchantPrice, proposedPlayerPrice, priceRatio), self.step)

	-- In case the merchant's and player's proposed prices
	-- are now within tolerance, accept the player's proposition.
	local acceptableTolerance = self:CalcAcceptableTolerance()
	if (newMerchantPrice - proposedPlayerPrice) / volume <= acceptableTolerance then

		return NegotiationReactionKind.Accept
	end

	-- If player has perk silver tongue raise tolerance by 2.5% of price
	local hasSilverTongue = player.soul:HasPerk("a7096e82-8e3d-4325-9552-6827374697cd", false)
	if hasSilverTongue and (newMerchantPrice - proposedPlayerPrice) / volume <= 0.025 + acceptableTolerance then
		return NegotiationReactionKind.Accept
	end
	
	-- Increase impatience (based on the player's proposition)
	local k = 5
	local inc = math.pow((lastMerchantPrice - proposedPlayerPrice) / (volume / k), 2) / k
	local impatienceIncMod = self:CalcImpatienceIncMod()
	local newImpatience = impatience + inc * impatienceIncMod

	-- Increase impatience (based on current impatience)
	local impatiencePerRoundExp = 0.4
	newImpatience = math.pow(newImpatience, impatiencePerRoundExp)

	-- Check whether the impatience is high enough to leave the negotation
	if self:CheckImpatienceOverLimit(newImpatience) then

		if self:HasSecondChance() then

			self:SpendSecondChance()

		else

			return NegotiationReactionKind.Refuse

		end

	end

	-- In case merchant can't go down without reaching player's proposition
	-- refuse haggling further
	if (newMerchantPrice - proposedPlayerPrice) <= self.step then

		return NegotiationReactionKind.Accept

	end

	local proposition = NegotiationProposition.new(newMerchantPrice, newImpatience)
	return NegotiationReactionKind.Counter, proposition

end

-- =============================================================================
function Negotiation:HasSecondChance()

	return self.secondChances > 0

end

-- =============================================================================
function Negotiation:SpendSecondChance()

	self.merchant.soul:ModifyPlayerReputation("haggle_fail", 1) -- KCD2-129739 Final offer exploit
	
	self.secondChances = self.secondChances - 1

	for _, secondChancePerk in ipairs(self.secondChancesPerks or {}) do

		player.soul:HasPerk(secondChancePerk, true)

	end

end

-- =============================================================================
function Negotiation:CheckImpatienceOverLimit (impatience)

	local impatienceLimit = 0.75
	local impatienceHardLimit = 0.95

	if impatience > impatienceLimit then

		local chance = math.pow((impatience - impatienceLimit) / (1 - impatienceLimit), 0.75)
		if impatience >= impatienceHardLimit or math.random() > chance then

			return true

		end

	end

	return false

end

-- =============================================================================
-- Returns value in [-1; 1]:
-- -1: Merchant has the maximum possible barter dominance.
-- +1: Dude has the maximum possible barter dominance.
function Negotiation:CalcDominance()

	local merchant = self.merchant
	return player.soul:CalculateBarterDominance(merchant.this.id)

end

-- =============================================================================
-- Returns value in [0; 1]:
-- The coeficient for the linear interpolation between
-- the merchant's last price and player's proposition.
function Negotiation:CalcPriceRatio()

	local dominance = self:CalcDominance()
	return 0.35 + dominance * 0.15

end

-- =============================================================================
function Negotiation:CalcImpatienceIncMod()

	local dominance = self:CalcDominance()
	return math.pow(1.75 - dominance * 0.5, 1.15)

end

-- =============================================================================
function Negotiation:CalcAcceptableTolerance()

	local dominance = self:CalcDominance()
	return 0.025 + dominance * 0.025

end

-- =============================================================================
-- Dialog interface
-- =============================================================================
function Negotiation:InitControls()

	local minPrice
	local maxPrice

	local maxTipFactor = 0.15
	local bestImprovementFactor = 0.35

	if self.orientation == NegotiationOrientation.PlayerBuysOnly then

		minPrice = self.playerBuysValue * (1 - bestImprovementFactor)
		maxPrice = self.playerBuysValue * (1 + maxTipFactor)

	end

	if self.orientation == NegotiationOrientation.PlayerSellsOnly then

		minPrice = -self.playerSellsValue * (1 + bestImprovementFactor)
		maxPrice = -self.playerSellsValue * (1 - maxTipFactor)

	end

	if self.orientation == NegotiationOrientation.Barter then

		minPrice = self.basePrice - self.volume * bestImprovementFactor
		maxPrice = self.basePrice + self.volume * bestImprovementFactor

	end

	-- Player has even less money than the lower limit;
	-- we need to move the lower limit, so that we can show their marker.
	if self.playerMoney < minPrice then

		minPrice = self.playerMoney * 0.85

	end

	-- Merchant has even less money than the upper limit;
	-- we need to move the upper limit, so that we can even show their marker.
	if -self.merchantMoney > maxPrice then

		maxPrice = -self.merchantMoney * 0.85

	end

	minPrice = self:Round(minPrice, self.step)
	maxPrice = self:Round(maxPrice, self.step)

	if minPrice == maxPrice then

		minPrice = minPrice - self.step
		maxPrice = maxPrice + self.step

		if self.orientation == NegotiationOrientation.PlayerBuysOnly then
			minPrice = math.max(1, minPrice)
		end

		if self.orientation == NegotiationOrientation.PlayerSellsOnly then
			maxPrice = math.min(-1, maxPrice)
		end

	end

	Variables.SetGlobal('shop_min', minPrice)
	Variables.SetGlobal('shop_max', maxPrice)

end

-- =============================================================================
function Negotiation:InitDominance()

	local dominance = self:CalcDominance()
	Variables.SetGlobal('negotiation_dominance', dominance)

end

-- =============================================================================
function Negotiation:OpenWithBaseProposition()

	local price = self.basePrice

	self.lastMerchantPrice = price
	self.lastPlayerPrice = price

	self:UpdateUiState()

end

-- =============================================================================
function Negotiation:ReactToPlayerProposition()

	local proposedPlayerPrice = Variables.GetGlobal('shop_input_price')
	local reaction, proposition = self:CalcReaction(proposedPlayerPrice)

	Variables.SetGlobal('negotiation_playerReaction_accept', 0)
	Variables.SetGlobal('negotiation_merchantReaction_kind', reaction.index)
	Variables.SetGlobal('negotiation_merchantReaction_round', self.round)

	-- Accept:
	if reaction == NegotiationReactionKind.Accept then

		Variables.SetGlobal('negotiation_playerReaction_accept', Pick(proposedPlayerPrice == self.lastMerchantPrice, 1, 0))
		Variables.SetGlobal('negotiation_merchantReaction_tip', Pick(proposedPlayerPrice > self.basePrice, 1, 0))

		GameUtils.SetLocalVar('negotiation_result_price', proposedPlayerPrice)

	end

	-- Counter / Mock:
	if reaction == NegotiationReactionKind.Counter or reaction == NegotiationReactionKind.Mock then

		if reaction == NegotiationReactionKind.Counter then

			local divergence = (proposition:GetPrice() - proposedPlayerPrice) / self.volume
			local divergenceRank = Pick(divergence < 0.1, 1, Pick(divergence < 0.35, 2, 3))
			Variables.SetGlobal('negotiation_merchantReaction_divergence', divergenceRank)

			-- +1: Player's proposal is "too low"
			-- -1: Player's proposal is "too high"
			Variables.SetGlobal('negotiation_merchantReaction_orientation', Pick(proposedPlayerPrice >= 0, 1, -1))

		end

		self.lastPlayerPrice = proposedPlayerPrice
		self.lastMerchantPrice = proposition:GetPrice()
		self.impatience = proposition:GetImpatience()

		self:UpdateUiState()

	end

	self.round = self.round + 1

end

-- =============================================================================
-- Utils
-- =============================================================================
function Negotiation:UpdateUiState()

	Variables.SetGlobal('shop_haggle_step', self.step)
	Variables.SetGlobal('shop_keeper_price', math.max(self.lastMerchantPrice, -self.merchantMoney))
	Variables.SetGlobal('shop_your_price', math.Clamp(self.lastPlayerPrice, -self.merchantMoney, self.playerMoney))
	Variables.SetGlobal('shop_progress', self.impatience)
	Variables.SetGlobal('shop_original_price', self.basePrice)

end

-- =============================================================================
function Negotiation:Round (value, unit, direction)

	if value % unit < unit/2 then

		return math.floor(value / unit) * unit

	else

		return math.ceil(value / unit) * unit

	end

end

-- =============================================================================
-- Additional input
-- =============================================================================
function Negotiation:GetPlayerMoney()

	return player.inventory:GetMoney() * 10

end

-- =============================================================================
function Negotiation:GetMerchantMoney()

	-- Reason: Haggle
	if self.reason == NegotiationReason.Haggle then

		if Shops.GetShopDBIdByKeeper(self.merchant.id) >= 0 then

			return Shops.GetShopMoney(self.merchant.id)

		end

	end

	-- Reason in which the NPC sells, and so we don't care about their balance
	if self.reason == NegotiationReason.Sleepover or self.reason == NegotiationReason.Trainer or self.reason == NegotiationReason.Bathhouse then

		return 0

	end

	-- Return personal cash on person
	return self.merchant.inventory:GetMoney() * 10

end

-- =============================================================================
-- Utils
-- =============================================================================
NegotiationUtils = {}

-- =============================================================================
function NegotiationUtils.SetupNegotiation (reason, playerBuysValue, playerSellsValue, basketSuspiciousness, basketSuspiciousness_reaction)

	Variables.SetGlobal('negotiation_input_reason', reason.index)

	GameUtils.SetLocalVar('negotiation_input_playerBuysValue', playerBuysValue)
	GameUtils.SetLocalVar('negotiation_input_playerSellsValue', playerSellsValue)

	GameUtils.SetLocalVar('negotiation_input_basketSuspiciousness', basketSuspiciousness)
	GameUtils.SetLocalVar('negotiation_input_basketSuspiciousness_reaction', basketSuspiciousness_reaction)

end

-- =============================================================================
function NegotiationUtils.PlayTransactionSound()

	AudioUtils.PlayAudioTrigger(player, 'ui_inv_trade_success')

end

-- =============================================================================
-- Debug
-- =============================================================================
--WH_NOMASTER_START
--[[
function NegotiationUtils.dumpVars()

	local function showVar (name)

		TError(StrFormat('%s: %d', name, Variables.GetGlobal(name)))

	end

	showVar('haggle_playerSellsValue')
	showVar('haggle_playerBuysValue')
	showVar('haggle_suspiciousness')
	showVar('haggle_suspiciousness_reaction')

	showVar('shop_min')
	showVar('shop_max')
	showVar('shop_haggle_step')
	showVar('shop_keeper_price')
	showVar('shop_your_price')
	showVar('shop_progress')
	showVar('shop_original_price')
	showVar('shop_title_idx')

end

]]--
--WH_NOMASTER_END