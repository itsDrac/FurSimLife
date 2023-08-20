extends Node

@onready var inventory_scene = preload("res://player/inventory/Inventory.tscn")
@onready var item_scene = preload("res://player/inventory/Item.tscn")
var inventory: Control

var added_items: Dictionary

enum ITEMS {
	Long_Sleeve_Shirt = 1,
	Minor_Health_Potion = 2,
	Minor_Strength_Potion,
	Vaginal_Piercing, 
	}

# Called when the node enters the scene tree for the first time.
func _ready():
	inventory = inventory_scene.instantiate()
	inventory.visible = false

func add_item(what: ITEMS):
	if added_items.has(what):
		var item = added_items.get(what)
		item.res.current_quantity += 1
		return
	var item: InventoryItem = item_scene.instantiate()
	inventory.inventory_box.add_child(item)
	item.update_item(what)
	item.mouse_entered.connect(func(): 
		inventory.update_item_desc(item.res.description))
	added_items[what] = item

func remove_item(what):
	var item = added_items.get(what)
	item.queue_free()
	added_items.erase(what)
