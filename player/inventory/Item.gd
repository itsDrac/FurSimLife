class_name InventoryItem extends HBoxContainer

@onready var item_name: Label = $Name
@onready var type: Label = $Type
@onready var amount: Label = $Amount
@onready var value: Label = $Value
var description

enum ITEM_TYPE {
	CLOTHING,
	PIERCING,
	ACCESSORY,
	WEAPON,
	ARMOR,
	ITEM
}

enum ITEMS {
	Long_Sleeve_Shirt = 1
}

@export var UID: int
@export var max_quantity:int = 10
@export var current_quantity: int = 0 :
	get: return current_quantity
	set(val):
		current_quantity = val
		amount.text = str(current_quantity)
@export var base_damage: int
@export_enum("Human","Foxkin","Mothkin","Halffoxkin") var race_for
@export_enum("Male","Female","Futa") var gender_for

signal equiped
signal unequiped

func _set_uid(val):
	UID = val

func _effect():
	pass

func _attributes():
	pass


func update_item(which):
	var what = load("res://player/inventory/inventoryItems/%s.gd"%which).new()
	item_name.text = what.name
	type.text = str(what.type)
	value.text = str(what.value)
	current_quantity += 1
	description = what.description
	max_quantity = what.max_quantity
	equiped.connect(func(): what.when_equiped(G.current_char))
	unequiped.connect(func(): what.when_unequiped(G.current_char))


func _on_gui_input(event):
	if not event is InputEventMouseButton:
		return
	if not event.pressed:
		return
	if event.button_index == MOUSE_BUTTON_LEFT:
		print_debug(get_parent_control())
		equiped.emit()
	elif event.button_index == MOUSE_BUTTON_RIGHT:
		unequiped.emit()
