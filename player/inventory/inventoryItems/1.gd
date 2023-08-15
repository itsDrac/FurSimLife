extends Resource

var name = "Long Sleeve Shirt"
var type = "Clothing"
var value = 20
var description = "A purple comfy Long Sleeve Shirt that adds +2 to defense and +2 to role reputation."
const max_quantity = 1

var equiped: bool = false

func when_equiped(char: Character):
	if char.equiped_items.has(InventoryItem.ITEMS.Long_Sleeve_Shirt):
		return
	char.res.defense += 2
	char.res.role_reputation += 2
	char.equiped_items.append(InventoryItem.ITEMS.Long_Sleeve_Shirt)

func when_unequiped(char: Character):
	if not char.equiped_items.has(InventoryItem.ITEMS.Long_Sleeve_Shirt):
		return
	char.res.defense -= 2
	char.res.role_reputation -= 2
	char.equiped_items.erase(InventoryItem.ITEMS.Long_Sleeve_Shirt)
