extends Control

@onready var option_button = $OptionButton
@onready var player = $Player
@onready var player_2 = $Player2
@onready var player_3 = $Player3
@onready var player_4 = $Player4


# Called when the node enters the scene tree for the first time.
func _ready():
	option_button.add_item("Front")
	option_button.add_item("Side")
	option_button.add_item("Back")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_option_button_item_selected(index):
	player.change_view(index)
	player_2.change_view(index)
	player_3.change_view(index)
	player_4.change_view(index)
