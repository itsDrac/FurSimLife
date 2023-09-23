extends PanelContainer

var progress: Array[float]
@export var scene_name: StringName
var scene_load_status = 0
var _loading := false
@onready var progress_bar = $CC/VBC/Panel/ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not _loading:
		return
	scene_load_status = ResourceLoader.load_threaded_get_status(scene_name,progress)
	progress_bar.value = progress[0]*100
	if scene_load_status == ResourceLoader.THREAD_LOAD_LOADED:
		var new_scene = ResourceLoader.load_threaded_get(scene_name)
		_loading = false 
		Utils.change_scene(get_parent_control(), new_scene.instantiate())

func load_scene(scene_path: StringName):
	visible = true
	scene_name = scene_path
	ResourceLoader.load_threaded_request(scene_name)
	_loading = true
