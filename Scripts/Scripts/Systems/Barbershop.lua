
Barbershop = {}

Barbershop.barber = {}

-- =============================================================================
Barbershop.hairGUIDs = {
	"4fc88899-0dbf-f14f-9a86-444e0f4c2185",
	"4595b124-5c14-1c0c-fc61-e9ee0de417b2",
	"4a2ee070-1f7c-1855-0e98-3ec5c2e9d9b2",
	"4bc51034-3ad5-0050-f5c1-ba11046ed4ba",
}
Barbershop.chosenHairGUID = ''

-- =============================================================================
Barbershop.beardGUIDs = {
	"4f8c154f-dee8-8e81-627c-45972dba72a7",
	"40645b14-c22c-b264-bd6b-844193a30e80",
	"47bb7d4d-08fa-dbde-6781-8c9618000a96",
	"413b142e-40fb-074d-44b7-1fa4ea3de9b1",
	"4b8b7289-41e9-2785-a0b9-1651465445a5",
}
Barbershop.chosenBeardGUID = ''

-- =============================================================================
function Barbershop.Create()
	Barbershop.barber = Barber:Create(player.soul)
end

-- =============================================================================
function Barbershop.ChooseHair(hairId)
	Barbershop.chosenHairGUID = Barbershop.hairGUIDs[hairId]
end

-- =============================================================================
function Barbershop.ChooseBeard(beardId)
	Barbershop.chosenBeardGUID = Barbershop.beardGUIDs[beardId]
end

-- =============================================================================
function Barbershop.Cleanup()
	Barber:Destroy(Barbershop.barber)
	Barbershop.barber = {}
	Barbershop.chosenHairGUID = ''
	Barbershop.chosenBeardGUID = ''
end
