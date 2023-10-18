extends Control

@onready var bg = $BG
@onready var sections = $Sections
@export var current_event: PackedScene

signal update_event

# Called when the node enters the scene tree for the first time.
func _ready():
	EventManager.change_event_to.connect(show_event)
	if G.new_game:
		EventManager.change_event_to.emit(load("res://events/events/TravelEvents/world_travel.tscn"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func show_event(ev: PackedScene):
	var ev_node = ev.instantiate()
	bg.texture = load(ev_node.bg_image)
	sections.add_event_screen(ev_node)
	EventManager.current_event_node = ev_node
