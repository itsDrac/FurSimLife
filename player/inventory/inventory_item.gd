extends Resource



signal item_equipped
signal item_unequipped

var UID: int
var name: StringName
var description: StringName
var max_quantity:int = 10
var type
var value: int
var base_damage: int
var race_for
var gender_for


func _set_uid(val):
	UID = val

func _effect():
	pass

func _attributes():
	pass
