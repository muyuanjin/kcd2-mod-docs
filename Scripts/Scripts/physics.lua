-- register explosion and crack shapes
-- DebugUtils.Log("registering explosion and shapes with physics system...");

-- local folder = "objects/prototype/breakable/";

-- RegisterExposionShape params, in this order:
-- 1) boolean shape cgf name
-- 2) characteristic "size" of the shape. ideally it should roughly represent the linear dimensions of the hole.
--    whenever a carving happens, it requests a desired hole size (set in explosion params or surfacetype params),
--		and the shape is scaled by [desired size/characteristic size]. if several shapes are registered with the same id,
--    the one with the size closest to the requested will be selected, and if there are several shapes with this size,
--    one of them will be selected randomly
-- 3) breakability index (0-based), used to identify the breakable material
-- 4) shape’s relative probability – when several shapes with the same size appear as candidates for carving,
--    they are selected with these relative probabilities
-- 5) splinters cgf – used for trees to add splinters at the place where it broke
-- 6) splinters scale – splinters cgf is scaled by [break radius * splinters scale],
--    i.e. splinters scale should be roughly [1 / most natural radius for the original cgf size]
-- 7) splinters particle fx name – is played when a splinters-based constraint breaks and splinters disappear
--
-- RegisterExposionCrack params, in this order:
-- 1) crack shape cgf name (must have 3 helpers that mark the corners, named "1","2","3")
-- 2) breakability index (same meaning as for the explosion shapes)

--[[
Physics.RegisterExplosionShape("Objects/Natural/trees/explosion_shape/tree_broken_shape.cgf", 7, 2, 1, "",0,"");
Physics.RegisterExplosionShape("Objects/Natural/trees/explosion_shape/tree_broken_shape2.cgf", 1.3, 3, 1, "",0,"");
Physics.RegisterExplosionShape("Objects/Natural/trees/explosion_shape/tree_broken_shape3.cgf", 1.3, 5, 1,
                               "Objects/Natural/trees/explosion_shape/trunk_splinters_a.cgf",1.6,"breakable_objects.tree_break.small");
]]
