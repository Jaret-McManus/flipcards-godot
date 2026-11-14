class_name RootModel extends RefCounted

var view: RootView

var current_subview: SubcontentView:
	set(v):
		current_subview = v
		view.set_subview(v)


static func create(p_view: ContentView, p_subcontent_view_scene: PackedScene) -> RootModel:
	var model := RootModel.new()
	model.view = p_view
	model.current_subview = p_subcontent_view_scene.instantiate()
	return model
