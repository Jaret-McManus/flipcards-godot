extends Node


var epsilon: float = 1e-5


func remove_children(node: Node) -> void:
	for child:Node in node.get_children():
		node.remove_child(child)


func remove_children_free(node: Node) -> void:
	for child:Node in node.get_children():
		node.remove_child(child)
		child.queue_free()


func conditional_plural(amount: int, word: String, plural_ending: String = "s"):
	return "%d %s%s" % [amount, word, plural_ending if amount != 1 else ""]


func input_is_empty(ctrl: Control) -> bool:
	if ctrl is LineEdit:
		return ctrl.text.strip_edges() == ""
	elif ctrl is TextEdit:
		return ctrl.text.strip_edges() == ""
	else: 
		Error.quit("%s not implemented for Utils::input_is_empty" % ctrl.get_class())
		return false # never happens
		
		
		
		
