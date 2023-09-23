extends Resource

var name = "Dragon Sword Example"
var type = "Weapon"
var value = 9050
var description = "A divine sword that adds +15 to attack, 10 to strength, and 10 to agility."
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
	res.attack += 15
	res.strength += 10
	res.agility += 10
	current_quantity -= 1
	is_equiped[res] = true

func when_unequiped(res: CharacterMod):
	if not is_equiped.has(res):
		return
	res.attack -= 15
	res.strength -= 10
	res.agility -= 10
	current_quantity += 1
	is_equiped.erase(res)
