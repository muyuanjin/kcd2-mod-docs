-- =============================================================================
-- This entity allows to trigger relative places sequence
-- =============================================================================
SequenceTrigger =
{
    Properties =
    {
        Sequence = "",
    },
}

-- =============================================================================
function SequenceTrigger:ReportUse(user,items,action)

    if(self.Properties.Sequence~="")then
        local seq = System.GetEntityByName(self.Properties.Sequence)
        if (seq) then
            local worldPos = self:GetWorldPos()
            seq:SetPos(worldPos)
            local dir = self:GetDirectionVector()
            if self.Properties.bPlayerRelative == 1 then
                --System.Log("Relative")
                local playerPos = g_localActor:GetPos()
                dir = VectorUtils.Subtract(worldPos, playerPos)
                dir.z = 0
                dir = VectorUtils.Normalize(dir)
            end
            seq:SetDirectionVector(dir)
            Movie.PlaySequence(self.Properties.Sequence)
        end
    end

    self:BaseReportUse( user, items, action )
end

-- =============================================================================
-- Compose entity
-- =============================================================================
Script.ReloadScript( "SCRIPTS/Entities/WH/Triggers/TriggerBase.lua")
table.Merge(SequenceTrigger, TriggerBase)
SequenceTrigger.BaseReportUse = TriggerBase.ReportUse