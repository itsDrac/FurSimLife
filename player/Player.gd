extends HBoxContainer

@onready var vbc = $Char/VBC
@onready var teammate_option_button = $Char/VBC/TeammateOptionButton
@onready var inventory_toggle = $Char/InventoryToggle


var char: PackedScene = preload("res://character/Character.tscn")
var team: Dictionary = {}
var current_player: Character
signal char_added_in_team(ply)

func _ready():
	print_debug(char)
	char_added_in_team.connect(_add_char_in_dropdown)
	_on_add_teamate_pressed()
	inventory_toggle.toggled.connect(func(val): $Inventory.visible = val)
#	print_debug(char)

func _add_char_in_dropdown(ply):
	teammate_option_button.add_item(ply.char_name.text, team.find_key(ply))
	if team.find_key(ply) == 0: teammate_option_button.item_selected.emit(0)


func _on_add_teamate_pressed(name = G.player_name, gender = G.player_gender):
	if team.size()>3:
		return
	var new_char: Character = char.instantiate()
	vbc.add_child(new_char)
	new_char.make_character(name,gender, CharacterStats.TYPES.PLAYER)
	new_char.visible = false
	team[team.size()] = new_char
	char_added_in_team.emit(new_char)


func _on_teammate_option_button_item_selected(index):
	for ply_id in team:
		team[ply_id].visible = true if ply_id == index else false
	current_player = team.get(index)


func _on_attack_pressed():
	current_player.health_bar.value -= 5
