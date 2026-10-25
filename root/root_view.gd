class_name RootView extends View

@export var initial_subview: PackedScene

@export_group("Internal Nodes")
@export var subview_control: Control
@export var controller: RootController

@onready var model := RootModel.create(self, initial_subview)


func set_subview(view: View) -> void:
	var children := subview_control.get_children()
	for child: Node in children:
		subview_control.remove_child(child)
		child.queue_free()
	
	subview_control.add_child(view)
