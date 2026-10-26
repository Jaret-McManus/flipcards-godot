class_name RootModel extends RefCounted

var view: RootView

var current_subview: View:
	set(v):
		current_subview = v
		view.set_subview(v)


static func create(p_view: View, p_initial_subview_scene: PackedScene) -> RootModel:
	var model := RootModel.new()
	model.view = p_view
	model.current_subview = p_initial_subview_scene.instantiate() as View
	return model
