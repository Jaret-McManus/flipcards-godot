static func create_mvc_files(path: String, scene_name: String) -> void:
	const ClassTemplateGenerator := preload("uid://c1rvvctu4sx30")
	scene_name = scene_name.to_pascal_case()
	var model_type := "%sModel" % scene_name
	var model_path := "%s/%s.gd" % [path, model_type.to_snake_case()]
	var model_file := FileAccess.open(model_path, FileAccess.WRITE)
	model_file.store_string(ClassTemplateGenerator.generate(
		model_type, "RefCounted"
	))
	
	var view_type := "%sView" % scene_name
	var view_path := "%s/%s.gd" % [path, view_type.to_snake_case()]
	var view_file := FileAccess.open(view_path, FileAccess.WRITE)
	view_file.store_string(ClassTemplateGenerator.generate(
		view_type, "View"
	))
	
	var controller_type := "%sController" % scene_name
	var controller_path := "%s/%s.gd" % [path, controller_type.to_snake_case()]
	var controller_file := FileAccess.open(controller_path, FileAccess.WRITE)
	controller_file.store_string(ClassTemplateGenerator.generate(
		controller_type, "Node"
	))
	print("done")
