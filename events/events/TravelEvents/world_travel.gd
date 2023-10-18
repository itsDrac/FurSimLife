extends Control

var bg_image = "res://events/assests/images/WorldMap1.png"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_bar_pressed():
	EventManager.change_event_to.emit(
		load("res://events/events/TravelEvents/bar.tscn")
	)
