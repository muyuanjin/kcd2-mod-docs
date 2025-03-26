-- NavigationUtils: Currently the only interesting function from the namespace is GetChasingPoint, the others are just helper functions to structure the code a bit. All calculations are done only in 2D space (x and y coordinates)
NavigationUtils = {}

-- =============================================================================
-- GetChasingPointInOpposingQuadrant: Returns a point behind the fleeing NPC which will direct him towards the given free quadrant
-- Parameters:
--		quadrant	integer representing the free quadrant (1 - top right, 2 - bottom right, 3 - bottom left, 4 - top left)
-- Returns:
--		x			x coordinate of the resulting point
--		y			y coordinate of the resulting point
function NavigationUtils.GetChasingPointInOpposingQuadrant(quadrant)
	local dir = 0.707107
	if quadrant == 1 then
		return -dir, -dir
	elseif quadrant == 2 then
		return -dir, dir
	elseif quadrant == 3 then
		return dir, dir
	else
		return dir, -dir
	end
end

-- =============================================================================
-- GetChasingPointOpposingTwoQuadrants: Returns a point behind the fleeing NPC guiding it in between given free quadrants
-- Parameters:
--		firstQuadrant	integer representing the free quadrant (1 - top right, 2 - bottom right, 3 - bottom left, 4 - top left)
--		secondQuadrant
-- Returns:
--		x			x coordinate of the resulting point
--		y			y coordinate of the resulting point
function NavigationUtils.GetChasingPointOpposingTwoQuadrants(firstQuadrant, secondQuadrant)
	if firstQuadrant == 1 then
		if secondQuadrant == 2 then
			return -1, 0
		else
			return 0, -1
		end
	elseif firstQuadrant == 2 then
		return 0, 1
	else
		return 1, 0
	end
end

-- =============================================================================
-- DotProduct: Calculates the dot product of the given vectors
-- Parameters:
--		vec1	first vector specified as table with keys 'x' and 'y'
--		vec2	second vector specified as table with keys 'x' and 'y'
-- Returns:
--		dp		dot product of the two vectors
function NavigationUtils.DotProduct(vec1, vec2)
	return vec1.x * vec2.x + vec1.y * vec2.y
end

-- =============================================================================
-- GetSurroundingChasingPoint: Calculates the point representing the chasing NPCs when they are surrounding the fleeing NPC (there is at least one chasing NPC in each quadrant) and the restricting angle
-- Parameters:
--		chasingNPCs_vectors		array of vectors from the fleeing NPC to each chasing NPC
-- Returns:
--		chasingPointX			x coordinate of the resulting chasing point
--		chasingPointY			y coordinate of the resulting chasing point
--		chasingPointAngle		the resulting restricting angle
function NavigationUtils.GetSurroundingChasingPoint(chasingNPCs_vectors)
	-- Normalize the vectors and insert them to appropriate array
	local chasingNPCs_ySortRight = {}
	local chasingNPCs_ySortLeft = {}
	for _, vec in ipairs(chasingNPCs_vectors) do
		local length = math.sqrt(vec.x * vec.x + vec.y * vec.y)
		if vec.x >= 0 then
			table.insert(chasingNPCs_ySortRight, { x = vec.x / length, y = vec.y / length } )
		else
			table.insert(chasingNPCs_ySortLeft, { x = vec.x / length, y = vec.y / length } )
		end
	end

	-- Sort the arrays
	table.sort(chasingNPCs_ySortRight, function (a, b) return a.y > b.y end)
	table.sort(chasingNPCs_ySortLeft, function (a, b) return a.y > b.y end)

	-- Find the lowest dot product between neighbouring vectors (represents the biggest angle)
	local minDP = 2
	local minDP_index = 0
	-- Marks on which side the current lowest value is: 1 - right, 2 - left, 3 - top, 4 - bottom
	local minDP_side = 0
	local dp
	-- Go through the vectors on the right side
	for i = 1, #chasingNPCs_ySortRight - 1 do
		dp = NavigationUtils.DotProduct(chasingNPCs_ySortRight[i], chasingNPCs_ySortRight[i + 1])
		if dp < minDP then
			minDP = dp
			minDP_index = i
			minDP_side = 1
		end
	end
	-- Go through the vectors on the left side
	for i = 1, #chasingNPCs_ySortLeft - 1 do
		dp = NavigationUtils.DotProduct(chasingNPCs_ySortLeft[i], chasingNPCs_ySortLeft[i + 1])
		if dp < minDP then
			minDP = dp
			minDP_index = i
			minDP_side = 2
		end
	end
	-- Check the top and the bottom vectors
	dp = NavigationUtils.DotProduct(chasingNPCs_ySortRight[1], chasingNPCs_ySortLeft[1])
	if dp < minDP then
		minDP = dp
		minDP_index = 1
		minDP_side = 3
	end
	dp = NavigationUtils.DotProduct(chasingNPCs_ySortRight[#chasingNPCs_ySortRight], chasingNPCs_ySortLeft[#chasingNPCs_ySortLeft])
	if dp < minDP then
		minDP = dp
		minDP_index = #chasingNPCs_ySortRight
		minDP_side = 4
	end

	-- The resulting chasing point position is the opposite of the addition of the selected vectors
	local chasingPointX, chasingPointY, chasingPointAngle
	if minDP_side == 1 then
		chasingPointX = -chasingNPCs_ySortRight[minDP_index].x - chasingNPCs_ySortRight[minDP_index + 1].x
		chasingPointY = -chasingNPCs_ySortRight[minDP_index].y - chasingNPCs_ySortRight[minDP_index + 1].y
	elseif minDP_side == 2 then
		chasingPointX = -chasingNPCs_ySortLeft[minDP_index].x - chasingNPCs_ySortLeft[minDP_index + 1].x
		chasingPointY = -chasingNPCs_ySortLeft[minDP_index].y - chasingNPCs_ySortLeft[minDP_index + 1].y
	elseif minDP_side == 3 then
		chasingPointX = -chasingNPCs_ySortRight[1].x - chasingNPCs_ySortLeft[1].x
		chasingPointY = -chasingNPCs_ySortRight[1].y - chasingNPCs_ySortLeft[1].y
	else
		chasingPointX = -chasingNPCs_ySortRight[#chasingNPCs_ySortRight].x - chasingNPCs_ySortLeft[#chasingNPCs_ySortLeft].x
		chasingPointY = -chasingNPCs_ySortRight[#chasingNPCs_ySortRight].y - chasingNPCs_ySortLeft[#chasingNPCs_ySortLeft].y
	end
	chasingPointAngle = 180 - math.deg(math.acos(minDP)) / 2 * 0.9

	return chasingPointX, chasingPointY, chasingPointAngle
end

-- =============================================================================
-- GetChasingPoint: Calculates the point representing multiple chasing NPCs from which the fleeing NPC should try to run
-- Parameters:
--		fleeingNPC_position		position of the fleeing NPC specified as table with keys 'x' and 'y'
--		chasingNPCs_positions	array of positions of the chasing NPCs specified as tables with keys 'x' and 'y'
-- Returns:
--		chasingPointX			x coordinate of the resulting chasing point
--		chasingPointY			y coordinate of the resulting chasing point
--		chasingPointAngle		the resulting restricting angle (determines the area that the fleeing NPC can't enter)
function NavigationUtils.GetChasingPoint(fleeingNPC_position, chasingNPCs_positions)
	-- Calculate vectors from fleeing NPC to each chasing NPC and count the chasing NPCs for each quadrant
	local chasingNPCs_vectors = {}
	local quadrantChasingNPCsCount = { 0, 0, 0, 0 }
	for _, pos in pairs(chasingNPCs_positions) do
		local x = pos.x - fleeingNPC_position.x
		local y = pos.y - fleeingNPC_position.y

		-- Store the vector
		table.insert(chasingNPCs_vectors, { x = x, y = y })

		-- Check in which quadrant this chasing NPC is
		if x >= 0 and y >= 0 then
			quadrantChasingNPCsCount[1] = quadrantChasingNPCsCount[1] + 1
		elseif x >= 0 and y < 0 then
			quadrantChasingNPCsCount[2] = quadrantChasingNPCsCount[2] + 1
		elseif x < 0 and y < 0 then
			quadrantChasingNPCsCount[3] = quadrantChasingNPCsCount[3] + 1
		else
			quadrantChasingNPCsCount[4] = quadrantChasingNPCsCount[4] + 1
		end
	end

	-- Mark free quadrants if there are any
	local freeQuadrants = {}
	for i, v in ipairs(quadrantChasingNPCsCount) do
		if v == 0 then
			table.insert(freeQuadrants, i)
		end
	end

	local chasingPointX, chasingPointY, chasingPointAngle
	-- Try to decide where to run based on free quadrants
	if #freeQuadrants == 1 then
		chasingPointX, chasingPointY = NavigationUtils.GetChasingPointInOpposingQuadrant(freeQuadrants[1])
		chasingPointAngle = 140.0
	elseif #freeQuadrants == 2 then
		-- If the free quadrants are opposing each other, arbitrarily go to the first one
		if freeQuadrants[1] == 1 and freeQuadrants[2] == 3 or freeQuadrants[1] == 2 and freeQuadrants[2] == 4 then
			chasingPointX, chasingPointY = NavigationUtils.GetChasingPointInOpposingQuadrant(freeQuadrants[1])
			chasingPointAngle = 140.0
		else
			chasingPointX, chasingPointY = NavigationUtils.GetChasingPointOpposingTwoQuadrants(freeQuadrants[1], freeQuadrants[2])
			chasingPointAngle = 95.0
		end
	elseif #freeQuadrants == 3 then
		-- Pick the correct middle quadrant
		if freeQuadrants[1] == 1 and freeQuadrants[3] == 4 then
			if freeQuadrants[2] == 2 then
				chasingPointX, chasingPointY = NavigationUtils.GetChasingPointInOpposingQuadrant(1)
			else
				chasingPointX, chasingPointY = NavigationUtils.GetChasingPointInOpposingQuadrant(4)
			end
		else
			chasingPointX, chasingPointY = NavigationUtils.GetChasingPointInOpposingQuadrant(freeQuadrants[2])
		end
		chasingPointAngle = 50.0
	else
		-- All quadrants are occupied, more calculations need to be done
		chasingPointX, chasingPointY, chasingPointAngle = NavigationUtils.GetSurroundingChasingPoint(chasingNPCs_vectors)
	end

	return chasingPointX + fleeingNPC_position.x, chasingPointY + fleeingNPC_position.y, chasingPointAngle
end