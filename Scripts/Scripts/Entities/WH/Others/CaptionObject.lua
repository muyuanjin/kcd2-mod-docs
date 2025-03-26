CaptionObject = {

	Properties={
		sWH_AI_EntityCategory = "",
		object_Model = "objects/editor/box_nodraw.cgf",
		sFlagMessage = "",
		Scale = { x=1.0,y=1.0,z=1.0 },
	},

	Editor={
		Icon = "Comment.bmp",
		IconOnTop = 1,
	},

	bDiscovered = false,
}

-- =============================================================================
function CaptionObject:OnLoad(t)
	self.bDiscovered = t.discovered
end

-- =============================================================================
function CaptionObject:OnSave(t)
	t.discovered = self.bDiscovered
end

-- =============================================================================
function CaptionObject:OnSpawn()
	self:LoadModel()
end

-- =============================================================================
function CaptionObject:Reset()
	self:LoadModel()
	self.bDiscovered = false
end

-- =============================================================================
function CaptionObject:OnPropertyChange()
	self:LoadModel()
end

-- =============================================================================
function CaptionObject:LoadModel()
	if( self.Properties.object_Model ~= "" ) then
		self:LoadObject( 0, self.Properties.object_Model )
		self:SetSlotScaleAsymmetric( 0, self.Properties.Scale.x, self.Properties.Scale.y, self.Properties.Scale.z )
	end
end

-- =============================================================================
function CaptionObject:IsCrossCenteringEnabled()
	return false
end

-- =============================================================================
function CaptionObject:GetUsableName(slot)
	return self.Properties.sFlagMessage
end

-- =============================================================================
function CaptionObject:GetActions(user, firstFast)
	if( self.Properties.sFlagMessage ~= "" ) then
		output = {}

		local text = user.soul:GetReadCaptionObjectText()

		AddInteractorAction( output, firstFast, Action():hint( text ):action( "use" ):func( CaptionObject.OnUsed ):interaction( inr_captionRead ) )
		return output
	else
		return {}
	end
end

-- =============================================================================
function CaptionObject:OnUsed()
	Game.ShowCaptionObjectMessage( self.Properties.sFlagMessage )
	RPG.CaptionObjectUsed( self.id, self.bDiscovered)
	self.bDiscovered = true
end
