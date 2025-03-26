Script.ReloadScript( "Scripts/Entities/Physics/AnimObject.lua" )

PlayerWeapon = {}

EntityCommon.DeriveOverride( PlayerWeapon,AnimObject );

-- Override defaults
PlayerWeapon.Properties.object_Model = "objects/nature/vegetable/carrot_2.cgf"