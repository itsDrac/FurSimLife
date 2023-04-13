extends Control

@onready var exit_button = $CenterContainer/VBoxContainer/Panel/ExitButton
var error


# Called when the node enters the scene tree for the first time.
func _ready():
	error = $CenterContainer/VBoxContainer/Panel/Error


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_exit_button_pressed():
	Utils.quit_game()
