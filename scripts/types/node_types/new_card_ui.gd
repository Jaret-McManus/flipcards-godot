class_name NewCardUI extends PanelContainer

@export_group("Nodes")
@export var exit_btn: TextureButton
@export var side_a_input: LineEdit
@export var side_a_error: RichTextLabel
@export var side_b_input: TextEdit
@export var side_b_error: RichTextLabel
@export var submit_btn: Button


var side_a_text: String:
	get(): return side_a_input.text
	
var side_b_text: String:
	get(): return side_b_input.text

var side_a_error_text: String:
	set(s):
		side_a_error.text = s
		side_a_error.visible = true

var side_b_error_text: String:
	set(s):
		side_b_error.text = s
		side_b_error.visible = true
