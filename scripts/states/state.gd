@abstract
class_name State extends Node


@warning_ignore("unused_signal")
signal transition(new_state_name: StringName)


func on_enter(_prev_state: StringName) -> void:
	pass


func on_exit(_next_state: StringName) -> void:
	pass


func process(_delta: float) -> void:
	pass
