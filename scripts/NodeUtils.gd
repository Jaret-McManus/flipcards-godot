class_name NodeUtils extends RefCounted


static func remove_children(node: Node) -> void:
	for child:Node in node.get_children():
		node.remove_child(child)


static func remove_children_free(node: Node) -> void:
	for child:Node in node.get_children():
		node.remove_child(child)
		child.queue_free()
