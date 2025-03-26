ReflexLight =
{
	Properties =
	{
		bSaved_by_game = false,
		bActive = true, --[0,1,1,"Turns the light on/off."]
		Radius = 10, --[0,100,1,"Specifies how far from the source the light affects the surrounding area."]
		fAttenuationBulbSize = 0.7, --[0,100,0.01,"Specifies the radius of the area light bulb."]
		Projector =
		{
			texture_Texture = "",
			fProjectorFov = 90, --[0,179,1,"Specifies the Angle on which the light texture is projected."]
			fProjectorNearPlane = 0.02, --[-100,100,0.1,"Set the near plane for the projector, any surfaces closer to the light source than this value will not be projected on."]
		},
		Color =
		{
			clrDiffuse = { x=1,y=1,z=1 },
			fDiffuseMultiplier = 2, --[0,100,0.1,"Control the strength of the diffuse color."]
			fSpecularMultiplier = 2, --[0,100,0.1,"Control the strength of the specular brightness."]
			fVolumetricMultiplier = 0.012, --[0,5,0.1,"Controls the volumetric lighting inscattering. Works only if the Volumetric Fog Option is enabled. KCD2-259576"]
			fGIMultiplier = 2, --[0,5,0.1,"Works only if the GI Mode is not None. KCD2-328021"]
			fToDMulWeight = 1, --[0,1,0.01,"Controls the strength of the ToD Probe Multiplier."]
		},
		Options =
		{
			bAffectsThisAreaOnly = true, --[0,1,1,"Set this parameter to false to make light cast in multiple visareas."]
			bIgnoresVisAreas = false, --[0,1,1,"Controls whether the light should respond to visareas."]
			bAmbient = false, --[0,1,1,"Makes the light behave like an ambient light source, with no point of origin."]
			bFakeLight = false, --[0,1,1,"Disables light projection, useful for lights which you only want to have Flare effects from."]
			bVolumetricFog = true, --[0,1,1,"Enables the light to affect volumetric fog."]
			bAffectsVolumetricFogOnly = false, --[0,1,0,"Enables the light to affect only volumetric fog."]
			bDeferredClipBounds = false, --[0,1,1,"Specifies that the light is linked to a light box or light shape and to use the volume of the target area for clipping."]
			file_deferred_clip_geom = "",
			fFogRadialLobe = 0, --[0,1,0,"Set the blend ratio of main and side radial lobe for volumetric fog."]
			esGIMode = "StaticLight", -- WH[TBa]: controls how SVOTI/SVOGI treats this light, KCD2-69768
			fVerticalClipDistanceDownward = 5, -- [0,100,0.1,"WH[TBa]: cull the light if the camera is higher (Z coordinate) than this, set both to 0 to disable, KCD2-140451"]
			fVerticalClipDistanceUpward = 5, -- [0,100,0.1,"WH[TBa]: cull the light if the camera is lower (Z coordinate) than this, set both to 0 to disable, KCD2-140451"]
		},
		Shadows =
		{
			nCastShadows = 4,
			bScreenSpaceShadowsFallbackWH = true, --[0,1,1,"Fallback to screen space shadows if the shadow map is disabled (for performance reasons), KCD2-444074"]
			fShadowBias = 1, --[0,1000,1,"Moves the shadow cascade toward or away from the shadow-casting object."]
			fShadowSlopeBias = 1, --[0,1000,1,"Allows you to adjust the gradient (slope-based) bias used to compute the shadow bias."]
			fShadowAutoBiasScale = 1, --[0.1,2,0.1,"Allows you to adjust output of the e_ShadowsAutoBias magic."]
			fShadowResolutionScale = 1,
			nShadowMinResPercent = 0, --[0,100,1,"Percentage of the shadow pool the light should use for its shadows."]
			fShadowUpdateMinRadius = 10, --[0,100,0.1,"Define the minimum radius from the light source to the player camera that the ShadowUpdateRatio setting will be ignored."]
			fShadowUpdateRatio = 1, --[0,10,0.01,"Define the update ratio for shadow maps cast from this light."]
			fShadowJitterWH = 0, --[-1,5,0.1,"Manual shadow jitter."] WH[TomK]: Add manual shadow jitter settings, KCD2-2674
			bDisableShadowCutoff = false, --[0,1,0,"Suppress distance based shadow optimization, cast shadows for the whole visibility range. KCD2-453316"]
		},
		Shape =
		{
			bAreaLight = true, --[0,1,1,"Used to turn the selected light entity into a Rectangular Area Light."]
			fPlaneWidth = 1, --[0,100,0.1,"Set the width of the Area Light shape."]
			fPlaneHeight = 1, --[0,100,0.1,"Set the height of the Area Light shape."]
			bAreaPhysicalAttenuation = true,
			vFadeDimensionsLeft =0,
			vFadeDimensionsRight =0,
			vFadeDimensionsNear =0,
			vFadeDimensionsFar =0,
			vFadeDimensionsTop =0,
			vFadeDimensionsBottom =0,
			fFadeInRadius = 0.35,
			fWallThickness = 0.2, --[0,5,0.1,"Set to positive value to enable thick wall shade model."]
			fWindowMarginHorizontal = 0, --[0,5,0.1,"Sets how far from the window is the chamfered wall. To use this you must first set nonzero wall thickness."]
			fWindowMarginVertical = 0, --[0,5,0.1,"Sets how far from the window is the chamfered wall. To use this you must first set nonzero wall thickness."]
			fWallChamferHorizontal = 0, --[0,90,0.1,"Angle of the left-right wall chamfer."]
			fWallChamferVertical = 0, --[0,90,0.1,"Angle of the up-down wall chamfer."]
			fNearClip = 0, --[0,100,0.1,"Pixels closer to this value will get zero influence."]
			-- WH[TBa]: removed circular lights and support for area light textures, KCD2-337067
		},

		-- dataholder for generated light data
		ToDData = {
			T00={clrColor={ x=1,y=1,z=1 }, fMult=1},
			T01={clrColor={ x=1,y=1,z=1 }, fMult=1},
			T02={clrColor={ x=1,y=1,z=1 }, fMult=1},
			T03={clrColor={ x=1,y=1,z=1 }, fMult=1},
			T04={clrColor={ x=1,y=1,z=1 }, fMult=1},
			T05={clrColor={ x=1,y=1,z=1 }, fMult=1},
			T06={clrColor={ x=1,y=1,z=1 }, fMult=1},
			T07={clrColor={ x=1,y=1,z=1 }, fMult=1},
			T08={clrColor={ x=1,y=1,z=1 }, fMult=1},
			T09={clrColor={ x=1,y=1,z=1 }, fMult=1},
			T10={clrColor={ x=1,y=1,z=1 }, fMult=1},
			T11={clrColor={ x=1,y=1,z=1 }, fMult=1},
		},
	},

	Editor =
	{
		ShowBounds=0,
		AbsoluteRadius = 1,
		IsScalable = false
	},

	_LightTable = {},
}

LightSlot = 1

-- =============================================================================
function ReflexLight:OnInit()
	--System.Log("ReflexLight Init")

	self:SetFlags(ENTITY_FLAG_CLIENT_ONLY, 0)
	self:OnReset()
	self:Activate(1);	-- Force OnUpdate to get called
	self:CacheResources("ReflexLight.lua")
end

-- =============================================================================
function ReflexLight:CacheResources(requesterName)
	local textureFlags = 0x00440000 -- FT_DONT_STREAM | FT_SUPPRESS_DOWNSCALING
	Game.CacheResource(requesterName, self.Properties.Projector.texture_Texture, eGameCacheResourceType_Texture, textureFlags)
	Game.CacheResource(requesterName, self.Properties.Options.file_deferred_clip_geom, eGameCacheResourceType_StaticObject, 0)
end

-- =============================================================================
function ReflexLight:OnShutDown()
	self:FreeSlot(LightSlot)
end

-- =============================================================================
function ReflexLight:OnLoad(props)
	self:OnReset()
	self:ActivateLight(props.bActive)
end

-- =============================================================================
function ReflexLight:OnSave(props)
	props.bActive = self.bActive
end

-- =============================================================================
function ReflexLight:OnPropertyChange()
	self:OnReset()
	self:ActivateLight( self.bActive )
	if (self.Properties.Options.bDeferredClipBounds) then
		self:UpdateLightClipBounds(LightSlot)
	end
end

-- =============================================================================
function ReflexLight:OnUpdate(dt)
	--System.Log("ReflexLight OnUpdate "..dt)
	if (self.bActive and self.Properties.Options.bDeferredClipBounds) then
		self:UpdateLightClipBounds(LightSlot)
	end

	if (not System.IsEditor()) then
		self:Activate(0)
	end
end

-- =============================================================================
-- Optimization for common animated trackview properties, to avoid fully recreating everything on every animated frame
function ReflexLight:OnPropertyAnimated( name )
	local changeTakenCareOf = false

	if (name=="fDiffuseMultiplier" or name=="fSpecularMultiplier") then
		changeTakenCareOf = true
		local Color = self.Properties.Color
		local diffuse_mul = Color.fDiffuseMultiplier
		local specular_multiplier = Color.fSpecularMultiplier
		local diffuse_color = { x=Color.clrDiffuse.x*diffuse_mul, y=Color.clrDiffuse.y*diffuse_mul, z=Color.clrDiffuse.z*diffuse_mul }
		self:SetLightColorParams( LightSlot, diffuse_color, specular_multiplier)
	end

	return changeTakenCareOf
end

-- =============================================================================
function ReflexLight:OnSysSpecLightChanged()
	self:OnPropertyChange()
end

-- =============================================================================
function ReflexLight:OnLevelLoaded()
	if (self.Properties.Options.bDeferredClipBounds) then
		self:UpdateLightClipBounds(LightSlot)
	end
end

-- =============================================================================
function ReflexLight:OnReset()
	--System.Log("ReflexLight Reset")
	if (self.bActive ~= self.Properties.bActive) then
		self:ActivateLight( self.Properties.bActive )
	end
end

-- =============================================================================
function ReflexLight:ActivateLight( enable )
	if (enable == true) then
		self.bActive = true
		self:LoadLightToSlot(LightSlot)
		self:ActivateOutput( "Active",true )
	else
		self.bActive = false
		self:FreeSlot(LightSlot)
		self:ActivateOutput( "Active",false )
	end
end

-- =============================================================================
function ReflexLight:LoadLightToSlot( nSlot )
	local props = self.Properties
	local Projector = props.Projector
	local Color = props.Color
	local Options = props.Options
	local Shape = props.Shape
	local Shadows = props.Shadows

	local diffuse_mul = Color.fDiffuseMultiplier
	local specular_mul = Color.fSpecularMultiplier

	local lt = self._LightTable

	lt.radius = props.Radius
	lt.attenuation_bulbsize = props.fAttenuationBulbSize
	lt.diffuse_color = { x=Color.clrDiffuse.x*diffuse_mul, y=Color.clrDiffuse.y*diffuse_mul, z=Color.clrDiffuse.z*diffuse_mul }
	lt.specular_multiplier = specular_mul
	lt.volumetric_multiplier_wh = Color.fVolumetricMultiplier -- WH[TBa]: KCD2-259576
	lt.gi_multiplier_wh = Color.fGIMultiplier -- WH[TBa]: KCD2-328021
	lt.tod_mul_weight = Color.fToDMulWeight

	lt.this_area_only = Options.bAffectsThisAreaOnly
	lt.ambient = props.Options.bAmbient
	lt.deferred_geom = Options.file_deferred_clip_geom
	lt.hasclipbound = Options.bDeferredClipBounds
	lt.fake = Options.bFakeLight
	lt.ignore_visareas = Options.bIgnoresVisAreas
	lt.volumetric_fog = Options.bVolumetricFog
	lt.volumetric_fog_only = Options.bAffectsVolumetricFogOnly
	lt.fog_radial_lobe = Options.fFogRadialLobe
	lt.gi_mode = Options.esGIMode -- add svoti/gi mode flags, KCD2-69768
	lt.vertical_clip_distance_downward = Options.fVerticalClipDistanceDownward -- WH[TBa]: KCD2-140451
	lt.vertical_clip_distance_upward = Options.fVerticalClipDistanceUpward -- WH[TBa]: KCD2-140451

	lt.area_physical_attenuation = Shape.bAreaPhysicalAttenuation
	lt.fade_in_radius = Shape.fFadeInRadius
	lt.near_clip = Shape.fNearClip
	-- WH[TBa]: removed circular lights and support for area light textures, KCD2-337067

	lt.area_wall_thickness = Shape.fWallThickness
	lt.area_window_horizontal_margin = Shape.fWindowMarginHorizontal
	lt.area_window_vertical_margin = Shape.fWindowMarginVertical
	lt.area_wall_horizontal_chamfer = Shape.fWallChamferHorizontal
	lt.area_wall_vertical_chamfer = Shape.fWallChamferVertical

	lt.cast_shadow = Shadows.nCastShadows
	lt.ss_shadows_fallback_wh = Shadows.bScreenSpaceShadowsFallbackWH
	lt.shadow_bias = Shadows.fShadowBias
	lt.shadow_slope_bias = Shadows.fShadowSlopeBias
	lt.shadow_auto_bias_scale_wh = Shadows.fShadowAutoBiasScale
	lt.shadowResolutionScale = Shadows.fShadowResolutionScale
	lt.shadowMinResolution = Shadows.nShadowMinResPercent
	lt.shadowUpdate_MinRadius = Shadows.fShadowUpdateMinRadius
	lt.shadowUpdate_ratio = Shadows.fShadowUpdateRatio
	lt.shadow_jitter_wh = Shadows.fShadowJitterWH	-- WH[TomK]: KCD2-2674
	lt.disable_shadow_cutoff = Shadows.bDisableShadowCutoff -- WH[TBa]: KCD2-453316

	lt.projector_texture = Projector.texture_Texture
	lt.proj_fov = Projector.fProjectorFov
	lt.proj_nearplane = Projector.fProjectorNearPlane

	lt.area_light = Shape.bAreaLight
	lt.area_width = Shape.fPlaneWidth
	lt.area_height = Shape.fPlaneHeight
	lt.fade_dimensions_left = Shape.vFadeDimensionsLeft
	lt.fade_dimensions_right = Shape.vFadeDimensionsRight
	lt.fade_dimensions_near = Shape.vFadeDimensionsNear
	lt.fade_dimensions_far = Shape.vFadeDimensionsFar
	lt.fade_dimensions_top = Shape.vFadeDimensionsTop
	lt.fade_dimensions_bottom = Shape.vFadeDimensionsBottom

	lt.lightmap_linear_attenuation = 1
	lt.is_rectangle_light = 0
	lt.is_sphere_light = 0
	lt.area_sample_number = 1
	lt.indoor_only = 0

	self:LoadLight( nSlot,lt )
end

-- =============================================================================
function ReflexLight:Event_Enable()
	if (self.bActive == false) then
		self:ActivateLight( true )
	end
end

-- =============================================================================
function ReflexLight:Event_Disable()
	if (self.bActive == true) then
		self:ActivateLight( false )
	end
end

-- =============================================================================
function ReflexLight:NotifySwitchOnOffFromParent(wantOn)
  local wantOff = wantOn~=true
	if (self.bActive == true and wantOff) then
		self:ActivateLight( false )
	elseif (self.bActive == false and wantOn) then
		self:ActivateLight( true )
	end
end

-- =============================================================================
-- Event Handlers
-- =============================================================================
function ReflexLight:Event_Active( sender, bActive )
	if (self.bActive == false and bActive == true) then
		self:ActivateLight( true )
	else
		if (self.bActive == true and bActive == false) then
			self:ActivateLight( false )
		end
	end
end

-- =============================================================================
function ReflexLight:Event_Radius( sender, Radius )
	self.Properties.Radius = Radius
	self:OnPropertyChange()
end

-- =============================================================================
function ReflexLight:Event_DiffuseColor( sender, DiffuseColor )
	self.Properties.Color.clrDiffuse = DiffuseColor
	self:OnPropertyChange()
end

-- =============================================================================
function ReflexLight:Event_DiffuseMultiplier( sender, DiffuseMultiplier )
	self.Properties.Color.fDiffuseMultiplier = DiffuseMultiplier
	self:OnPropertyChange()
end

-- =============================================================================
function ReflexLight:Event_SpecularMultiplier( sender, SpecularMultiplier )
	self.Properties.Color.fSpecularMultiplier = SpecularMultiplier
	self:OnPropertyChange()
end

-- =============================================================================
-- Event descriptions
-- =============================================================================
ReflexLight.FlowEvents =
{
	Inputs =
	{
		Active = { ReflexLight.Event_Active,"bool" },
		Enable = { ReflexLight.Event_Enable,"bool" },
		Disable = { ReflexLight.Event_Disable,"bool" },
		Radius = { ReflexLight.Event_Radius,"float" },
		DiffuseColor = { ReflexLight.Event_DiffuseColor,"vec3" },
		DiffuseMultiplier = { ReflexLight.Event_DiffuseMultiplier,"float" },
		SpecularMultiplier = { ReflexLight.Event_SpecularMultiplier,"float" },
	},
	Outputs =
	{
		Active = "bool",
	},
}