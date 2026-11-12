@tool
class_name Margin extends Resource

@export var top: int:
	set(i):
		top = i
		emit_changed()
@export var right: int:
	set(i):
		right = i
		emit_changed()
@export var bottom: int:
	set(i):
		bottom = i
		emit_changed()
@export var left: int:
	set(i):
		left = i
		emit_changed()
