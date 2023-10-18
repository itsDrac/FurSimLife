extends Node

signal change_event_to(ev)

func _ready():
	change_event_to.connect(free_event)

var current_event_node

func free_event(_ev):
	if is_instance_valid(current_event_node):
		current_event_node.queue_free()
