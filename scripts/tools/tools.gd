@tool extends Node

@export_group("Make MVC files")
@export_dir var path: String
@export var scene_name: String
@export_tool_button("Create MVC files") var function: Callable = _create_mvc_files

@export_group("Make Result Type")
@export_dir var type: String
@export_tool_button("Create Result Type") var function_result: Callable = _create_result_type


func _create_mvc_files() -> void:
	const CreateMvcFiles = preload("uid://q1p50fobjv85")
	if not scene_name: 
		var scene_name_from_path := path.get_file()
		CreateMvcFiles.create_mvc_files(path, scene_name_from_path)
	else:
		CreateMvcFiles.create_mvc_files(path, scene_name)
	

func _create_result_type() -> void:
	const CreateResultType = preload("uid://ckiujdcptj0kb")
	if not type: 
		push_error("Inner type needed to generate result type")
	else:
		CreateResultType.generate_into_clipboard(type)
