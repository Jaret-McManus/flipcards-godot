class_name ControlUtils extends RefCounted


static func set_button_disabled(button: PaddedButton, disabled: bool) -> void:
	button.disabled = disabled
	button.button_focus_mode = Control.FOCUS_NONE if disabled else Control.FOCUS_ALL
