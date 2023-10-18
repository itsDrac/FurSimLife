extends Control

var bg_image = "res://events/assests/images/Bar_City1.png"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_talk_pressed():
	$Base.visible = false
	var sara_event = load("res://events/events/DialogueEvents/talk_to_sara.tscn").instantiate()
	add_child(sara_event)
	

func _on_back_pressed():
	EventManager.change_event_to.emit(
		load("res://events/events/TravelEvents/world_travel.tscn")
	)
