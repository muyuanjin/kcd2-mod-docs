function Startup:DogTest_startup() 
	System.Log("DogTest Startup");
	
	CombatDebug.SpawnFriend("dog");
	System.GetEntityByName('SpawnedDog_01').soul:AddBuff('61bf5b0d-aa94-45cc-9cdd-dd76d3903189');
	
end


