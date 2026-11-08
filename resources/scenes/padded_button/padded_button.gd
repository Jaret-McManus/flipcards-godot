@tool
class_name PaddedButton extends MarginContainer

signal pressed

@export var text: String:
	set(s):
		text = s
		label.text = s
@export var shortcut: Shortcut:
	set(s):
		shortcut = s
		inner_button.shortcut = s
@export var disabled: bool:
	set(b):
		disabled = b
		inner_button.disabled = b
@export var button_focus_mode: FocusMode = Control.FOCUS_ALL:
	set(fm):
		button_focus_mode = fm
		if inner_button: inner_button.focus_mode = fm

@export_group("Text")
@export var alignment: HorizontalAlignment:
	set(ha):
		alignment = ha
		label.horizontal_alignment = ha

@export_group("Margin")
@export var top_margin: int = 0:
	set(i):
		top_margin = i
		self["theme_override_constants/margin_top"] = i
@export var right_margin: int = 0:
	set(i):
		right_margin = i
		self["theme_override_constants/margin_right"] = i
@export var bottom_margin: int = 0:
	set(i):
		bottom_margin = i
		self["theme_override_constants/margin_bottom"] = i
@export var left_margin: int = 0:
	set(i):
		left_margin = i
		self["theme_override_constants/margin_left"] = i
@export_tool_button("Set all margin") var set_all_margin: Callable = _set_all_margin
@export var all_margin: int = 0


@export_group("Padding")
@export var top_padding: int = 0:
	set(i):
		top_padding = i
		padding_container["theme_override_constants/margin_top"] = i
@export var right_padding: int = 0:
	set(i):
		right_padding = i
		padding_container["theme_override_constants/margin_right"] = i
@export var bottom_padding: int = 0:
	set(i):
		bottom_padding = i
		padding_container["theme_override_constants/margin_bottom"] = i
@export var left_padding: int = 0:
	set(i):
		left_padding = i
		padding_container["theme_override_constants/margin_left"] = i

@export_tool_button("Set all padding") var set_all_padding: Callable = _set_all_padding
@export var all_padding: int = 0

@export_group("Internal Nodes")
@export var inner_button: Button
@export var padding_container: MarginContainer
@export var label: RichTextLabel


func _ready() -> void:
	inner_button.pressed.connect(pressed.emit)
	inner_button.focus_mode = button_focus_mode


func _set_all_padding() -> void:
	top_padding = all_padding
	right_padding = all_padding
	bottom_padding = all_padding
	left_padding = all_padding


func _set_all_margin() -> void:
	top_margin = all_margin
	right_margin = all_margin
	bottom_margin = all_margin
	left_margin = all_margin
