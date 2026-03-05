@tool 
class_name MaxSizeComponent extends Node


var _parent: Control

@export var max_width: int = -1:
	set(i): 
		max_width = max(i, -1)
		_clamp_size()
		
@export var max_height: int = -1:
	set(i): 
		max_height = max(i, -1)
		_clamp_size()
	
	
func _ready() -> void:
	_parent = get_parent() as Control
	_parent.resized.connect(_clamp_size)
	

func _clamp_size() -> void:
	if not _parent: _parent = get_parent() as Control
	print("clamp, mw: %s" % max_width)
	if max_width >= 0:
		print("changing size!")
		_parent.size.x = max_width
		_parent.size.x = min(_parent.size.x, max_width)
	if max_height >= 0:
		_parent.size.y = min(_parent.size.y, max_height)
