@tool extends Node


@export_tool_button("Clear data directory") var clear_action = _clear_data_dir
@export_tool_button("Print data directory") var print_action = _print_data_dir


var DATA_DIR: String = "user://data/"
		
		
func _clear_data_dir() -> void:
	print("clearing data directory")
	var dir_names: PackedStringArray = DirAccess.get_directories_at(ProjectSettings.globalize_path(DATA_DIR))
	var index: int = 1
	var total_names: int = dir_names.size()
	for dir: String in dir_names:
		print("Moving \"%s\" to trash [%d/%d]" % [dir, index, total_names])
		OS.move_to_trash(
			ProjectSettings.globalize_path("%s/%s" % [DATA_DIR, dir])
		)
		index += 1
	

func _print_data_dir() -> void:
	for dir: String in DirAccess.get_directories_at(ProjectSettings.globalize_path(DATA_DIR)):
		print(dir)
