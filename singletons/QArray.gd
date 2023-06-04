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
	elif what not in qarray:
		qarray.append(what)
	
	last_added = qarray[-1]
	item_added.emit()

func remove(what: Variant):
	var index = qarray.find(what)
	last_removed = qarray[index]
	qarray.remove_at(index)
