extends HBoxContainer

@onready var option_desc = $VBC/HBC2/Desc
@onready var event_desc = $VBC/HBC/PC/Desc

@onready var option_1 = $VBC/HBC2/GC/Option1
@onready var option_2 = $VBC/HBC2/GC/Option2
@onready var option_3 = $VBC/HBC2/GC/Option3
@onready var option_4 = $VBC/HBC2/GC/Option4

@export var char_scene:PackedScene 
@export var res: CharacterStats

# Called when the node enters the scene tree for the first time.
func _ready():
	check_option1(G.current_char.res)
	check_option3(G.current_char.res)
	G.current_player_changed.connect(func(): 
		check_option1(G.current_char.res)
		check_option3(G.current_char.res))
	
	_load_sara_char()

func check_option1(res:CharacterMod):
	if not res.gender == CharacterStats.GENDER.FEMALE and \
	res.race == CharacterStats.RACE.FOXKIN:
		option_1.disabled = true

func check_option3(res:CharacterMod):
	if res.race == CharacterStats.RACE.FOXKIN and \
	res.gender == CharacterStats.GENDER.FUTA:
		if res.penis_size in [CharacterTag.PENIS_SIZE.HAS_PENIS_SIZE0,
		CharacterTag.PENIS_SIZE.HAS_SOFT_PENIS_SIZE1,
		CharacterTag.PENIS_SIZE.HAS_SOFT_PENIS_SIZE2]:
			option_1.disabled = true

func _on_option_1_mouse_entered():
	option_desc.text = "It seems Sara is fond of you being a Female Foxkin as her face seems to soften a bit looking at you. “Perhaps she likes Foxkins?” you think to yourself. She gives you an expression of trust and it seems she wants to help you out. She doesn’t believe you have any ulterior motive. But she tries to hide behind her grumpy exterior pretending she wants nothing to do with you. Maybe with some pushing you can have her join your party? "


func _on_option_2_mouse_entered():
	option_desc.text = "Sara looks at you with complete distrust. She seems very disrespectful and wants nothing to do with you. You decide she isn't the type of teammate you could trust in your party on dangerous adventurers. You don’t want someone backstabbing you. Perhaps she will change her mind in the future."


func _on_option_3_mouse_entered():
	option_desc.text = "It seems Sara keeps staring at your lower region. She seems interested in something of yours. She starts to blush but tries to hide her interest in you. “Is she in heat? Does she like FoxKins?” You say to yourself as she fidgets looking uncomfortable. Perhaps you can use this to your advantage and give her what she wants?"


func _on_option_4_mouse_entered():
	option_desc.text = "Sara continues to be rude and disrespectful to you. She treats you coldly with complete distrust. Perhaps you can overpower this rude Half Fox Kin girl and make Sara yours? She deserves it after all for being a bitch."


func _on_option_3_pressed():
	print_debug("Option 3 pressed.")
	event_desc.text = "It seems Sara keeps staring at your lower region. She seems interested in something of yours. She starts to blush but tries to hide her interest in you. “Is she in heat? Does she like FoxKins?” You say to yourself as she fidgets looking uncomfortable. Perhaps you can use this to your advantage and give her what she wants?"
	%GC.visible = false
	%GC3.visible = true

func _on_GC3_option_1_mouse_entered():
	option_desc.text = "Push Sara’s head down by your stick and have her treat you."


func _on_GC3_option_2_mouse_entered():
	option_desc.text = "Kneel in front of Sara and pull her pants down. Perhaps her clit needs some attention."


func _on_GC3_option_3_mouse_entered():
	option_desc.text = "Bend that half fox kin over and pull down her pants.Slide her panties to the side and stick your huge cock into her wet pussy."


func _on_GC3_option_4_mouse_entered():
	option_desc.text = "Pull down Sara’s pants and stick your finger in her ass. Then bend her over and pull down her panties while sticking your huge cock into her ass."

func _load_sara_char():
	var char_node: Character = char_scene.instantiate()
	char_node.res = res
	add_child(char_node)
	char_node.setup_char()
