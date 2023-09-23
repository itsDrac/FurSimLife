extends Resource

var name = "Minor Health Potion Example"
var type = "Item"
const max_quantity = 99
var value = 20
var description = "A simple potion that heals 5 health."
@export var current_quantity := 0 :
	get: return current_quantity
	set(val): 
		current_quantity = val if val <= max_quantity else current_quantity
		current_quantity_updated.emit()
@export var is_equiped :Dictionary

signal current_quantity_updated

func _init():
	current_quantity_updated.connect(check_current_quantity)

func when_equiped(res: CharacterMod):
	res.health += 5
	current_quantity -= 1

func when_unequiped(res: CharacterMod):
	return

func check_current_quantity():
	if current_quantity == 0 :
		InvMan.remove_item(InvMan.ITEMS.Minor_Health_Potion)
