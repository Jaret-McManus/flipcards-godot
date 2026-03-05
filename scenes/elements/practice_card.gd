class_name PracticeCard extends PanelContainer


@export var side_a_text: String:
	set(s):
		side_a_text = s
		_side_a_label.text = s
		
@export var side_b_text: String:
	set(s):
		side_b_text = s
		_side_b_label.text = s

@export var answer_visible: bool:
	set(b):
		answer_visible = b
		_separator.visible = b
		_side_b_label.visible = b

@export_group("Internal Nodes")
@export var _side_a_label: Label
@export var _side_b_label: Label
@export var _separator: HSeparator
