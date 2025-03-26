ItemUtils = {}

-- =============================================================================
-- Item IDs
-- =============================================================================
ItemUtils.itemIDs = {}
ItemUtils.itemIDs.money = '5ef63059-322e-4e1b-abe8-926e100c770e'
ItemUtils.itemIDs.cizeks_dagger = '67ef62fd-7d5a-4235-b68e-eede03cd9c99'
ItemUtils.itemIDs.necronomicon_treasure = '7becbe4a-c4b4-448e-bb12-5a383da1db31'
ItemUtils.itemIDs.bloodSack = '76bada6c-15b5-4109-9857-0a261162849c'
ItemUtils.itemIDs.lockpick = '8d76f58e-a521-4205-a7e8-9ac077eee5f0'
ItemUtils.itemIDs.monasteryKey = '56be1ad5-676e-4b6d-9d6d-e94f3164a90c'
ItemUtils.itemIDs.berans_chalice = 'b16db2b4-788a-4a04-8b9a-6ecfebcfc8ec'
ItemUtils.itemIDs.raven_feather = '2bf46965-a851-4602-8282-cbefe7f24945'
ItemUtils.itemIDs.wolf_teeth = '7b1c57a3-54fd-441f-8cad-21157bd1a85b'
ItemUtils.itemIDs.black_feather = 'c5b24e5e-69f0-4ed9-bc74-96c3de9dc677'
ItemUtils.itemIDs.boar_tooth = 'a4f0f4c8-dc3f-4cb2-be89-f0f56fbb09fa'
ItemUtils.itemIDs.dog_skin = 'c0dd0e15-8cb8-4342-9a4b-eb3d217421c9'
ItemUtils.itemIDs.newhomes_prib_report = 'f37ae0ba-bdad-44e9-8f85-027cacf963a8'
ItemUtils.itemIDs.newhomes_rat_report = '9036ea9d-c80a-4e0b-b0a1-09eb15efc449'
ItemUtils.itemIDs.dlc4_matej_die = 'c56c54b5-b113-41ce-a250-b4eb137909bc'

-- =============================================================================
-- Null Guid
-- =============================================================================
nullGuid = '00000000-0000-0000-0000-000000000000'

function ItemUtils.IsNullWeaponGuid(guidString)
	if guidString == '4a062aa5-84a3-6d09-6dc7-a62e63133db3' or guidString == '10101010-c8cb-81dd-40f1-2f0554804f83' or guidString == nullGuid then
		return true
	end
	return false
end

-- =============================================================================
-- Creates an item in someone's inventory.
function ItemUtils.CreateInvItem(who, itemID, amount, health)
	amount = amount or 1
	health = health or 1
	local item

	-- try converting item given by string by retrieving ID from table of itemIDs above
	if ItemUtils.itemIDs[itemID] ~= nil then
		itemID = ItemUtils.itemIDs[itemID]
	end

	who.inventory:CreateItem(itemID, health, amount)

	if who == player then
		Game.ShowItemsTransfer(itemID, amount)
	end

	return item
end

-- =============================================================================
-- @amount: <nil> = remove all
-- Removes an item from someone's inventory.
function ItemUtils.RemoveInvItem(who, itemGUID, amount, notify)
	amount = amount or -1
	amount = who.inventory:DeleteItemOfClass(itemGUID, amount)

	if notify and who == player then
		Game.ShowItemsTransfer(itemGUID, -amount)
	end
end

-- =============================================================================
-- Moves an item from someone's inventory to someone else's inventory.
-- MOVING MONEY: Uses decagroschen!!!!! ie. wanna move 12.5 gr.? Set amount to 125.
function ItemUtils.GiveItem(who, whom, itemID, amount)
	amount = amount or -1
	local inv = who.inventory

	-- try converting item given by string by retrieving ID from table of itemIDs above
	if ItemUtils.itemIDs[itemID] ~= nil then
		itemID = ItemUtils.itemIDs[itemID]
	end

	-- item transaction
	local amountMoved = inv:MoveItemOfClass(whom.inventory:GetId(), itemID, amount, true)
	assert(amountMoved == amount, StrFormat("Item with ID '%s' has not moved entirely. Moved %d out of %d", itemID, amountMoved, amount))

	if whom == player then
		Game.ShowItemsTransfer(itemID, amountMoved)
	end

	if who == player then
		Game.ShowItemsTransfer(itemID, -amountMoved)
	end
end

-- =============================================================================
-- Returns whether someone has a particular item in inventory.
function ItemUtils.HasItem(who, itemID)
	local inv = who.inventory
	return inv:FindItem(itemID) ~= nil
end

-- =============================================================================
function ItemUtils.GiveItemToPlayer(itemGuid, itemAmount)
	local amount = itemAmount or 1

	-- itemId: id of the instance created from itemGuid (template)
	local itemId = ItemManager.CreateItem(itemGuid, 1, amount)
	player.inventory:AddItem(itemId)

	Game.ShowItemsTransfer(itemGuid, itemAmount)
end

-- =============================================================================
function ItemUtils.DeliverItemByPlayer(itemGuid, itemAmount, notify)
	ItemUtils.RemoveInvItem(player, itemGuid, itemAmount, notify)
end

-- =============================================================================
function ItemUtils.IsItemInInventory(who, what)
	itemCount = who.inventory:GetCountOfClass(what)
	if itemCount > 0 then
		return 1
	else
		return 0
	end
end

-- =============================================================================
function ItemUtils.CheckMoneyAmount(who, amount)
	local number = who.inventory:GetCountOfClass("5ef63059-322e-4e1b-abe8-926e100c770e")
	if number < amount then
		return 0
	else
		return 1
	end
end

-- =============================================================================
function ItemUtils.AddMoneyToInventory(who, amount)
	local id = ItemManager.CreateItem("5ef63059-322e-4e1b-abe8-926e100c770e", 1, amount)
	who.inventory:AddItem(id)
	if (who == player) then
		Game.ShowItemsTransfer("5ef63059-322e-4e1b-abe8-926e100c770e", amount)
	end
end

-- =============================================================================
function ItemUtils.RemoveMoneyFromInventory(who, amount, notify)
	ItemUtils.RemoveInvItem(who, "5ef63059-322e-4e1b-abe8-926e100c770e", amount, notify)
end

-- =============================================================================
function ItemUtils.MoneyTransaction(from, to, amount)
	ItemUtils.RemoveMoneyFromInventory(from, amount)
	ItemUtils.AddMoneyToInventory(to, amount)

	if (from == player) then
		Game.ShowItemsTransfer("5ef63059-322e-4e1b-abe8-926e100c770e", -amount)
	end

	if (to == player) then
		Game.ShowItemsTransfer("5ef63059-322e-4e1b-abe8-926e100c770e", amount)
	end
end