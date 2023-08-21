extends Resource

var name = "Dragon Sword Example"
var type = "Weapon"
var value = 9050
var description = "A divine sword that adds +15 to attack, 10 to strength, and 10 to agility."
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
	char.res.attack += 15
	char.res.strength += 10
	char.res.agility += 10
	current_quantity -= 1
	is_equiped[char] = true

func when_unequiped(char: Character):
	if not is_equiped.has(char):
		return
	char.res.attack -= 15
	char.res.strength -= 10
	char.res.agility -= 10
	current_quantity += 1
	is_equiped.erase(char)
