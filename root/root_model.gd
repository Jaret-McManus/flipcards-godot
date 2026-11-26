class_name RootModel extends Node

signal subview_changed(subview: SubcontentView)

@export var initial_subview_scene: PackedScene

var _current_subview: SubcontentView:
	set(sv): _current_subview = sv; subview_changed.emit(sv)


# check if `initial_subview_script` is valid then send data to view
func _ready() -> void: 
	var inital_instance: SubcontentView = initial_subview_scene.instantiate()
	_current_subview = inital_instance


func set_subview(new_subview: SubcontentView) -> void:
	_current_subview = new_subview
