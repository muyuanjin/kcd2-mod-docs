-- Smart object representing a place where stance can be played
-- Intended for sitting and lying stance both for NPCs and player. 
-- (I.e. benches, chairs, beds, ....)


StanceSmartObject =
{
	Properties =
	{
		Script = {
			Misc = '',
			esBedTypes = 'bench',
		},

		Bed =
		{
			esSleepQuality = "none",
			esReadingQuality = "none",
		},

	},
}




-- =============================================================================
-- Compose entity
-- =============================================================================
Script.ReloadScript( "Scripts/Entities/WH/Others/SmartObjectHolder.lua" )
table.Merge(StanceSmartObject, SmartObjectHolder)
