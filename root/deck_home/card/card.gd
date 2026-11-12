class_name Card extends RefCounted

var side_a_text: String
var side_b_text: String


func _init(p_side_a_text: String, p_side_b_text: String) -> void:
	side_a_text = p_side_a_text
	side_b_text = p_side_b_text
