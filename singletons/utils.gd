extends Node2D

func _ready():
	pass

func change_scene(from: Node2D, to: Node2D, task: Callable = func(): return, a:=[]) -> void:
	"""
	swap scene `from` node `to` node.
	args:
		from: which scene to change from (genrealy current node)
		to: which scene to change to
		taks: callable -> do some actions before swap
		a: arguments for callable
	return: void
	"""
	var parent = from.get_parent()
	task.callv(a)
	parent.remove_child(from)
	parent.add_child(to)
	from.queue_free()
