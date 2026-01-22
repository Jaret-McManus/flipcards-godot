extends UIState


@export var edit_card_ui: PackedScene


func on_enter(_prev_state: StringName) -> void:
	var _ui_instance: NewCardUI = edit_card_ui.instantiate()
	

func on_exit(_next_state: StringName) -> void:
	pass
