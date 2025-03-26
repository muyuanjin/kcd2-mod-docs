-- Despawn logic is defined in code
Script.ReloadScript( "Scripts/Entities/Physics/RigidBodyEx.lua" )

Debris = {
	Properties = {
		bSaved_by_game = false,
    }
}

EntityCommon.DeriveOverride( Debris,RigidBodyEx );