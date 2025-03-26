

function AddWeapon(entity, weaponId)
	local id = entity.inventory:FindItem(weaponId);
	if (id == nil) then
		id = ItemManager.CreateItem(weaponId, 1, 1);
		id = entity.inventory:AddItem(id);		
	end
end

function EquipWeapon(entity, weaponId)
	local id = entity.inventory:FindItem(weaponId);
	if (id ~= nil) then
		entity.actor:EquipInventoryItem(id);
	end

end

function SetRPGProfile(soul, profile)
	soul:SetSkillLevelDebug('defense', 0)
	soul:SetSkillLevelDebug('weapon_sword', 0)
	soul:SetSkillLevelDebug('weapon_unarmed', 0)
	soul:SetSkillLevelDebug('heavy_weapons', 0)
	soul:SetStatLevelDebug('agi', 5)

	if profile == "high" then
		soul:SetSkillLevelDebug('defense', RPG.SkillCap)
		soul:SetSkillLevelDebug('weapon_sword', RPG.SkillCap)
		soul:SetSkillLevelDebug('weapon_unarmed', RPG.SkillCap)
		soul:SetSkillLevelDebug('heavy_weapons', RPG.SkillCap)
		soul:SetStatLevelDebug('agi', 10)
	elseif profile == "highAgi" then
		soul:SetStatLevelDebug('agi', RPG.StatCap)
	elseif profile == "highDefense" then
		soul:SetSkillLevelDebug('defense', RPG.SkillCap)
	elseif profile == "highSword" then
		soul:SetSkillLevelDebug('weapon_sword', RPG.SkillCap)
		soul:SetSkillLevelDebug('weapon_unarmed', RPG.SkillCap)
		soul:SetSkillLevelDebug('heavy_weapons', RPG.SkillCap)
	elseif profile == "low" then
		soul:SetStatLevelDebug('agi', 1)
	else
		print("unknown profile " .. profile)
	end
end

function rd(profile)
	local soul = System.GetEntityByName("DummyTarget1").soul
	SetRPGProfile(soul, profile)
end

function rp(profile)
	SetRPGProfile(player.soul, profile)
end

function Startup:CombatTest_Startup() 
	System.Log("CombatTest Startup");
	
	local items = 
	{
		{name="longSword", 		id="FF2B21B8-C613-45FF-89C6-8A347CF37FF6"},	-- First is default
		{name="shortWeapon", 	id="c9cc366b-7192-4261-8861-be7877e9ef17"},
		{name="shield", 		id="823df2a1-bd59-4820-ab53-35e23c46149c"},
		{name="sabre", 			id="28a3a4be-3866-47be-91db-878888340674"},
		{name="dagger", 		id="6195801f-e7e4-429c-9db9-8b31a62126c8"},
		{name="axe", 			id="80425345-1243-4bc2-b3bf-40ebff4a7fba"},
		{name="mace", 			id="196be21b-6d21-4dd6-84e4-c95ecd2092a7"},
		{name="torch", 			id="4cea28a0-0814-405a-bf24-4fd711f7eb63"},
		{name="halberd", 		id="1f389792-6ddb-4060-8cc4-13bcc9117db8"},
	}
	local defaultWeapon = items[1];	
	local shouldAIDrawWeapon = true;
	
	-- buffs
	local hpBuffId = "c7c79394-cd16-4d86-a029-f8a5f6623f9d";
	local hugeInvBuffId = "1a42e06f-41c2-4d0a-bcf7-935b0c87a56a";
	
	-- Player
	for i, item in ipairs(items) do	
		AddWeapon(player, item.id);		
		if(i == 0) then
			EquipWeapon(player, defaultWeapon);
		end
	end
		
	System.GetEntityByName("Dude").soul:AddBuff(hpBuffId);
	
	-- Dummy targets
	for i=1,20 do
		local enemyName = "DummyTarget"..i;
		local enemy = System.GetEntityByName(enemyName);
		if(enemy) then
			for i, item in ipairs(items) do	
				AddWeapon(enemy, item.id);		
				if(i == 0) then
					EquipWeapon(enemy, defaultWeapon);
				end
			end	
			
			if(shouldAIDrawWeapon) then
				enemy.human:DrawWeapon();
			end
			System.GetEntityByName(enemyName).soul:AddBuff(hugeInvBuffId)
			--System.GetEntityByName(enemyName).soul:AddBuff(hpBuffId);
		end
	end
	
	-- Cuman fero
	local fero = System.GetEntityByName("cuman_fero");
	if(fero) then
		AddWeapon(fero, "c70cbea8-64fc-4309-b559-6b1ed76ea9d4");
		AddWeapon(fero, "d5e6764d-18ba-44cb-8dd0-6640a17785a8");
		AddWeapon(fero, "ad6f0f01-aec4-44d1-982c-1210eb01b74a");
	end
	
	-- Petra: for lockpicking presentation
	local id = ItemManager.CreateItem("8d76f58e-a521-4205-a7e8-9ac077eee5f0", 100, 1); g_localActor.inventory:AddItem(id);
	
end


