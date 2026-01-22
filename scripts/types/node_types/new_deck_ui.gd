class_name NewDeckUI extends PanelContainer


@export_group("Nodes")
@export var input: LineEdit
@export var exit_btn: TextureButton
@export var create_deck_btn: Button
@export var error_label: RichTextLabel

var error_text: String: 
	set(s): 
		error_label.text = s
		error_label.visible = true
