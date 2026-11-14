class_name RootModel extends RefCounted

var view: RootView

var current_subview: SubcontentView:
	set(v):
		current_subview = v
		view.set_subview(v)


static func create(p_view: ContentView, p_initial_subview_scene: PackedScene) -> RootModel:
	var model := RootModel.new()
	model.view = p_view
	var subview: SubcontentView = p_initial_subview_scene.instantiate() as SubcontentView
	model.current_subview = subview
	return model
