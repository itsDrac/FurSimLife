extends Resource

var name = "Kite Shield Example"
var type = "Armor"
var value = 35
var description = "A shield that adds +15 to defense and -5 to agility."
const max_quantity = 1
@export var current_quantity := 0 :
	get: return current_quantity
	set(val): 
		current_quantity = val if val <= max_quantity else current_quantity
		current_quantity_updated.emit()

@export var is_equiped :Dictionary

signal current_quantity_updated

func when_equiped(res: CharacterMod):
	if is_equiped:
		return
	res.defense += 15
	res.agility -= 5
	current_quantity -= 1
	is_equiped[res] = true

func when_unequiped(res: CharacterMod):
	if not is_equiped.has(res):
		return
	res.defense -= 15
	res.agility += 5
	current_quantity += 1
	is_equiped.erase(res)
