extends Resource

var name = "Bronze Leggings"
var type = "Armor"
var value = 35
var description = "Bronze Leggings that add +3 to defense and -1 to agility."
const max_quantity = 1
var current_quantity := 0 :
	get: return current_quantity
	set(val): 
		current_quantity = val if val <= max_quantity else current_quantity
		current_quantity_updated.emit()

var is_equiped :Dictionary

signal current_quantity_updated

func when_equiped(char: Character):
	if is_equiped:
		return
	char.res.defense += 3
	char.res.agility -= 1
	current_quantity -= 1
	is_equiped[char] = true

func when_unequiped(char: Character):
	if not is_equiped.has(char):
		return
	char.res.defense -= 3
	char.res.agility += 1
	current_quantity += 1
	is_equiped.erase(char)
