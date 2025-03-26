
InventoryWeapon = {
	Category = "approved",
	Inputs = {{"t_Activate","bool"}, {"Entity","entityid"}, {"ItemGUID","string"}, {"DrawWeapon","bool"}},
	--Outputs = {{"WeaponId","entityid"}},
	Implementation=function(bActivate,eEntity, sItemGUID, bDrawWeapon)
			--local e = System.GetEntityByName("rat_FighterDemo1")
			local ent = System.GetEntity(eEntity)
			local id = ent.inventory:FindItem(sItemGUID)
			if(id == nil) then
				id = ItemManager.CreateItem(sItemGUID, 100, 1)
				id = ent.inventory:AddItem(id)
			end
			ent.actor:EquipInventoryItem(id)
			if(bDrawWeapon) then ent.human:DrawWeapon() end

			--[[
			-- old version:
			local ent = System.GetEntity(eEntity)
			if (not ent or not ent.inventory) then return; end
			local slot = ent.inventory:FindItem(sItemGUID)
			if (not slot) then slot = ent.inventory:AddItemWithId(sItemGUID); end
			ent.human:EquipItemInSlot(slot)
			if(bDrawWeapon) then ent.human:DrawPrimaryWeapon(); end
			ItemSystem.GiveItem(sWeaponType, eEntity, true)
			--]]
		return
	end
}
