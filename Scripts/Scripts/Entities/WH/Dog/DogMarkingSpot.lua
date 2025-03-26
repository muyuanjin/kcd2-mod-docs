Script.ReloadScript( "Scripts/Entities/WH/Others/SmartObjectHolder.lua" )

DogMarkingSpot =
{
	Properties =
	{
		bSaved_by_game = false,
		bExported_to_game = false, -- Dog points are only exported as non-so points
        object_editorModel ="objects/helpers/dog/dog_marking.cgf",
		soclass_SmartObjectHelpers = "dogMarkPoint",
		guidSmartObjectType = "99b89107-acd5-4d85-8930-7dd1f5f8c864",
	},

	Editor={
		Icon = "smartObjectHolder.bmp",
		 IconOnTop=1,
	},
}

-- =============================================================================
-- Compose entity
-- =============================================================================
EntityCommon.DeriveOverride( DogMarkingSpot, SmartObjectHolder )