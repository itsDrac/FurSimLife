extends MarginContainer

@onready var gold = $PanelContainer/MarginContainer/VBoxContainer/Gold
@onready var item_scene = preload("res://player/inventory/Item.tscn")
@onready var inventory_box = $PanelContainer/MarginContainer/VBoxContainer/ScrollContainer/InventoryBox
@onready var item_description = $PanelContainer/MarginContainer/VBoxContainer/ItemDescription

# Called when the node enters the scene tree for the first time.
func _ready():
	update_gold_value(100)

func update_gold_value(val):
	gold.text = "Gold: %s"%val

func update_item_desc(with: StringName):
	item_description.text = with
