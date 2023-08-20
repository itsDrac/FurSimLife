class_name InventoryItem extends HBoxContainer

@onready var item_label: Label = $Name
@onready var type_label: Label = $Type
@onready var amount: Label = $Amount
@onready var value_label: Label = $Value

var res: Resource

signal equiped
signal unequiped

func _ready():
	equiped.connect(when_equiped)
	unequiped.connect(when_unequiped)

func _effect():
	pass

func _attributes():
	pass

func update_item(which):
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

func _on_gui_input(event):
	if not event is InputEventMouseButton:
		return
	if not event.pressed:
		return
	if event.button_index == MOUSE_BUTTON_LEFT:
		equiped.emit()
	elif event.button_index == MOUSE_BUTTON_RIGHT:
		unequiped.emit()
