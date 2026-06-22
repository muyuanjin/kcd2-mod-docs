TODDrivenAnimObject = {
    Properties =
	{
		Animation = 
		{
			TimeOffset = 0
		}
	},
}

Script.ReloadScript( "Scripts/Entities/Physics/AnimObject.lua" )
EntityCommon.DeriveOverride( TODDrivenAnimObject, AnimObject )

function TODDrivenAnimObject.Server:OnUpdate(dt)
	local maxTime = 24
    local animationTime = ((Entity.GetTimeOfDayHour() + self.Properties.Animation.TimeOffset) % maxTime) / maxTime
	self:SetAnimationTime(0, 0, animationTime)
end

function TODDrivenAnimObject:SetPlaying(value)
	self.Properties.Animation.bPlaying = value
	self:OnPropertyChange()
end