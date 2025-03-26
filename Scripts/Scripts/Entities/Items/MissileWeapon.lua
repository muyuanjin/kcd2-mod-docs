Script.ReloadScript( "Scripts/Entities/Items/PickableItem.lua")

MissileWeapon =
{
}

-- =============================================================================
-- Compose entity
-- =============================================================================
EntityCommon.DeriveOverride( MissileWeapon, PickableItem );