-- =============================================================================
-- There was an entity of type "DialogTrigger" accidentaly left in level.
-- It is an obsolete entity class, which should not be used anymore.
-- However, it causes crash on load, therefore this entity class defitinion was created,
-- the entity now loads corretly, doesn't do anything, and won't be saved next time
-- =============================================================================

DialogTrigger = {

	Properties =
	{
		bSaved_by_game = false,
	},
}