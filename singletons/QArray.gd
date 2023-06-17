extends Resource
class_name QArray

var qarray: Array
var last_added: Variant
var last_removed: Variant

signal item_added
signal item_removed

func _to_string():
	return str(qarray)

func append(what:Array):
	for a in what:
		add(a)

func add(what: Variant):
	if typeof(what) == TYPE_ARRAY:
		append(what)
	elif qarray.find(what) == -1:
		qarray.append(what)
	else :
		return
	last_added = qarray[-1]
	item_added.emit()

func remove(what: Variant):
	var index = qarray.find(what)
	if index == -1: return
	last_removed = qarray[index]
	qarray.remove_at(index)
	item_removed.emit()

func for_each(do: Callable):
	for item in qarray:
		do.call(item)
