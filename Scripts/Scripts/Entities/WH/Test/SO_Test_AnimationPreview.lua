-- =============================================================================
-- Template entity for testing animation previews, derived from SmartObjectHolder
-- =============================================================================

SO_Test_AnimationPreview =
{
	Properties =
	{
		AnimationPreview = {
            bAligned = false,
			sOneshot_Animation_Fragment = "",
			sOneshot_Animation_Tags = "",
			bSitting = false,
            sUnstance_Name = "",
		},
	},
}

-- =============================================================================
-- Compose entity
-- =============================================================================
Script.ReloadScript( "Scripts/Entities/WH/Others/SmartObjectHolder.lua" )
EntityCommon.DeriveOverride( SO_Test_AnimationPreview, SmartObjectHolder )
