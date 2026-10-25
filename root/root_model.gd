class_name RootModel extends RefCounted

var current_subview: View


static func create() -> RootModel:
	var model := RootModel.new()
	return model
