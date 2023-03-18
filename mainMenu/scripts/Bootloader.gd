extends Control


@onready var logo = $CenterContainer/Logo
@onready var banner = $CenterContainer/Banner
@onready var ap = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	logo.visible = true
	ap.play("fade")
	await get_tree().create_timer(2.0).timeout
	ap.play_backwards("fade")
	await ap.animation_finished
	logo.visible = false
	banner.visible = true
	ap.play("fade")
	await get_tree().create_timer(3.0).timeout
	ap.play_backwards("fade")
	await ap.animation_finished
	var menu = preload("res://mainMenu/main_menu.tscn").instantiate()
	Utils.change_scene(self, menu)
