@tool
class_name RichButton extends MarginContainer

@export var text: String = "":
	set(s):
		text = s
		
		if not label: label = $TextMargin/Label
		label.text = s

@export var shortcuts: Shortcut:
	set(s):
		shortcuts = s
		button.shortcut = s
		

#region margin exports
@export_group("Margin")
@export var top_margin: int:
	set(i):
		top_margin = max(i, 0)
		self["theme_override_constants/margin_top"] = top_margin
@export var right_margin: int:
	set(i):
		right_margin = max(i, 0)
		self["theme_override_constants/margin_right"] = right_margin
@export var bottom_margin: int:
	set(i):
		bottom_margin = max(i, 0)
		self["theme_override_constants/margin_bottom"] = bottom_margin
@export var left_margin: int:
	set(i):
		left_margin = max(i, 0)
		self["theme_override_constants/margin_left"] = left_margin
#endregion

#region padding exports
@export_group("Padding")
@export var top_padding: int:
	set(i): 
		top_padding = max(i, 0)
		padding["theme_override_constants/margin_top"] = top_padding
@export var right_padding: int:
	set(i): 
		right_padding = max(i, 0)
		padding["theme_override_constants/margin_right"] = right_padding
@export var bottom_padding: int:
	set(i): 
		bottom_padding = max(i, 0)
		padding["theme_override_constants/margin_bottom"] = bottom_padding
@export var left_padding: int:
	set(i): 
		left_padding = max(i, 0)
		padding["theme_override_constants/margin_left"] = left_padding
#endregion

@export_group("Internal Nodes")
@export var label: RichTextLabel
@export var padding: MarginContainer
@export var button: Button
		
