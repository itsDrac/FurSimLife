extends Control

@onready var view_option = $VFlowContainer/MC/GC/ViewOption
@onready var player = $Player


# Called when the node enters the scene tree for the first time.
func _ready():
	view_option.add_item("Front")
	view_option.add_item("Side")
	view_option.add_item("Back")
	player.scale = Vector2i(2,2)
#	player.char.accessories.add(CharacterTag.ACCESSORIES.HAS_NECKLACE)
#	player.char.piercing.add(CharacterTag.PIERCING.IS_FOXKINEARSPIERCED1)
#	player.char.makeup.add(CharacterTag.MAKEUP.HAS_LIPSTICK)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_view_option_item_selected(index):
	player.char.view = index


func _on_is_underwear_toggled(button_pressed):
	if button_pressed:
		player.char.lower_body_wearable.add(CharacterTag.LOWER_BODY_WEARABLE.IS_UNDERWEAR)
	else :
		player.char.lower_body_wearable.remove(CharacterTag.LOWER_BODY_WEARABLE.IS_UNDERWEAR)


func _on_is_pant_toggled(button_pressed):
	if button_pressed:
		player.char.lower_body_wearable.add(CharacterTag.LOWER_BODY_WEARABLE.IS_PANT)
	else :
		player.char.lower_body_wearable.remove(CharacterTag.LOWER_BODY_WEARABLE.IS_PANT)


func _on_is_pants_design_toggled(button_pressed):
	if button_pressed:
		player.char.lower_body_wearable.add(CharacterTag.LOWER_BODY_WEARABLE.IS_PANTS_DESIGN)
	else :
		player.char.lower_body_wearable.remove(CharacterTag.LOWER_BODY_WEARABLE.IS_PANTS_DESIGN)


func _on_is_short_toggled(button_pressed):
	if button_pressed:
		player.char.lower_body_wearable.add(CharacterTag.LOWER_BODY_WEARABLE.IS_SHORT)
	else :
		player.char.lower_body_wearable.remove(CharacterTag.LOWER_BODY_WEARABLE.IS_SHORT)


func _on_is_shorts_design_toggled(button_pressed):
	if button_pressed:
		player.char.lower_body_wearable.add(CharacterTag.LOWER_BODY_WEARABLE.IS_SHORTS_DESIGN)
	else :
		player.char.lower_body_wearable.remove(CharacterTag.LOWER_BODY_WEARABLE.IS_SHORTS_DESIGN)


func _on_is_skirt_toggled(button_pressed):
	if button_pressed:
		player.char.lower_body_wearable.add(CharacterTag.LOWER_BODY_WEARABLE.IS_SKIRT)
	else :
		player.char.lower_body_wearable.remove(CharacterTag.LOWER_BODY_WEARABLE.IS_SKIRT)


func _on_is_bra_toggled(button_pressed):
	if button_pressed:
		player.char.upper_body_wearable.add(CharacterTag.UPPER_BODY_WEARABLE.IS_BRA)
	else:
		player.char.upper_body_wearable.remove(CharacterTag.UPPER_BODY_WEARABLE.IS_BRA)


func _on_is_short_sleeve_shirt_toggled(button_pressed):
	if button_pressed:
		player.char.upper_body_wearable.add(CharacterTag.UPPER_BODY_WEARABLE.IS_SHORT_SLEEVE_SHIRT)
	else:
		player.char.upper_body_wearable.remove(CharacterTag.UPPER_BODY_WEARABLE.IS_SHORT_SLEEVE_SHIRT)


func _on_is_long_sleeve_shirt_toggled(button_pressed):
	if button_pressed:
		player.char.upper_body_wearable.add(CharacterTag.UPPER_BODY_WEARABLE.IS_LONG_SLEEVE_SHIRT)
	else:
		player.char.upper_body_wearable.remove(CharacterTag.UPPER_BODY_WEARABLE.IS_LONG_SLEEVE_SHIRT)


func _on_is_short_shirt_toggled(button_pressed):
	if button_pressed:
		player.char.upper_body_wearable.add(CharacterTag.UPPER_BODY_WEARABLE.IS_SHORT_SHIRT)
	else:
		player.char.upper_body_wearable.remove(CharacterTag.UPPER_BODY_WEARABLE.IS_SHORT_SHIRT)


func _on_is_short_shirt_design_toggled(button_pressed):
	if button_pressed:
		player.char.upper_body_wearable.add(CharacterTag.UPPER_BODY_WEARABLE.IS_SHORT_SHIRT_DESIGN)
	else:
		player.char.upper_body_wearable.remove(CharacterTag.UPPER_BODY_WEARABLE.IS_SHORT_SHIRT_DESIGN)



func _on_is_underwear_spin_value_changed(value: int):
	player.char.change_zindex("Underwear",value) 


func _on_is_pant_spin_value_changed(value):
	player.char.change_zindex("Pants",value)


func _on_is_short_spin_value_changed(value):
	player.char.change_zindex("ShortsButt",value)


func _on_is_skirt_spin_value_changed(value):
	player.char.change_zindex("SkirtsButt",value)


func _on_is_bra_spin_value_changed(value):
	player.char.change_zindex("B_Bra",value)
	player.char.change_zindex("Bra",value)
	


func _on_is_short_sleeve_shirt_spin_value_changed(value):
	player.char.change_zindex("B_ShortSleeveShirtBreasts",value)
	player.char.change_zindex("ShortSleeveShirt",value)
	player.char.change_zindex("ShortSleeveShirtArmBackSideView",value)
	player.char.change_zindex("ShortSleeveShirtArmLowerSideView",value)


func _on_is_long_sleeve_shirt_spin_value_changed(value):
	player.char.change_zindex("B_LongSleeveShirtBreasts",value)
	player.char.change_zindex("LongSleeveShirt",value)
	player.char.change_zindex("LongSleeveShirtArmBackSideView",value)
	player.char.change_zindex("LongSleeveShirtArmLowerSideView",value)
	player.char.change_zindex("LongSleeveShirtArmUpperSideView",value)
	player.char.change_zindex("BottemLongSleeveShirtButt",value)

func _on_is_short_shirt_spin_value_changed(value):
	player.char.change_zindex("B_ShortSleeveShirtBreasts",value)
	player.char.change_zindex("ShortSleeveShirt",value)
	player.char.change_zindex("ShortSleeveShirtArmBackSideView",value)
	player.char.change_zindex("ShortSleeveShirtArmLowerSideView",value)
