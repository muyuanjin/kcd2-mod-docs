-- =============================================================================
-- Vector constants
-- =============================================================================
g_Vectors = {
	v000 = {x = 0, y = 0, z = 0},
	v001 = {x = 0, y = 0, z = 1},
	v010 = {x = 0, y = 1, z = 0},
	v011 = {x = 0, y = 1, z = 1},
	v100 = {x = 1, y = 0, z = 0},
	v101 = {x = 1, y = 0, z = 1},
	v110 = {x = 1, y = 1, z = 0},
	v111 = {x = 1, y = 1, z = 1},

	up = {x = 0, y = 0, z = 1},
	down = {x = 0, y = 0, z = -1},

	temp = {x = 0, y = 0, z = 0},
	tempColor = {x = 0, y = 0, z = 0},

	temp_v1 = {x = 0, y = 0, z = 0},
	temp_v2 = {x = 0, y = 0, z = 0},
	temp_v3 = {x = 0, y = 0, z = 0},
	temp_v4 = {x = 0, y = 0, z = 0},
	temp_v5 = {x = 0, y = 0, z = 0},
	temp_v6 = {x = 0, y = 0, z = 0},

	vecMathTemp1 = {x = 0, y = 0, z = 0},
	vecMathTemp2 = {x = 0, y = 0, z = 0}
}

-- =============================================================================
-- Math constants
-- =============================================================================
g_Rad2Deg = 180 / math.pi
g_Deg2Rad = math.pi / 180
g_Pi = math.pi
g_2Pi = 2 * math.pi
g_Pi2 = 0.5 * math.pi

-- =============================================================================
-- Set random
-- =============================================================================
random = math.random
math.randomseed(os.time()) -- seed and pop
random() -- first value always the same

-- =============================================================================
function math.Sqr(a)
	return a * a
end

-- =============================================================================
function math.Clamp(n, min, max)
	return Pick(n > max, max, Pick(n < min, min, n))
end

-- =============================================================================
function math.Lerp(m, n, k)
	k = math.Clamp(k, 0, 1)
	return m * (1 - k) + n * k
end

-- =============================================================================
function math.Sign(n)
	return Pick(n < 0, -1, Pick(n > 0, 1, 0))
end

-- =============================================================================
function math.Round(num, index)
	local mult = 10 ^ (index or 0)
	return math.floor(num * mult + 0.5) / mult
end

-- =============================================================================
function math.RandomFloat(a, b)
	if (a > b) then
		local c = b
		b = a
		a = c
	end

	local delta = b - a

	return (a + math.random() * delta)
end

-- =============================================================================
-- Calculates almost-gauss distribution (omits the divisor, as results of this function will be used as weights in random sampling, therefore scaling is irrelevant )
function math.PseudoGaussPDF(m, o, x)
	return math.exp(-math.pow(x - m, 2) / (2 * o * o))
end

-- =============================================================================
function math.SkewedPseudoGauss(m, o, s, x)
	if x < m then
		return math.PseudoGaussPDF(m, o * s, x)
	else
		return math.PseudoGaussPDF(m, o, x)
	end
end
