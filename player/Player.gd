extends HBoxContainer

@onready var vbc = $Char/VBC
@onready var teammate_option_button = $Char/VBC/TeammateOptionButton
@onready var inventory_toggle = $Char/InventoryToggle

var char: PackedScene = preload("res://character/Character.tscn")
var team: Dictionary = {}
signal char_added_in_team(ply: Character)

## Load player in game and takes player name and gender from global script
func _ready():
	char_added_in_team.connect(_add_char_in_dropdown)
	_on_add_teamate()
	add_child(InvMan.inventory)
	inventory_toggle.toggled.connect(func(val): InvMan.inventory.visible = val)


func _add_char_in_dropdown(ply):
	teammate_option_button.add_item(ply.char_name.text, team.find_key(ply))
	if team.find_key(ply) == 0: teammate_option_button.item_selected.emit(0)


## Addes character in Team
func _on_add_teamate(name = G.player_name, gender = G.player_gender):
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
	G.current_char = team.get(index)

func _on_save_pressed():
	print_debug("save button pressed")

## Debuging code

#func _on_attack_pressed():
#	current_player.health_bar.value -= 5



func _on_add_pressed():
	var item: InvMan.ITEMS
#	item = InvMan.ITEMS.Minor_Health_Potion
#	InvMan.add_item(item)
#	item = InvMan.ITEMS.Minor_Strength_Potion
#	InvMan.add_item(item)
#	item = InvMan.ITEMS.Long_Sleeve_Shirt
#	InvMan.add_item(item)
#	item = InvMan.ITEMS.Vaginal_Piercing
#	InvMan.add_item(item)
#	item = InvMan.ITEMS.Dragon_Sword
#	InvMan.add_item(item)
	for i in InvMan.ITEMS.values():
		InvMan.add_item(i)

func _on_turn_pressed():
	G.current_turn += 1
	print_debug("Current turn %s"%G.current_turn)


func _on_add_player_pressed():
	_on_add_teamate("Drac 007", CharacterStats.GENDER.FEMALE)
