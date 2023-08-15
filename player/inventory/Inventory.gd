extends MarginContainer


@onready var gold = $PanelContainer/MarginContainer/VBoxContainer/Gold
@onready var item_scene = preload("res://player/inventory/Item.tscn")
@onready var inventory_box = $PanelContainer/MarginContainer/VBoxContainer/ScrollContainer/InventoryBox
@onready var item_description = $PanelContainer/MarginContainer/VBoxContainer/ItemDescription

var added_items: Dictionary

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func update_gold_value(val):
	gold.text = "Gold: %s"%val

func add_item(what: int):
#	var i = InventoryItem.new()
#	inventory_box.add_child(i)
	if added_items.has(what):
		var item = added_items.get(what)
		if item.current_quantity < item.max_quantity:
			item.current_quantity += 1
		return
	var item = item_scene.instantiate()
	inventory_box.add_child(item)
	item.mouse_entered.connect(func(): update_item_desc(item.description))
	item.update_item(what)
	added_items[what]=item

func update_item_desc(with: StringName):
	item_description.text = with

func remove_item(what: InventoryItem):
	pass
