class_name RootView extends ContentView

@export var initial_subview_scene: PackedScene

@export_group("Internal Nodes")
@export var subview_control: Control
@export var controller: RootController

@onready var model := RootModel.create(self, initial_subview_scene)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed(&"ui_end"):
		print("Orphan Nodes: [");print_orphan_nodes();print("]")


func set_subview(view: SubcontentView) -> void:
	var children := subview_control.get_children()
	for child: Node in children:
		subview_control.remove_child(child)
		child.queue_free()
	
	#print_orphan_nodes()
	view.bind_signals(self)
	subview_control.add_child(view)
