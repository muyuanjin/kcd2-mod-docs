CameraSource = {
	Properties = {
		bSaved_by_game = false,
		DialogueCamera = 
		{
			esDialogueCameraOverrideType = "NoOverride",
			iDialogueContextId = -1
		}
	},
	Editor={
		Icon="Camera.bmp",
	},
}

-- =============================================================================
function CameraSource:OnInit()
	self:CreateCameraProxy()
	self:SetFlags(ENTITY_FLAG_CLIENT_ONLY,0)
end
