-- this entity is dummy for smart object which cannot be attached to real geometry

SmartObjectHolder =
{
	Properties =
	{
		object_editorModel = "",
        bSaved_by_game = false,
		sWH_AI_EntityCategory = "",
		guidSmartObjectType = "DEF0005E-0000-0000-0000-DEF00000005E",
		soclass_SmartObjectHelpers = "",

		-- WH [JM] Controls, whether the editor generates automatic
		-- POI for this area. This may only affect some smart
		-- areas depending on the POI generation rules.
    	bNo_POI = false,
		-- WH [JM] Controls whether POI generated for this object
		-- (if no POI is generated for this object, this is ignored)
		-- is automatically discovered when the players enters the RPG
		-- location this object is inside (if the object is not inside
		-- an RPG location, it is, again, ignored).
		bPOI_discoverable_by_location = true,

		bOwnedByHome = false, -- Automatically create an ownership link from home if placed in one

		Script = {
			Misc = ''
		},
	},

	Editor =
	{
		Icon = "smartObjectHolder.bmp"
	},
}

-- =============================================================================
function SmartObjectHolder:GetEditorModel()
    return self.Properties.object_editorModel
end

-- =============================================================================
function SmartObjectHolder:OnInit()
	self:CreateBBoxProxy(); -- we need explicit bbox, this entity should be active for player
end