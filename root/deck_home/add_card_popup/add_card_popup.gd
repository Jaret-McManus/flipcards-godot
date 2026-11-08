class_name AddCardPopup extends PanelContainer

signal submitted_add_card(side_a: String, side_b: String)

@export_group("Internal Nodes")
@export var side_a_input: LineEdit
@export var side_a_error: Label
@export var side_b_input: LineEdit
@export var side_b_error: Label


func _on_submit() -> void:
	_set_error(side_a_error, "Not Implemented")
	_set_error(side_b_error, "Not Implemented")
	if false:
		submitted_add_card.emit()


func _set_error(error: Label, error_msg: String) -> void:
	error.text = error_msg
	error.visible = true
	
