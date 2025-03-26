TimeUtils = {}

-- =============================================================================
-- Sets calendar time (decimal in hours)
function TimeUtils.ForwardTime(time)
	if not time then
		return false
	end
	local targetTime_abs = time * 3600
	local currentTime = Calendar.GetWorldTime()
	local currentTime_abs = currentTime % 86400

	if targetTime_abs >= currentTime_abs then
		Calendar.SetWorldTime(currentTime + (targetTime_abs - currentTime_abs))
	else
		Calendar.SetWorldTime(currentTime + (86400 + targetTime_abs - currentTime_abs))
	end
end
forwardTime = TimeUtils.ForwardTime

-- =============================================================================
-- Converts string separated with unit identifing letters into a sorted array of units
-- It represent a time span.
-- e.g.:  3d 8h 18m 36s => array[3,8,18,36]
function TimeUtils.ConvertTimeStringToTimeArray(timeStr)
	local timeArray = {w = 0, d = 0, h = 0, m = 0, s = 0, ms = 0}

	for num, unit in timeStr:gmatch("(%d+)(%l+)") do
		if timeArray[unit] ~= nil then
			timeArray[unit] = num
		end
	end

	return timeArray
end

-- =============================================================================
-- Converts sorted array of time units into one string separated with unit identifing letters.
-- It represent a time span.
-- e.g.:  array[3,8,18,36] => 3d 8h 18m 36s
function TimeUtils.ConvertTimeArrayToDecimalHours(timeArray)
	local hours = 0
	for key, value in pairs(timeArray) do
		if 		 key == "w" then hours = hours + value*168 --7*24
		elseif key == "d" then hours = hours + value*24
		elseif key == "h" then hours = hours
		elseif key == "m" then hours = hours + value/60
		elseif key == "s" then hours = hours + value/3600 --60*60
		end
	end

	return hours
end

-- =============================================================================
-- Converts sorted array of time units into one string separated with unit identifing letters.
-- It represent a time span.
-- e.g.:  array[3,8,18,36] => 3d 8h 18m 36s
function TimeUtils.ConvertTimeArrayToMiliseconds(timeArray)
	local ms = 0
	for key, value in pairs(timeArray) do
		if 	   key == "w" then ms = ms + value * 1000 * 60 * 60 * 24 * 7
		elseif key == "d" then ms = ms + value * 1000 * 60 * 60 * 24
		elseif key == "h" then ms = ms + value * 1000 * 60 * 60
		elseif key == "m" then ms = ms + value * 1000 * 60
		elseif key == "s" then ms = ms + value * 1000
		elseif key == "ms" then ms = ms + value
		end
	end

	return ms
end

-- =============================================================================
-- Converts decimal hours to colon separated hours, minutes and second. It can be used for TimeBox node.
-- It represents the time of the day: the time is moduled by 24h.
-- e.g.:  8.31 => 08:18:36
function TimeUtils.ConvertDecimalHoursToDigitalTimeOfDay(decimalHours)
	local seconds = math.floor(decimalHours * 3600)
	return string.format("%.2d:%.2d:%.2d", (seconds / 3600) % 24, (seconds / 60) % 60, seconds % 60)
end

-- =============================================================================
-- Calculates the time interval needed for waiting until a specific time of day, from now.
-- @decimalHours 		- Target time 0.0 .. 24.0 (will be clamped).
-- @convertToString 	- Whether to return the result as a float number or a formatted string.
-- Returns number of hours (fraction) to wait if @convertToString is false,
-- e.g.:  8.5 (now) - 13.0 => 4.5
-- Returns a string in minutes that can be passed to SkipTime if @convertToString is true,
-- e.g.:  8.5 (now) - 13.0 => "270m"
function TimeUtils.GetOneDayWaitDuration(decimalHours, convertToString)
	local targetTime = decimalHours
	local now = Calendar.GetWorldHourOfDay()

	if targetTime > 24 then
		targetTime = 24
	elseif targetTime < 0 then
		targetTime = 0
	end

	local delta = targetTime - now
	if delta < 0 then
		delta = delta + 24
	end

	if convertToString then
		return math.ceil(delta * 60) .. "m"
	else
		return delta
	end
end

-- =============================================================================
function TimeUtils.ConvertTimesStringToNumArray(stringToSplit)
	local returnArray = {}

	if stringToSplit == "" then
		return returnArray
	end

	local i = 1
	local number
	for number in string.gmatch(stringToSplit, "%d+:?%d*") do
		local a, b = string.match(number, "(%d+):?(%d*)")
		returnArray[i] = tonumber(a) + (tonumber(b) or 0) / 60
		i = i + 1
	end

	return returnArray
end

-- =============================================================================
function TimeUtils.FloatToTime(floatToConvert)
	local a = string.format("%02d", math.floor(floatToConvert))
	local b = string.format("%02d", math.floor((floatToConvert - a) * 60 + 0.5))
	return a .. "_" .. b
end

-- =============================================================================
function TimeUtils.CheckTimeInBounds(lowerBound, upperBound)
	local flip, tOD = 0, Calendar.GetWorldHourOfDay()
	if lowerBound > upperBound then
		flip = 1
	end

	if (tOD < lowerBound) or (tOD > upperBound) then
		return (0 + flip)
	else
		return (1 - flip)
	end
end
