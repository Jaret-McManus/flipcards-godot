class_name AddDeckPopup extends PanelContainer

signal add_deck_submitted(deck_name: String)
signal close_popup()

@export_group("Internal Nodes")
@export var name_input: LineEdit
@export var name_error: Label


func setup_open() -> void:
	name_input.text = ""
	name_error.text = ""
	name_input.grab_focus()


func _on_cancel() -> void: 
	print("on_cancel")
	close_popup.emit()


func _on_submit() -> void: add_deck_submitted.emit(name_input.text)


func _on_name_input_gui_input(event: InputEvent) -> void:
	if event.is_action(&"ui_cancel"): _on_cancel()
