extends Node

@onready var inventory_scene = preload("res://player/inventory/Inventory.tscn")
@onready var item_scene = preload("res://player/inventory/Item.tscn")
var inventory: Control

var added_items: Dictionary

enum ITEMS {
	Long_Sleeve_Shirt = 1,
	Minor_Health_Potion = 2,
	Minor_Strength_Potion = 3,
	Vaginal_Piercing = 4,
	Dragon_Sword = 5,
	Simple_Skirt = 6,
	Ear_Ring = 7,
	Simple_Bracelet = 8,
	Ancient_Necklace = 9,
	Poorly_Made_Staff = 10,
	Bronze_Leggings = 11,
	Kite_Shield = 12,
	BRA = 13,
	Underware = 14,
	Short_Sleeve_Shirt = 15,
	Pants = 16
	}

# Called when the node enters the scene tree for the first time.
func _ready():
	inventory = inventory_scene.instantiate()
	inventory.visible = false
	SaveLoadMan.save_game.connect(save_inv)

func add_item(what: ITEMS):
	if added_items.has(what):
		var item = added_items.get(what)
		item.res.current_quantity += 1
		return
	var item: InventoryItem = item_scene.instantiate()
	item.res = item.get_item_res(what)
	inventory.inventory_box.add_child(item)
	item.res.current_quantity += 1
	item.mouse_entered.connect(func(): 
		inventory.update_item_desc(item.res.description))
	added_items[what] = item

func add_loaded_item(load_res):
	var item: InventoryItem = item_scene.instantiate()
	item.res = load_res
	inventory.inventory_box.add_child(item)
	item.res.current_quantity = load_res.current_quantity 
	item.mouse_entered.connect(func(): 
		inventory.update_item_desc(item.res.description))
	return item

func remove_item(what):
	var item = added_items.get(what)
	item.queue_free()
	added_items.erase(what)

func save_inv(save_res):
	print_debug(save_res)
	for item in added_items.keys():
		save_res.inventory_items[item] = added_items[item].res

func load_inv(load_res):
	var items = load_res.inventory_items
	for item in items:
		
		added_items[item] = add_loaded_item(items[item])
