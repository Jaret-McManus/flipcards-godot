@tool
class_name FlexMarginContainer extends MarginContainer

@export_group("Flex Ratios")
@export var top_ratio: float = 0:
	set(r): top_ratio = r; _update()
	
@export var right_ratio: float = 0:
	set(r): right_ratio = r; _update()
	
@export var bottom_ratio: float = 0:
	set(r): bottom_ratio = r; _update()
	
@export var left_ratio: float = 0:
	set(r): left_ratio = r; _update()

@export var content_horizontal_ratio: float = 1:
	set(r): content_horizontal_ratio = r; _update()

@export var content_vertical_ratio: float = 1:
	set(r): content_vertical_ratio = r; _update()

@export_group("Maximums")
@export var content_x_max: float = 0:
	set(m): content_x_max = m; _update()
@export var content_y_max: float = 0:
	set(m): content_y_max = m; _update()
	

func _init():
	if not resized.is_connected(_update):
		resized.connect(_update)
	_update()

func _update() -> void:
	var new_y: int = get_window().size.y
	var new_x: int = get_window().size.x
	var vertical_sum: float = \
		top_ratio + content_vertical_ratio + bottom_ratio
	var horizontal_sum: float = left_ratio + content_horizontal_ratio + right_ratio
	
	var new_top: float = (float(top_ratio) / vertical_sum)
	add_theme_constant_override(&"margin_top", new_top)
