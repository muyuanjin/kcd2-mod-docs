
Crime = {}
-- =============================================================================
function Crime.SendSurrenderDialogResult (dc, action)
	local entity = (dc['HRAC_SE_MI_VZDAVA_V_COMBATU']).this.id
	local type = 'crime:playerSurrenderDialogFeedback'
	local content = { action = action }
	XGenAIModule.SendMessageToEntityData(entity, type, content)
end

-- =============================================================================
function Crime.SendSurrenderChatResult (entity, action)
	local type = 'crime:playerSurrenderChatFeedback'
	local content = { action = action }
	XGenAIModule.SendMessageToEntityData(entity, type, content)
end

-- =============================================================================
function Crime.SendCombatChatResult (dc, action)
	local entity = (dc['OPONENT_V_COMBATU']).this.id
	local type = 'combat:combatChatFeedback'
	local content = { action = action }
	XGenAIModule.SendMessageToEntityData(entity, type, content)
end

-- =============================================================================
function Crime.SendFriskChatResult (dc, action)
	local entity = (dc['STRAZ_VYZYVA_K_FRISKU']).this.id
	local type = 'crime:friskChatFeedback'
	local content = { action = action }
	XGenAIModule.SendMessageToEntityData(entity, type, content)
end

-- =============================================================================
function Crime.SendFriskDialogResult (dc, action)
	local entity = (dc['STRAZ_FRISK']).this.id
	local type = 'crime:friskDialogFeedback'
	local content = { action = action }
	XGenAIModule.SendMessageToEntityData(entity, type, content)
end

-- =============================================================================
function Crime.SendResolveDialogResult (dc, action)
	local guard = dc['STRAZNY_ZATYKANI'] or dc['STRAZ_V_ZIKMUNDOVE_TABORE']
	local entity = guard.this.id
	local type = 'crime:resolveDialogFeedback'
	local content = { action = action }
	XGenAIModule.SendMessageToEntityData(entity, type, content)
end

-- =============================================================================
function Crime.SendOffenceChatAction (dc, action)
	local entity = (dc['HENRY']).this.id
	local type = 'crime:offenceChatFeedback'
	local content = { action = action }
	XGenAIModule.SendMessageToEntityData(entity, type, content)
end

-- =============================================================================
function Crime.SendCampTrespassChatResult (dc, action)
	local entity = (dc['PRATELSKY_NEPRITEL_VYHANI_HRACE']).this.id
	local type = 'crime:campTrespassChatFeedback'
	local content = { action = action }
	XGenAIModule.SendMessageToEntityData(entity, type, content)
end

-- =============================================================================
function Crime.SendSelfhelpChatResult (dc, action)
	for key, value in pairs(dc) do
		if key:find('^SVEPOMOC') ~= null then
	    	local entity = value.this.id
			local type = 'crime:selfhelpChatFeedback'
			local content = { action = action }
			XGenAIModule.SendMessageToEntityData(entity, type, content)
	    	break
		end
	end
end

-- =============================================================================
function Crime.SendSelfhelpResolveDialogResult (dc, action)
	for key, value in pairs(dc) do
		if key:find('^SVEPOMOC') ~= null then
			local entity = value.this.id
			local type = 'crime:selfhelp_resolveDialogFeedback'
			local content = { action = action }
			XGenAIModule.SendMessageToEntityData(entity, type, content)
			break
	 	end
	end
end

-- =============================================================================
-- IMPORTANT! make sure to reflect changes to skald module GetDenialDialogPriceMultiplier aswell!
function Crime.GetStatusMultiplier (key)
	local values =  {
		['negative'] = 0.5,
		['low'] = 1.5,
		['high'] = 2,
		['veryHigh'] = 6
	}
	return values[key]
end

-- =============================================================================
function Crime.GetSkillcheckLevelFromPrice (price) -- price is fine value in decigroschen
	if(price < 500 )then
	return 1
	elseif(price < 1000)then
	return 2
	elseif(price < 1500)then
	return 3
	elseif(price < 7500)then
	return 4
	elseif(price < 20000)then
	return 5
	else
	return 6
	end
end

-- =============================================================================
function Crime.ProduceAiSoundOnDudePosition (soundKind, multiplier)
	XGenAIModule.ProduceSoundWUID(soundKind, player.this.id, multiplier)
end

-- =============================================================================
-- Lockpick prompts
function Crime.BuildLockpickPromptStrName (lockDifficulty)

	local levels =
	{
		-- WARNING: if you change the numbers here, change also gs_DifficultyTreshold*** in LockPicking.h
		{ minLockDifficulty = 0.8, strName = 'ui_hud_lockpick_difficulty_5' },
		{ minLockDifficulty = 0.6, strName = 'ui_hud_lockpick_difficulty_4' },
		{ minLockDifficulty = 0.4, strName = 'ui_hud_lockpick_difficulty_3' },
		{ minLockDifficulty = 0.2, strName = 'ui_hud_lockpick_difficulty_2' },
		{ minLockDifficulty = 0, strName = 'ui_hud_lockpick_difficulty_1' }
	}

	for _, level in ipairs(levels) do

		if lockDifficulty >= level.minLockDifficulty then

			return level.strName

		end

	end

	-- Fallback, but this shouldn't happen
	return 'ui_hud_lockpick'

end

-- =============================================================================
function Crime.DetermineSuspiciousDealReaction (entity)

	local reaction = Variables.GetGlobal('haggle_suspiciousness_reaction')

	local socialClassData = SocialClass.GetEntitySocialClassData(entity)
	local dealsWithStolenItems = socialClassData.dealsWithStolenItems

	if reaction > 0 then

		local reaction = Pick(dealsWithStolenItems, 1, 2)
		Variables.SetGlobal('haggle_suspiciousness_reaction', reaction)

	end

end