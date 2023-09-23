extends MarginContainer

@onready var game_grid = $VBoxC/PC/MC/VBoxC
@export var save_button_path: PackedScene
var save_mode := true:
	get: return save_mode
	set(val):
		save_mode = val
		$VBoxC/PC/MC/VBoxC/FileName.visible = save_mode
var just_saved := true
signal clicked_save(file_name: StringName)

# Called when the node enters the scene tree for the first time.
func _ready():
	visibility_changed.connect(_show_saved_games)

func is_updated(num: int):
	return !game_grid.get_child_count() - 2 == num

func add_button_in_grid(file_name, modified_date):
	var save_btn: Button = save_button_path.instantiate()
	save_btn.pressed.connect(func(): on_button_click(save_btn))
	save_btn.get_node("./FN").text = file_name
	save_btn.get_node("./LM").text = Time.get_date_string_from_unix_time(modified_date)
	game_grid.add_child(save_btn)

func _show_saved_games():
	if not visible: return
#	if not is_updated(SaveLoadMan.total_saved_files):
#		print_debug("No New file has been detected")
#		return
	if not just_saved:
		print_debug("Note: No update is required in screen button.")
		return
	for ch in game_grid.get_children():
		if ch.is_in_group("SaveLoadBtn"):
			ch.queue_free()
#	print_debug("TODO: remove all the btn that are in SaveLoadBtn group")
	just_saved = false
	var saved_files = SaveLoadMan.get_saved_files()
	for save_file in saved_files:
		add_button_in_grid(save_file[0],save_file[1])

func _on_file_name_text_submitted(new_text):
	clicked_save.emit(new_text)
	just_saved = true

func on_button_click(btn: Button):
	clicked_save.emit(btn.get_node("./FN").text)
	just_saved = true
