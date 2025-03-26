
twister = {}

-- data =============================================================
-- ==================================================================

twister.__presets__ = 
{
	['recognition:instant'] = 
	{
		RecognitionTimePCoef = 0,
		RecognitionTimeKPositiveCoef = 0,
		RecognitionTimeKNegativeCoef = 0
	}
}

-- interface ========================================================
-- ==================================================================

-- usage:
-- #twister('recognition:instant')

-- ==================================================================

local metatwister = {}
setmetatable(twister, metatwister)

-- ==================================================================

function metatwister.__call (t, preset)

	local presets = assert(t.__presets__, "Missing preset library.")
	local p = assert(presets[preset], string.format("No data for preset '%s'.", preset))
	
	for const, value in ipairs(p) do
	
		TWarning(string.format("Setting '%s' -> %0.2f", const, value))
	
	end

end