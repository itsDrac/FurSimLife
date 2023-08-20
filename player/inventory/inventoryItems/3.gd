extends Resource

var name = "Minor Strength Potion Example"
var type = "Item"
const max_quantity = 99
var value = 20
var description = "Add +10 strength temporarily for 10 turns. (Multiple uses do not stack)"
var current_quantity := 0 :
	get: return current_quantity
	set(val): 
		current_quantity = val if val <= max_quantity else current_quantity
		current_quantity_updated.emit()

var valid_turn := 10

var is_equiped : Dictionary

signal current_quantity_updated

func _init():
	current_quantity_updated.connect(check_current_quantity)
	G.current_turn_changed.connect(check_equiped)

func check_current_quantity():
	if current_quantity == 0 :
		if not is_equiped.size():
			InvMan.remove_item(InvMan.ITEMS.Minor_Strength_Potion)

func when_equiped(char: Character):
	if not current_quantity:
		print_debug("Current Quantity is 0")
		return
	if is_equiped.has(char):
		print_debug(char,"Char already has Strength potion")
		return
	char.res.strength += 10
	is_equiped[char] = G.current_turn
	current_quantity -= 1
	print_debug(is_equiped)
	

func when_unequiped(char: Character):
	return

func check_equiped():
	var remove_char: Array[Character]
	for c in is_equiped:
		if G.current_turn - is_equiped[c] >= valid_turn:
			remove_char.append(c)
	
	if not remove_char.size():
		return
	
	for rc in remove_char:
		rc.res.strength -= 10
		is_equiped.erase(rc)
		check_current_quantity()
