function _IHint( self, hint )
	self._hint = hint
	return self
end

function _IAction( self, action )
	self._action = action
	return self
end

function _IType( self, hintType )
	self._type = hintType
	return self
end

function _IClass( self, hintClass )
	self._class = hintClass
	return self
end

function _IEnabled( self, enabled )
	self._enabled = enabled
	return self
end

function _IFunc( self, func )
	self._func = func
	return self
end

function _IUiOrder( self, order )
	self._order = order
	return self
end

function _IActionMap( self, map )
	self._actionMap = map
	return self
end

function _IInteraction( self, interaction )
	self._interaction = interaction
	return self
end

function _IReason( self, reason )
	self._reason = reason
	return self
end

function _IDisabledBarkMetarole( self, disabledBarkMetarole )
	self._disabledBarkMetarole = disabledBarkMetarole
	return self
end

function _IUiVisible( self, uiVisible )
	self._uiVisible = uiVisible
	return self
end

-- =============================================================================
function Action()
	inst =
	{
		-- methods
		hint = _IHint,				 -- hint( "@talk" )
		action = _IAction,			 -- action( "use" )
		actionMap = _IActionMap,	 -- actionMap( "player" )
		hintType = _IType,			 -- hintType( AHT_PRESS ) or hintType( AHT_RELEASE ) or hintType( AHT_HOLD )
		hintClass = _IClass,		 -- hintClass( AHC_BASIC ) or hintClass( AHC_DOG )
		enabled = _IEnabled,		 -- enabled( true )
		reason = _IReason,			 -- reason( "@not_enough_minerals" )
		disabledBarkMetarole = _IDisabledBarkMetarole, -- disabledBarkMetarole ( "HRAC_UZ_NEMUZE_JIST_Z_KOTLIKU_HRAC_JE_PLNY")
		func = _IFunc,				 -- func( self.OnUsed )
		uiOrder = _IUiOrder,		 -- uiOrder( 0 )
		interaction = _IInteraction, -- interaction( inr_talk ) 	-- a name defined in Data/Libs/Config/interaction_filter.xml in <interactions></interactions> element prefixed with "inr_" NOT a string
		uiVisible = _IUiVisible, 	 -- uiVisible( true )
	}

	return inst
end

-- =============================================================================
function AddInteractorAction( output, firstFast, action )
	output[#output+1] =
	{
		hint = action._hint,
		action = action._action,
		actionMap = action._actionMap,
		enabled = action._enabled,
		hintType = action._type,
		hintClass = action._class,
		func = action._func,
		uiOrder = action._order,
		interactionName = action._interaction,
		reason = action._reason,
		disabledBarkMetarole = action._disabledBarkMetarole,
		uiVisible = action._uiVisible
	}

	return firstFast
end

-- =============================================================================
-- Entity action: just adds new action to output
function AddAction(output, firstFast, hintVal, actionVal, hintTypeVal, enabledVal, funcVal, priorityVal, actionMapVal)
	output[#output+1] =
	{
		hint = hintVal,
		action = actionVal,
		actionMap = actionMapVal,
		enabled = enabledVal,
		hintType = hintTypeVal,
		func = funcVal,
		priority = priorityVal,
		interactionName = nil,
		reason = nil,
		disabledBarkMetarole = nil,
		uiVisible = true
	}

	return firstFast
end
