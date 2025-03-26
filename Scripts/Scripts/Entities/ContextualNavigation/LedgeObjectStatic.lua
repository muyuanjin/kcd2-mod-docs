--	Crytek Source File.
-- 	Copyright (C), Crytek Studios, 2001-2009.

LedgeObjectStatic =
{
	Properties = {
		bSaved_by_game         = false,
		bIsThin                = true,
		bIsWindow              = false,
		bLedgeDoubleSide       = true,
		bLedgeFlipped          = false,
		fCornerMaxAngle        = 130.0,
		fCornerEndAdjustAmount = 0.5,

		MainSide = {
			bEndCrouched = false,
			bEndFalling = false,
			bUsableByMarines = true,
			esLedgeType = "Vault",
		},

		OppositeSide = {
			bEndCrouched = false,
			bEndFalling = false,
			bUsableByMarines = true,
			esLedgeType = "Vault",
		},

	},

	Client = {},
	Server = {},

	Editor = {
		Icon = "ledge.bmp",
		ShowBounds = 1,
	},
}

-- =============================================================================
function LedgeObjectStatic:OnPropertyChange()
end

-- =============================================================================
function LedgeObjectStatic:IsShapeOnly()
	return 1
end

-- =============================================================================
function LedgeObjectStatic:IsClosed()
  return 0
end

-- =============================================================================
function LedgeObjectStatic:ShapeMinPoints()
	return 2
end

-- =============================================================================
function LedgeObjectStatic:ShapeMaxPoints()
	return 256
end

-- =============================================================================
function LedgeObjectStatic:ExportToGame()
  return 0
end

-- =============================================================================
function LedgeObjectStatic:OnSpawn()
	self:SetFlags(ENTITY_FLAG_CLIENT_ONLY, 0)
	self:SetFlags(ENTITY_FLAG_NO_PROXIMITY, 0)
end