-- =============================================================================
-- Entity defining properties for playing animation and barking at the same time, derived from SmartObjectHolder
-- =============================================================================

SO_AnimationAndBark =
{
	Properties =
	{
		Animation =
		{
			sAnimationFragment = '',
      sAnimationTags = ''
    },
    Bark = 
    {
      sAlias = ''
		}
	}
}

-- =============================================================================
-- Compose entity
-- =============================================================================
Script.ReloadScript( "Scripts/Entities/WH/Others/SmartObjectHolder.lua" )
table.Merge(SO_AnimationAndBark, SmartObjectHolder)