Light =
{
	Properties =
	{
		bSaved_by_game = false,
		bActive = true, --[0,1,1,"Turns the light on/off."]
		Radius = 10, --[0,1000,1,"Specifies how far from the source the light affects the surrounding area."]
		fAttenuationBulbSize = 0.05, --[0,100,0.01,"Specifies the radius of the area light bulb."]
		sWH_AI_EntityCategory = "",
		sToDActive = "", --[0,24,1,"If set, controls the light on/off in the time ranges set as sorted pairs of numbers. E.g. 11:30, 12:52, 20, 21, works only for cutscene lights that are updated when property is animated"]
		Style =
		{
			nLightStyle = 0, --[0,55,1,"Specifies a preset animation for the light to play."]
			fAnimationSpeed = 1, --[0,100,0.1,"Specifies the speed at which the light animation should play."]
			nAnimationPhase = 0, --[0,255,1,"This will start the light style at a different point along the sequence."]
			esLightAnimType = "LoopConstantSeed", --["loop with constant start frame (nAnimationPhase), random start point (nAnimationPhase is ignored), or oneshot - starts at 0 and does not loop. KCD2-106205"]
			bAttachToSun = false, --[0,1,1,"When enabled, sets the Sun to use the Flare properties for this light."]
			lightanimation_LightAnimation = "",
			bTimeScrubbingInTrackView = false,
			_fTimeScrubbed = 0,
			bFlareEnable = true, --[0,1,1,"Toggles the flare effect on or off for this light."]
			flare_Flare = "",
			fFlareFOV = 360, --[0,360,1,"FOV for the flare."]
		},
		Projector =
		{
			bSpotShadow = false, 			--[0,1,1,"Toggles projector-like spot shadow for point lighting."]
			bSpotShadowBack = false,	--[0,1,1,"Toggles back side for projector-like spot shadow for point lighting."]
			bSpotShadowRight = false,	--[0,1,1,"Toggles right side for projector-like spot shadow for point lighting."]
			bSpotShadowLeft = false,	--[0,1,1,"Toggles left side for projector-like spot shadow for point lighting."]
			bSpotShadowTop = false,		--[0,1,1,"Toggles top side for projector-like spot shadow for point lighting."]
			bSpotShadowBottom = false,--[0,1,1,"Toggles bottom side for projector-like spot shadow for point lighting."]
			texture_Texture = "",
			fProjectorFov = 90, --[0,180,1,"Specifies the Angle on which the light texture is projected."]
			fProjectorNearPlane = 0, --[-100,100,0.1,"Set the near plane for the projector, any surfaces closer to the light source than this value will not be projected on."]
		},
		Color =
		{
			clrDiffuse = { x=1,y=1,z=1 },
			fDiffuseMultiplier = 1, --[0,999,0.1,"Control the strength of the diffuse color."]
			fSpecularMultiplier = 1, --[0,999,0.1,"Control the strength of the specular brightness."]
			fVolumetricMultiplier = 1, --[0,5,0.1,"Controls the volumetric lighting inscattering. Works only if the Volumetric Fog Option is enabled. KCD2-259576"]
			fGIMultiplier = 1, --[0,5,0.1,"Works only if the GI Mode is not None. KCD2-328021"]
		},
		Options =
		{
			bAffectsThisAreaOnly = true, --[0,1,1,"Set this parameter to false to make light cast in multiple visareas."]
			bIgnoresVisAreas = false, --[0,1,1,"Controls whether the light should respond to visareas."]
			bAmbient = false, --[0,1,1,"Makes the light behave like an ambient light source, with no point of origin."]
			bFakeLight = false, --[0,1,1,"Disables light projection, useful for lights which you only want to have Flare effects from."]
			bVolumetricFog = true, --[0,1,1,"Enables the light to affect volumetric fog."]
			bAffectsVolumetricFogOnly = false, --[0,1,0,"Enables the light to affect only volumetric fog."]
			file_deferred_clip_geom = "",
			fFogRadialLobe = 0, --[0,1,0,"Set the blend ratio of main and side radial lobe for volumetric fog."]
			bCutsceneLight = false, --[0,1,1,"Cutscene lights are affected by a specific ToD track for optimal lighting on different conditions."]
			esGIMode = "None", -- WH[TBa]: controls how SVOTI/SVOGI treats this light, KCD2-69768
			fVerticalClipDistanceDownward = 0, -- [0,100,0.1,"WH[TBa]: cull the light if the camera is higher (Z coordinate) than this, set both to 0 to disable, KCD2-140451"]
			fVerticalClipDistanceUpward = 0, -- [0,100,0.1,"WH[TBa]: cull the light if the camera is lower (Z coordinate) than this, set both to 0 to disable, KCD2-140451"]
		},
		Shadows =
		{
			nCastShadows = 0,
			bScreenSpaceShadowsFallbackWH = false, --[0,1,1,"Fallback to screen space shadows if the shadow map is disabled (for performance reasons), KCD2-444074"]
			fShadowBias = 1, --[0,1000,1,"Moves the shadow cascade toward or away from the shadow-casting object."]
			fShadowSlopeBias = 1, --[0,1000,1,"Allows you to adjust the gradient (slope-based) bias used to compute the shadow bias."]
			fShadowAutoBiasScale = 1, --[0.1,2,0.1,"Allows you to adjust output of the e_ShadowsAutoBias magic."]
			fShadowResolutionScale = 1, --[0.01,10,0.02,"Allows you to adjust shadow map resolution."]
			nShadowMinResPercent = 0, --[0,100,1,"Percentage of the shadow pool the light should use for its shadows."]
			fShadowUpdateMinRadius = 10, --[0,100,0.1,"Define the minimum radius from the light source to the player camera that the ShadowUpdateRatio setting will be ignored."]
			fShadowUpdateRatio = 1, --[0,10,0.01,"Define the update ratio for shadow maps cast from this light."]
			fShadowJitterWH = 0, --[-1,5,0.1,"Manual shadow jitter."] WH[TomK]: Add manual shadow jitter settings, KCD2-2674
			bDisableShadowCutoff = false, --[0,1,0,"Suppress distance based shadow optimization, cast shadows for the whole visibility range. KCD2-453316"]
		},
		Shape =
		{
			bAreaLight = false, --[0,1,1,"Used to turn the selected light entity into a Rectangular Area Light."]
			fPlaneWidth = 1, --[0,100,0.1,"Set the width of the Area Light shape."]
			fPlaneHeight = 1, --[0,100,0.1,"Set the height of the Area Light shape."]
			bAreaPhysicalAttenuation = false,
			fFadeInRadius = 0,
			fWallThickness = 0, --[0,5,0.1,"Set to positive value to enable thick wall shade model."]
			fWindowMarginHorizontal = 0, --[0,5,0.1,"Sets how far from the window is the chamfered wall. To use this you must first set nonzero wall thickness."]
			fWindowMarginVertical = 0, --[0,5,0.1,"Sets how far from the window is the chamfered wall. To use this you must first set nonzero wall thickness."]
			fWallChamferHorizontal = 45, --[0,90,0.1,"Angle of the left-right wall chamfer."]
			fWallChamferVertical = 45, --[0,90,0.1,"Angle of the up-down wall chamfer."]
			fNearClip = 0, --[0,100,0.1,"Pixels closer to this value will get zero influence."]
			-- WH[TBa]: removed circular lights and support for area light textures, KCD2-337067
		},
	},

	Editor =
	{
		Icon="Light.bmp",
		ShowBounds=0,
		AbsoluteRadius = 1,
		IsScalable = false
	},

	_LightTable = {},
	_ToDActiveTable ={},
}

LightSlot = 1

-- =============================================================================
function Light:InitTodActiveTable()
	self._ToDActiveTable = TimeUtils.ConvertTimesStringToNumArray(self.Properties.sToDActive)
end

-- =============================================================================
function Light:OnInit()
	--self:NetPresent(0)
	self:SetFlags(ENTITY_FLAG_CLIENT_ONLY, 0)
	self:OnReset()
	self:CacheResources("Light.lua")
end

-- =============================================================================
function Light:CacheResources(requesterName)
	if (Game ~= nil) then
		local textureFlags = 0x00440000 -- FT_DONT_STREAM | FT_SUPPRESS_DOWNSCALING
		Game.CacheResource(requesterName, self.Properties.Projector.texture_Texture, eGameCacheResourceType_Texture, textureFlags)
		Game.CacheResource(requesterName, self.Properties.Options.file_deferred_clip_geom, eGameCacheResourceType_StaticObject, 0)
	end
end

-- =============================================================================
function Light:OnShutDown()
	self:FreeSlot(LightSlot)
end

-- =============================================================================
function Light:OnLoad(props)
	self:OnReset()
	self:ActivateLight(props.bActive)
end

-- =============================================================================
function Light:OnSave(props)
	props.bActive = self.bActive
end

-- =============================================================================
function Light:OnPropertyChange()
	self:OnReset()
	self:ActivateLight( self.bActive )
	if (self.Properties.Options.bAffectsThisAreaOnly == true) then
		self:UpdateLightClipBounds(LightSlot)
	end
end

-- =============================================================================
-- Optimization for common animated trackview properties, to avoid fully recreating everything on every animated frame
function Light:OnPropertyAnimated( name )
	local changeTakenCareOf = false

	if (name=="fDiffuseMultiplier" or name=="fSpecularMultiplier") then
		changeTakenCareOf = true
		self:UpdateLightTOD(Calendar.GetWorldHourOfDay()) -- "fake update" for ToD
	end

	return changeTakenCareOf
end

-- =============================================================================
function Light:OnSysSpecLightChanged()
	self:OnPropertyChange()
end

-- =============================================================================
function Light:OnLevelLoaded()
	if (self.Properties.Options.bAffectsThisAreaOnly == true) then
		self:UpdateLightClipBounds(LightSlot)
	end
end

-- =============================================================================
function Light:OnReset()
	self:InitTodActiveTable()
	if (self.bActive ~= self.Properties.bActive) then
		self:ActivateLight( self.Properties.bActive )
	end
end

-- =============================================================================
function Light:SetColorParams( enable )
	local col = self.Properties.Color
	local diffMul = col.fDiffuseMultiplier
	local specMul = col.fSpecularMultiplier
	local diffCol = {x = col.clrDiffuse.x * diffMul, y = col.clrDiffuse.y * diffMul, z = col.clrDiffuse.z * diffMul}
	self:SetLightColorParams(LightSlot, diffCol, specMul)
end

-- =============================================================================
function Light:ActivateLight( enable )
	if (enable == true) then
		self:UpdateLightTOD(Calendar.GetWorldHourOfDay())
	else
		self.bActive = false
		self:FreeSlot(LightSlot)
		self:ActivateOutput( "Active",false )
	end
end

-- =============================================================================
function Light:LoadLightToSlot( nSlot )
	self._LightTable = self.GetLightDesc(self.Properties, nSlot)
	self:LoadLight(nSlot, self._LightTable)
end

-- =============================================================================
function Light.GetLightDesc(props, nSlot)
	local Style = props.Style
	local Projector = props.Projector
	local Color = props.Color
	local Options = props.Options
	local Shape = props.Shape
	local Shadows = props.Shadows

	local diffuse_mul = Color.fDiffuseMultiplier
	local specular_mul = Color.fSpecularMultiplier

	local lt = {}
	lt.radius = props.Radius
	lt.attenuation_bulbsize = props.fAttenuationBulbSize
	lt.diffuse_color = { x=Color.clrDiffuse.x*diffuse_mul, y=Color.clrDiffuse.y*diffuse_mul, z=Color.clrDiffuse.z*diffuse_mul }
	lt.specular_multiplier = specular_mul
	lt.volumetric_multiplier_wh = Color.fVolumetricMultiplier -- WH[TBa]: KCD2-259576
	lt.gi_multiplier_wh = Color.fGIMultiplier -- WH[TBa]: KCD2-328021

	lt.this_area_only = Options.bAffectsThisAreaOnly
	lt.ambient = props.Options.bAmbient
	lt.deferred_geom = Options.file_deferred_clip_geom
	lt.fake = Options.bFakeLight
	lt.ignore_visareas = Options.bIgnoresVisAreas
	lt.volumetric_fog = Options.bVolumetricFog
	lt.volumetric_fog_only = Options.bAffectsVolumetricFogOnly
	lt.fog_radial_lobe = Options.fFogRadialLobe
	lt.cutscene_light = Options.bCutsceneLight
	lt.gi_mode = Options.esGIMode -- add svoti/gi mode flags, KCD2-69768
	lt.vertical_clip_distance_downward = Options.fVerticalClipDistanceDownward -- WH[TBa]: KCD2-140451
	lt.vertical_clip_distance_upward = Options.fVerticalClipDistanceUpward -- WH[TBa]: KCD2-140451

	lt.area_physical_attenuation = Shape.bAreaPhysicalAttenuation
	lt.fade_in_radius = Shape.fFadeInRadius
	lt.near_clip = Shape.fNearClip

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

	lt.spot_shadow = Projector.bSpotShadow
	if Projector.bSpotShadow then 
		lt.spot_shadow_mask = 1 -- WH[TomK]: Spot shadow front side (KCD2-420754)
		if Projector.bSpotShadowBack 		then lt.spot_shadow_mask = lt.spot_shadow_mask + 2 end
		if Projector.bSpotShadowRight 	then lt.spot_shadow_mask = lt.spot_shadow_mask + 4 end
		if Projector.bSpotShadowLeft 		then lt.spot_shadow_mask = lt.spot_shadow_mask + 8 end
		if Projector.bSpotShadowTop 		then lt.spot_shadow_mask = lt.spot_shadow_mask + 16 end
		if Projector.bSpotShadowBottom 	then lt.spot_shadow_mask = lt.spot_shadow_mask + 32 end
	else
		lt.spot_shadow_mask = 0
	end

	lt.projector_texture = Projector.texture_Texture
	lt.proj_fov = Projector.fProjectorFov
	lt.proj_nearplane = Projector.fProjectorNearPlane

	lt.area_light = Shape.bAreaLight
	lt.area_width = Shape.fPlaneWidth
	lt.area_height = Shape.fPlaneHeight
	-- WH[TBa]: removed circular lights and support for area light textures, KCD2-337067

	lt.area_wall_thickness = Shape.fWallThickness
	lt.area_window_horizontal_margin = Shape.fWindowMarginHorizontal
	lt.area_window_vertical_margin = Shape.fWindowMarginVertical
	lt.area_wall_horizontal_chamfer = Shape.fWallChamferHorizontal
	lt.area_wall_vertical_chamfer = Shape.fWallChamferVertical

	lt.style = Style.nLightStyle
	lt.attach_to_sun = Style.bAttachToSun
	lt.anim_speed = Style.fAnimationSpeed
	lt.anim_phase = Style.nAnimationPhase
	lt.anim_type = Style.esLightAnimType
	lt.light_animation = Style.lightanimation_LightAnimation
	lt.time_scrubbing_in_trackview = Style.bTimeScrubbingInTrackView
	lt.time_scrubbed = Style._fTimeScrubbed
	lt.flare_enable = Style.bFlareEnable
	lt.flare_Flare = Style.flare_Flare
	lt.flare_FOV = Style.fFlareFOV

	lt.lightmap_linear_attenuation = 1
	lt.is_rectangle_light = 0
	lt.is_sphere_light = 0
	lt.area_sample_number = 1
	lt.indoor_only = 0

	return lt
end

-- =============================================================================
function Light:Event_Enable()
	if (self.bActive == false) then
		self:ActivateLight( true )
	end
end

-- =============================================================================
function Light:Event_Disable()
	if (self.bActive == true) then
		self:ActivateLight( false )
	end
end

-- =============================================================================
function Light:NotifySwitchOnOffFromParent(wantOn)
  local wantOff = wantOn~=true
	if (self.bActive == true and wantOff) then
		self:ActivateLight( false )
	elseif (self.bActive == false and wantOn) then
		self:ActivateLight( true )
	end
end

-- =============================================================================
function Light:UpdateLightTOD(time)
	local ranges = self._ToDActiveTable
	local numRanges = table.getn(ranges) / 2

	if numRanges == 0 then
		self.bActive = true
		self:LoadLightToSlot(LightSlot)
		self:ActivateOutput( "Active",true )
		self:SetColorParams()
		return
	end

	-- there is a ToD range specified (or more) => test if the time is inside the range
	local inRange = false

	for i = 1, numRanges, 1 do
		if ((ranges[i * 2 - 1] <= time) and (ranges[i * 2] >= time)) then
			inRange = true
			break
		end
	end

	if inRange then
		self.bActive = true
		self:LoadLightToSlot(LightSlot)
		self:ActivateOutput( "Active",true )
		self:SetColorParams()
	else
		-- time out of range => disable the light
		self.bActive = false
		self:FreeSlot(LightSlot)
		self:ActivateOutput( "Active",false )
	end
end

-- =============================================================================
-- Event Handlers
-- =============================================================================
function Light:Event_Active(sender, bActive)
	if (self.bActive == false and bActive == true) then
		self:ActivateLight( true )
	else
		if (self.bActive == true and bActive == false) then
			self:ActivateLight( false )
		end
	end
end

-- =============================================================================
-- Event descriptions
-- =============================================================================
Light.FlowEvents =
{
	Inputs =
	{
		Active = { Light.Event_Active,"bool" },
		Enable = { Light.Event_Enable,"bool" },
		Disable = { Light.Event_Disable,"bool" },
	},
	Outputs =
	{
		Active = "bool",
	},
}
