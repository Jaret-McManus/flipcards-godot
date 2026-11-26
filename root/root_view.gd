class_name RootView extends ContentView

@export_group("Internal Nodes")
@export var subview_control: Control
@export var controller: RootController
@export var model: RootModel


func _ready() -> void: Assert.exports_nonnull(self)


func _on_subview_changed(view: SubcontentView) -> void:
	NodeUtils.remove_children_free(subview_control)
	view.bind_signals_to_root(model)
	subview_control.add_child(view)
