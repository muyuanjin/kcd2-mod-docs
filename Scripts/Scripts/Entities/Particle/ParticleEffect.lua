ParticleEffect = {
	Properties = {
		-- basic properties
		bSaved_by_game = false,
		soclasses_SmartObjectClass = "",
		sWH_AI_EntityCategory="",

		-- C_ParticleEffect control
		ParticleEffect="",
		bActive=true,              -- Activate on

		-- unused
		Comment="",
		NetworkSync=0,          -- Do I want to be bound to the network?

		-- LoadParticleEmitter parameters
		bPrime=true,               -- Starts in equilibrium state, as if activated in past
		Scale=1,                -- Scale entire effect size.
		SpeedScale=1,           -- Scale particle emission speed
		TimeScale=1,            -- Scale emitter time evolution
		CountScale=1,           -- Scale particle counts.
		bCountPerUnit=false,        -- Multiply count by attachment extent
		Strength=-1,            -- Custom param control
		esAttachType="",        -- BoundingBox, Physics, Render
		esAttachForm="",        -- Vertices, Edges, Surface, Volume
		PulsePeriod=0,          -- Restart continually at this period.
		bRegisterByBBox=false,      -- Register In VisArea by BoundingBox, not by Position
		bLODUpdateEnabled=true,	-- LOD update system is enabled on this particle emiter

		Audio =
		{
			bEnableAudio=true,             -- Toggles update of audio data.
			audioRTPCRtpc="particlefx", -- The default audio RTPC name used.
			esSoundObstructionType = "Ignore",
		}
	},
	Editor = {
		Model="Editor/Objects/Particles.cgf",
		Icon="Particles.bmp",
	},
}
