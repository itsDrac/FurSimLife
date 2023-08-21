extends Resource

var name = "Simple Bracelet"
var type = "Accessory"
var value = 30
var description = "A simple bracelet that adds +3 to attack and +1 to strength."
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
	char.res.piercing.add(CharacterTag.ACCESSORIES.HAS_BRACELET1)
	char.res.attack += 3
	char.res.strength += 1
	current_quantity -= 1
	is_equiped[char] = true

func when_unequiped(char: Character):
	if not is_equiped.has(char):
		return
	char.res.piercing.remove(CharacterTag.ACCESSORIES.HAS_BRACELET1)
	char.res.attack -= 3
	char.res.strength -= 1
	current_quantity += 1
	is_equiped.erase(char)
