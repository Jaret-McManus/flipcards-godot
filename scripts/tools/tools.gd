@tool extends Node

@export_group("Make MVC files")
@export_dir var path: String
@export var scene_name: String
@export_tool_button("Create MVC files") var function = _create_mvc_files


func _create_mvc_files() -> void:
	const CreateMvcFiles = preload("uid://q1p50fobjv85")
	if not scene_name: 
		var scene_name_from_path := path.get_file()
		CreateMvcFiles.create_mvc_files(path, scene_name_from_path)
	else:
		CreateMvcFiles.create_mvc_files(path, scene_name)
	
