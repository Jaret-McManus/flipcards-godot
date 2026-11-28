class_name ControlUtils extends RefCounted

const ObjectOption = Option.ObjectOption

static func set_button_disabled(button: PaddedButton, disabled: bool) -> void:
	button.disabled = disabled
	button.button_focus_mode = Control.FOCUS_NONE if disabled else Control.FOCUS_ALL


static func find_inherited_theme(current_node: Node) -> ObjectOption:
	while current_node:
		var control: Control = current_node as Control
		if control and control.theme:
			return ObjectOption.some(control.theme)
		current_node = current_node.get_parent()
	
	return ObjectOption.none()
