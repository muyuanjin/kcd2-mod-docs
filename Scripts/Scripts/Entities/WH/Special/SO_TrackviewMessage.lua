-- =============================================================================
-- Sending AI message via Event in Trackview
-- =============================================================================

SO_TrackviewMessage =
{
	Properties =
	{
		EntityName =
		{
			esReceiverEntityName = '',
			esSecondaryParametr = '',
		},
	},

	Editor =
	{
		Icon = "trackviewMessage.bmp"
	},

}

function SO_TrackviewMessage:Event_SendAIMessage(sender, params)
--	System.Log(">>>>>>> ZPRAVA AICKO TRACKVIEW ")

--	System.Log("params: ")
--	System.Log(params)

	local messageData =
			{
				alias = params,
				type = self.Properties.EntityName.esSecondaryParametr
			}
	XGenAIModule.SendMessageToEntityData(System.GetEntityByName(self.Properties.EntityName.esReceiverEntityName).this.id,'trackviewMessage',messageData);
	
end



SO_TrackviewMessage.FlowEvents =
{
	Inputs =
	{
		SendAIMessage = { SO_TrackviewMessage.Event_SendAIMessage, "string" },
	},
	Outputs =
	{		
	},
}

EntityCommon.MakeUsable(SO_TrackviewMessage);

