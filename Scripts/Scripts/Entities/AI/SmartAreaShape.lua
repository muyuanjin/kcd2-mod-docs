SmartAreaShape = {
	type = "SmartAreaShape",
	Properties =
	{
		bSaved_by_game = false,
		sWH_AI_EntityCategory = "",
		guidSmartAreaTemplate = "DEF0005E-0000-0000-0000-DEF00000005E",
		Label = "",
		layerEventLayer = "",
		EventIds = "",
		fEventDespawnDistance = 500,
		guidLocationId = "",

		-- WH [JM] Controls, whether the editor generates automatic
		-- POI for this area. This may only affect some smart
		-- areas depending on the POI generation rules.
		bNo_POI = false,
		-- WH [JM] Controls whether POI generated for this area
    	-- (if no POI is generated for this area, this is ignored)
    	-- is automatically discovered when the players enters the RPG
    	-- location this area is inside (if the area is not inside
    	-- an RPG location, it is, again, ignored).
		bPOI_discoverable_by_location = true,

		Script = {
			Misc = '',
			bValidWithoutTemplate = false,
		}
	},
}

-- =============================================================================
function SmartAreaShape:OnInit()
	CryAction.RegisterWithAI(self.id, AIOBJECT_MOUNTEDWEAPON); -- AIOBJECT_MOUNTEDWEAPON is just na ad-hoc type
end

