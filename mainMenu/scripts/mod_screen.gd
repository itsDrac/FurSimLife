extends Control

@onready var cross = $TextureButton
@onready var player_mod_container = $Panel/ScrollContainer/MarginContainer/VBoxContainer/PlayerModContainer

var check_box = preload("res://mainMenu/mod_check_box.tscn")
var player_mod_bg = load("res://mainMenu/assets/playerModBG.tres")

# Called when the node enters the scene tree for the first time.
func _ready():
	cross.pressed.connect(func(): visible = false)
	
	var player_mods = CharacterMod.get_mod_list()
	print(player_mods)
	for p in player_mods.keys():
		var btn = check_box.instantiate()
		btn.text = p
		
		btn.button_group = player_mod_bg
		player_mod_container.add_child(btn)


