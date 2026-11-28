@tool
class_name PaddedButton extends MarginContainer

signal pressed

@export var text: String:
	set(s): text = s; label.text = s
@export var disabled: bool:
	set(b): disabled = b; inner_button.disabled = b
@export var button_focus_mode: FocusMode = Control.FOCUS_ALL:
	set(fm): 
		button_focus_mode = fm
		if inner_button: inner_button.focus_mode = fm

@export_subgroup("Shortcut")
@export var shortcut: Shortcut:
	set(s): shortcut = s; inner_button.shortcut = s
@export var shortcut_in_tooltip: bool:
	set(b): shortcut_in_tooltip = b; inner_button.shortcut_in_tooltip = b

@export_group("Text")
@export var alignment: HorizontalAlignment:
	set(ha): alignment = ha; label.horizontal_alignment = ha
@export var font_size: int:
	set(i):
		font_size = i
		label.add_theme_font_size_override("normal_font_size", font_size)

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

@export_group("Theme")
var theme_variation: StringName = &"":
	set(sn): theme_variation = sn; _apply_variation()

@export_group("Internal Nodes")
@export var inner_button: Button
@export var padding_container: MarginContainer
@export var label: RichTextLabel


func _ready() -> void:
	inner_button.pressed.connect(pressed.emit)
	inner_button.focus_mode = button_focus_mode
	_apply_variation()


#region Populate Button Themes
func _get_property_list() -> Array[Dictionary]:
	var variations: PackedStringArray = _get_button_variations()
	# Add a leading comma so selecting the empty option resets it to default
	var hint_str: String = "," + ",".join(variations)
	
	return [
		{
			"name": "Theme", 
			"type": TYPE_NIL,
			"usage": PROPERTY_USAGE_GROUP
		},
		{
			"name": "theme_variation",
			"type": TYPE_STRING_NAME,
			"usage": PROPERTY_USAGE_DEFAULT,
			"hint": PROPERTY_HINT_ENUM,
			"hint_string": hint_str
		}
	]


func _get_button_variations() -> PackedStringArray:
	var names: PackedStringArray = []
	
	# 1. Check for a Theme assigned to this node or an ancestor in the scene tree
	var active_theme_option := ControlUtils.find_inherited_theme(self)
	if active_theme_option.is_some():
		var active_theme: Theme = active_theme_option.value as Theme
		names.append_array(active_theme.get_type_variation_list(&"Button"))
	
	# 2. Check the global Project Settings theme
	var project_theme: Theme = ThemeDB.get_project_theme()
	if project_theme:
		for v in project_theme.get_type_variation_list(&"Button"):
			if not names.has(v): names.append(v)
	
	names.sort()
	return names


func _property_can_revert(property: StringName) -> bool:
	return property == &"theme_variation" and theme_variation != &""


func _property_get_revert(property: StringName) -> Variant:
	if property == &"theme_variation": return &""
	return null


func _apply_variation() -> void:
	if is_instance_valid(inner_button):
		inner_button.theme_type_variation = theme_variation
#endregion


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
