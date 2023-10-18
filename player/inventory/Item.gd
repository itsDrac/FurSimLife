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
	ready.connect(when_ready)
	res.current_quantity_updated.connect(update_amount)

func _effect():
	pass

func _attributes():
	pass

func when_ready():
	if not res: return
	item_label.text = res.name
	type_label.text = str(res.type)
	value_label.text = str(res.value)


func get_item_res(which: InvMan.ITEMS):
	return load("res://player/inventory/inventoryItems/%s.gd"%which).new()


func update_amount():
	amount.text = str(res.current_quantity)

func when_equiped(to=G.current_char.res):
	res.when_equiped(to)

func when_unequiped(to=G.current_char.res):
	res.when_unequiped(to)

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
