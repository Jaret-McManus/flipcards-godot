extends Node


func remove_children(node: Node) -> void:
	for child:Node in node.get_children():
		node.remove_child(child)


func remove_children_free(node: Node) -> void:
	for child:Node in node.get_children():
		node.remove_child(child)
		child.queue_free()


func conditional_plural(amount: int, word: String, plural_ending: String = "s"):
	return "%d %s%s" % [amount, word, plural_ending if amount != 1 else ""]
