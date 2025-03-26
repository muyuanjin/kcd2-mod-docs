DialogUtils = {}
DialogUtils.dialogParticipant = ''

-- =============================================================================
function DialogUtils.EventChaseCheckItemsOnPlayer()
	local chasingNPC = DialogUtils.dialogParticipant
	local guid = chasingNPC.event_chase_stolenItemGuid
	local amount = chasingNPC.event_chase_stolenItemMissingAmount
	local inv = player.inventory

	if inv:GetCountOfClass(guid) >= amount then
		return 1
	else
		return 0
	end
end

-- =============================================================================
function DialogUtils.ShowPaymentAmount(amount)
	Variables.SetGlobal('dlg_crimeFineAmount', amount)
	Variables.SetGlobal('dlg_crimeFineShown', 1)
end

-- =============================================================================
function DialogUtils.HidePaymentAmount()
	Variables.SetGlobal('dlg_crimeFineShown', 0)
end

-- =============================================================================
function DialogUtils.ProcessPayment(paymentRecipient)
	ItemUtils.MoneyTransaction(player, paymentRecipient, Variables.GetGlobal('dlg_crimeFineAmount') * 10)
end

-- =============================================================================
function DialogUtils.SimpleBribeTransaction(who, money)
	local moneyCount = money or Variables.GetGlobal('shop_input_price')

	ItemUtils.AddMoneyToInventory(who, moneyCount)
	ItemUtils.RemoveMoneyFromInventory(player, moneyCount)
end
SimpleBribeTransaction = DialogUtils.SimpleBribeTransaction

-- =============================================================================
-- Sets up the money selection UI (same is used for placing a bet for a dice minigame for example). The only parameter of the function is table with following members (the columns are name, type, default value, description):
--		minimum							int		5		bottom limit of the slider in Groschens
--		maximum							int		100		top limit of the slider in Groschens (has to be more than minimum)
--		showPaymentIfPlayerLimitFailed	bool	false	if true, the function shows the ui money notification (by calling DialogUtils.ShowPaymentAmount function) if player has less money than specified minimum
--														note that you have to hide the notification by calling DialogUtils.HidePaymentAmount() properly in later sequence
--		limitByNpcEntity				entity	nil		other values than nil are considered to be a valid NPC entity, and the amount of money in its inventory is used as maximum if it is less than the specified maximum
--														(you can get the entity of NPC in the dialog with dc['ROLE'])
--		step							int		5		step for the slider value change in Groschens
--		shopTitleId						int		3		id of the UI string (id is appended to "ui_dialog_input_" string, current values are 1: "Haggling", 2: "Bribery", 3: "Sázka")

-- The function returns true if the setup is ok, and false when there is some error, in which case you should take care not to show the money slider at all (by appropriate entry condition). The function also sets global variable 'shop_slider_setup_result' to value of enum moneySliderSetupResult representing the result of the setup:
--		success					the slider is ready to be shown
--		parametersFail			there is an error in the passed parameters (like maximum being less than minimum)
--		playerLimitFail			if player has less money than the specified minimum the slider wouldn't work correctly
--		npcLimitFail			if limitByNpcEntity is used and the given NPC has less money than the minimum

-- Usage:
--		* first setup the money slider UI by this function in exit script
--		* in the following decision place empty sequence that will invoke the money slider UI (by checking the 'Input' field), make sure that entry condition doesn't allow this sequence to be chosen if there was some error during setup - you can use the alias 'dialogUtils_moneySliderSetupResult_success' for this
--		* you will want to include other sequences in this decision based on the parameters you've used, but at least there should be an option for player not having enough money (because that can always happen unless you set minimum to 0) - for which you can use the alias 'dialogUtils_moneySliderSetupResult_playerLimitFail'
--		* after the 'dialogUtils_moneySliderSetupResult_success' sequence you can use entry condition alias dialogUtils_moneySliderInput_passed which is true if the money selection went through without problem (it hasn't been canceled), and function DialogUtils.GetMoneySliderInputSelectedAmount() which returns the selected value in the UI in tenths of Groschens
--		* if you want player to be informed about the fact he doesn't have enough money (which you generally should), you set 'showPaymentIfPlayerLimitFailed' parameter to true, and put decision after the 'dialogUtils_moneySliderSetupResult_playerLimitFail' sequence with two sequences which will call DialogUtils.HidePaymentAmount() in their exits scripts
-- For an example see the dialog DLC B Turnaj - SAZKA U MLYNARE PESKA (skald://questId=348&sequenceLineId=232619)
function DialogUtils.SetupMoneySlider(params)
	if type(params) ~= 'table' then
		params = {}
	end

	local minimum = params.minimum or 5
	local maximum = params.maximum or 100

	if maximum < minimum then
		Variables.SetGlobal('shop_slider_setup_result', enum_moneySliderSetupResult.parametersFail)
		return false
	end

	if player.inventory:GetMoney() < minimum then
		Variables.SetGlobal('shop_slider_setup_result', enum_moneySliderSetupResult.playerLimitFail)
		if params.showPaymentIfPlayerLimitFailed then
			DialogUtils.ShowPaymentAmount(minimum)
		end
		return false
	end
	maximum = math.min(maximum, player.inventory:GetMoney())

	if params.limitByNpcEntity then
		if params.limitByNpcEntity.inventory:GetMoney() < minimum then
			Variables.SetGlobal('shop_slider_setup_result', enum_moneySliderSetupResult.npcLimitFail)
			return false
		end
		maximum = math.min(maximum, params.limitByNpcEntity.inventory:GetMoney())
	end

	minimum = minimum * 10
	maximum = maximum * 10

	Variables.SetGlobal('shop_min', minimum)
	Variables.SetGlobal('shop_max', maximum)
	Variables.SetGlobal('shop_keeper_price', minimum)
	Variables.SetGlobal('shop_your_price', minimum)
	Variables.SetGlobal('shop_original_price', minimum)
	Variables.SetGlobal('shop_progress', 0)
	Variables.SetGlobal('shop_haggle_step', (params.step or 5) * 10)
	Variables.SetGlobal('shop_title_idx', params.shopTitleId or 3)
	Variables.SetGlobal('shop_slider_setup_result', enum_moneySliderSetupResult.success)
	return true
end

-- =============================================================================
function DialogUtils.MoneySliderSetupResultSuccess()
	if Variables.GetGlobal('shop_slider_setup_result') == enum_moneySliderSetupResult.success then
		return 1
	else
		return 0
	end
end

-- =============================================================================
function DialogUtils.MoneySliderSetupResultPlayerLimitFail()
	if Variables.GetGlobal('shop_slider_setup_result') == enum_moneySliderSetupResult.playerLimitFail then
		return 1
	else
		return 0
	end
end

-- =============================================================================
function DialogUtils.MoneySliderSetupResultNpcLimitFail()
	if Variables.GetGlobal('shop_slider_setup_result') == enum_moneySliderSetupResult.npcLimitFail then
		return 1
	else
		return 0
	end
end

-- =============================================================================
function DialogUtils.GetMoneySliderInputSelectedAmount()
	return Variables.GetGlobal('shop_input_price')
end

-- =============================================================================
function DialogUtils.RequestPlayerMonologByMetarole(metaroleName)
	local messageType = 'dialog:monologRequest'

	XGenAIModule.SendMessageToEntityData(player.this.id, messageType, table.MakeFromType(messageType, { metarole = metaroleName }))
end

-- =============================================================================
-- as of 12.2.2020 we no longer put in decigroschen but regular whole groschen
function DialogUtils.SetupBribe(wholeGroschen)
	local deciGroschen = wholeGroschen * 10
	GameUtils.SetLocalVar('bribe_amount', deciGroschen)
end
SetupBribe = DialogUtils.SetupBribe

function DialogUtils.SetupHaggle(wholeGroschen, playFarewellBark)
	local deciGroschen = wholeGroschen * 10
	local playBark = GameUtils.SetLocalVar('negotiation_play_bark', playFarewellBark)
	GameUtils.SetLocalVar('haggle_amount', deciGroschen)
end
SetupHaggle = DialogUtils.SetupHaggle

-- =============================================================================
function DialogUtils.ShopMoneyTransaction(shopkeeperId, wholeGroschen, playFarewellBark)
	local deciGroschen = wholeGroschen * 10

	Shops.DoMoneyTransaction(shopkeeperId, deciGroschen, playFarewellBark)
	Game.ShowItemsTransfer(ItemUtils.itemIDs.money, -deciGroschen)
end
ShopMoneyTransaction = DialogUtils.MoneyTransaction

-- =============================================================================
function DialogUtils.DialogState(quest, state, result, sync)
	local a, b, soulid
	if sync == 0 then
		soulid = __null
	else
		for a, b in pairs(dc) do
			if b ~= player.this.id then
				soulid = b.this.id
				break
			end
		end
		DialogModule.SetAIInteractionState(soulid, true)
	end
	local target

	if type(quest) == "userdata" then
		target = quest
	else
		target = System.GetEntityByName(quest).this.id
	end
	local msgType = "dialog:state"
	local msgContent = {}
	msgContent.state = state
	msgContent.result = result
	msgContent.id = soulid
	XGenAIModule.SendMessageToEntityData(target, msgType, msgContent)
end
DialogState = DialogUtils.DialogState

-- =============================================================================
function DialogUtils.SkillCheck(skill, level, notify)
	local notifyUI
	if notify ~= false then
		notifyUI = true
	end
	if g_localActor.soul:GetSkillLevel(skill) >= level then
		if notifyUI then
			Game.SendInfoText('@ui_hud_succes')
		end
		return 1
	else
		if notifyUI then
			Game.SendInfoText('@ui_hud_fail')
		end
		return 0
	end
end
SkillCheck = DialogUtils.SkillCheck

-- =============================================================================
-- Functions for persuading in the dialogue
-- Player persuades / threatens NPC
-- Usage:
-- In EXIT SCRIPT:
--     Variables.SetLocal('Success', g_varContext, PersuadeByPlayer(dc.BLACKSMITH));
-- Reaction in ENTRY CONDITION:
--     var('Success')==1
-- 	   var('Success')==0
function DialogUtils.PersuadeByPlayer(who, factor)
	local npcstat = who.soul:GetStatLevel("spc")
	local mystat = g_localActor.soul:GetStatLevel("spc")
	factor = factor or 1.5 -- 1.5 is a magic constant for now (can be tweaked)
	if (mystat / npcstat > factor) then
		Game.ShowStatCheckResult(eSequenceType_Speach, true)
		return 1
	else
		Game.ShowStatCheckResult(eSequenceType_Speach, false)
		return 0
	end
end
PersuadeByPlayer = DialogUtils.PersuadeByPlayer

-- =============================================================================
function DialogUtils.ThreatenByPlayer(who, factor)
	local npcstat = who.soul:GetStatLevel("str")
	local mystat = g_localActor.soul:GetStatLevel("str")
	factor = factor or 1.5 -- 1.5 is a magic constant for now (can be tweaked)
	if (mystat / npcstat > factor) then
		Game.ShowStatCheckResult(eSequenceType_Strength, true)
		return 1 -- 1.5 is a magic constant for now (can be tweaked)
	else
		Game.ShowStatCheckResult(eSequenceType_Strength, false)
		return 0
	end
end
ThreatenByPlayer = DialogUtils.ThreatenByPlayer

-- =============================================================================
-- Impress - using charisma
-- gets number 1-5 ... bigger number means higher charisma is needed
-- returns 0 (fail) or 1 (success)
function DialogUtils.ImpressByPlayer(howmuch)
	local myChar = g_localActor.soul:GetDerivedStat("cha") / 4 -- for now: it is needed 4 overall charisma for every point of "impress"
	if (myChar >= howmuch) then
		Game.ShowStatCheckResult(eSequenceType_Charisma, true)
		return 1
	else
		Game.ShowStatCheckResult(eSequenceType_Charisma, false)
		return 0
	end
end
ImpressByPlayer = DialogUtils.ImpressByPlayer