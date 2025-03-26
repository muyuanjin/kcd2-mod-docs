VectorUtils = {}

-- =============================================================================
function VectorUtils.LengthSquared(a)
	return a.x ^ 2 + a.y ^ 2 + a.z ^ 2
end

-- =============================================================================
function VectorUtils.Length(a)
	return math.sqrt(VectorUtils.LengthSquared(a))
end

-- =============================================================================
function VectorUtils.DistanceSquared(a, b)
	return VectorUtils.LengthSquared(VectorUtils.Subtract(a, b))
end

-- =============================================================================
function VectorUtils.DistanceSquared2D(a, b)
	local x = a.x - b.x
	local y = a.y - b.y
	return x ^ 2 + y ^ 2
end

-- =============================================================================
function VectorUtils.Distance(a, b)
	return VectorUtils.Length(VectorUtils.Subtract(a, b))
end

-- =============================================================================
function VectorUtils.DotProduct(a, b)
	return (a.x * b.x) + (a.y * b.y) + (a.z * b.z)
end

-- =============================================================================
function VectorUtils.DotProduct2D(a, b)
	return (a.x * b.x) + (a.y * b.y)
end

-- =============================================================================
function VectorUtils.CrossProduct(a, b)
	return {
		x = a.y * b.z - a.z * b.y,
		y = a.z * b.x - a.x * b.z,
		z = a.x * b.y - a.y * b.x
	}
end

-- =============================================================================
function VectorUtils.IsZero(a)
	return a.x == 0 and a.y == 0 and a.z == 0
end

-- =============================================================================
function VectorUtils.Copy(a)
	return {
		x = a.x,
		y = a.y,
		z = a.z
	}
end

-- =============================================================================
function VectorUtils.Sum(a, b)
	return {
		x = a.x + b.x,
		y = a.y + b.y,
		z = a.z + b.z
	}
end

-- =============================================================================
function VectorUtils.Subtract(a, b)
	return {
		x = a.x - b.x,
		y = a.y - b.y,
		z = a.z - b.z
	}
end

-- =============================================================================
function VectorUtils.Negate(a)
	return {
		x = -a.x,
		y = -a.y,
		z = -a.z
	}
end

-- =============================================================================
function VectorUtils.Product(a, b)
	return {
		x = a.x * b.x,
		y = a.y * b.y,
		z = a.z * b.z
	}
end

-- =============================================================================
function VectorUtils.Scale(a, b)
	return {
		x = a.x * b,
		y = a.y * b,
		z = a.z * b
	}
end

-- =============================================================================
function VectorUtils.Normalize(a)
	local len = VectorUtils.Length(a)
	local multiplier

	if (len > 0) then
		multiplier = 1 / len
	else
		multiplier = 0.0001
	end

	return VectorUtils.Scale(a, multiplier)
end

-- =============================================================================
function VectorUtils.Lerp(a, b, t)
	local ot = 1 - t
	return {
		x = a.x * ot + b.x * t,
		y = a.y * ot + b.y * t,
		z = a.z * ot + b.z * t
	}
end

-- =============================================================================
function VectorUtils.Rotate90AroundZ(v)
	return {
		x = v.y,
		y = -v.x,
		z = v.z
	}
end

-- =============================================================================
function VectorUtils.RotateMinus90AroundZ(v)
	return {
		x = -v.y,
		y = v.x,
		z = v.z
	}
end

-- =============================================================================
-- rotate vector a around vector b by angle
-- the length of b needs to be 1
function VectorUtils.RotateAround(a, b, angle)
	-- p' = v1 + v2 +v3
	-- v1 = a*cosA
	-- v2 = b** a*sinA;
	-- v3 = b< b,a >( 1- cosA );

	local cosValue = math.cos(angle)
	local sinValue = math.sin(angle)
	local v1, v2, v3

	-- v1
	v1 = VectorUtils.Scale(a, cosValue)
	-- v2
	v2 = VectorUtils.CrossProduct(b, VectorUtils.Scale(a, sinValue))
	-- v3
	v3 = VectorUtils.Scale(b, VectorUtils.DotProduct(b, a))
	v3 = VectorUtils.Scale(v3, 1.0 - cosValue)
	-- p'
	return VectorUtils.Sum(v1, VectorUtils.Sum(v2, v3))
end

-- =============================================================================
function VectorUtils.Rotate2D(a, angle)
	cosi = math.cos(math.rad(angle))
	sine = math.sin(math.rad(angle))
	return {
		x = a.x * cosi - a.y * sine,
		y = a.x * sine + a.y * cosi,
		z = a.z
	}
end

-- =============================================================================
-- Get normalized direction vector from point 'a' to point 'b'
function VectorUtils.GetDirection(a, b)
	return VectorUtils.Normalize(VectorUtils.Subtract(b, a))
end

-- =============================================================================
function VectorUtils.GetAngleBetween(a, b)
	return math.acos(math.Clamp(VectorUtils.DotProduct(a, b), -1, 1))
end

-- =============================================================================
function VectorUtils.GetAngleBetween2D(a, b)
	return math.acos(VectorUtils.DotProduct2D(a, b))
end

-- =============================================================================
function VectorUtils.ToString(vec)
	return string.format("(x: %.3f y: %.3f z: %.3f)", vec.x, vec.y, vec.z)
end

-- =============================================================================
function VectorUtils.LogVector(name, v)
	DebugUtils.Log("%s = (%f %f %f)", name, v.x, v.y, v.z)
end