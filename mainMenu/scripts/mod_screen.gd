extends Control

@onready var cross = $TextureButton


# Called when the node enters the scene tree for the first time.
func _ready():
	cross.pressed.connect(func(): visible = false)


