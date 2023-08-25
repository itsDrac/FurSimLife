class_name InventoryItem extends Button

@onready var item_label: Label = $Item/Name
@onready var type_label: Label = $Item/Type
@onready var amount: Label = $Item/Amount
@onready var value_label: Label = $Item/Value

var res: Resource

signal equiped
signal unequiped

func _ready():
	equiped.connect(when_equiped)
	unequiped.connect(when_unequiped)
#	print_debug(theme.has_stylebox("panel","styleboxflat"))
#	var selected_theme: Theme = Theme.new()
#	selected_theme.set_stylebox("Panel","StyleBoxFlat", theme_select)
#	self.theme = selected_theme
#	print_debug(self.theme_override_style.panel)

func _effect():
	pass

func _attributes():
	pass

## Load item in inventory by using number for ITEMS enum
func update_item(which: InvMan.ITEMS):
	res = load("res://player/inventory/inventoryItems/%s.gd"%which).new()
	item_label.text = res.name
	type_label.text = str(res.type)
	value_label.text = str(res.value)
	res.current_quantity_updated.connect(update_amount)
	res.current_quantity += 1

func update_amount():
	amount.text = str(res.current_quantity)

func when_equiped():
	res.when_equiped(G.current_char)

func when_unequiped():
	res.when_unequiped(G.current_char)

## Check if item is equipped of unequipped on left click and right click of mouse
func _on_gui_input(event):
	if not event is InputEventMouseButton:
		return
	if not event.pressed:
		return
	if event.button_index == MOUSE_BUTTON_LEFT:
		equiped.emit()
	elif event.button_index == MOUSE_BUTTON_RIGHT:
		unequiped.emit()
