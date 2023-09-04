extends HBoxContainer

@onready var vbc = $Char/VBC
@onready var teammate_option_button = $Char/VBC/TeammateOptionButton
@onready var inventory_toggle = $Char/InventoryToggle
@onready var save_toggle = $Char/SaveToggle
@export var save_screen: Control

@onready var data: PlayerData = PlayerData.new()

var char: PackedScene = preload("res://character/Character.tscn")
var team: Array[Character]
signal char_added_in_team(ply: Character)

## Load player in game and takes player name and gender from global script
func _ready():
	char_added_in_team.connect(_add_char_in_dropdown)
	_on_add_teamate()
	teammate_option_button.item_selected.emit(0)
	add_child(InvMan.inventory)
	inventory_toggle.toggled.connect(func(val): InvMan.inventory.visible = val)


func _add_char_in_dropdown(res: CharacterMod):
	var new_char: Character = char.instantiate()
	new_char.res = res
	vbc.add_child(new_char)
	new_char.setup_char()
	new_char.visible = false
	team.append(new_char)
	teammate_option_button.add_item(new_char.char_name.text, team.size())


## Addes character in Team
func _on_add_teamate(name = G.player_name, gender = G.player_gender):
	if team.size()>3:
		return
	var new_res: CharacterMod = Character.make_character(name,gender, CharacterStats.TYPES.PLAYER)
#	vbc.add_child(new_char)
#	new_char.make_character(name,gender, CharacterStats.TYPES.PLAYER)
#	new_char.visible = false
#	team[team.size()] = new_char
	data.team.append(new_res) # Player Data adding char
	char_added_in_team.emit(new_res)


func _on_teammate_option_button_item_selected(index):
	team.map(func(ch): ch.visible=false)
	team[index].visible = true
	G.current_char = team[index]

#func _on_save_pressed():
##	SaveLoadMan.save_game.emit()
#	data.test = 10
#	print_debug(data.team[0].name)
##	data.ch = team[0].duplicate()
#	SaveLoadMan._on_player_save(data)
##	PlayerData.save_player_data(data)

func _on_save_toggle_toggled(button_pressed):
	save_screen.visible = button_pressed
	


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
	_on_add_teamate("Drac 007", CharacterStats.GENDER.FUTA)


func _on_load_pressed():
	var res = SaveLoadMan._on_player_load()
	print_debug(res.team[0])
	print_debug(res)


