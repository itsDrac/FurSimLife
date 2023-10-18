extends HBoxContainer

@onready var player = $Player
@onready var content_screen = $ContentScreen


# Called when the node enters the scene tree for the first time.
func _ready():
	InvMan.inventory.visibility_changed.connect(handle_player_size)
	SaveLoadMan.save_screen.visibility_changed.connect(handle_player_size)

func handle_player_size():
	if InvMan.inventory.visible or SaveLoadMan.save_screen.visible:
		content_screen.visible = false
		player.size_flags_horizontal = SIZE_EXPAND_FILL
	else:
		content_screen.visible = true
		player.size_flags_horizontal = SIZE_FILL

func add_event_screen(ev_node):
	content_screen.add_child(ev_node)
