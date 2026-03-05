class_name PresentCardState extends PracticeState


func on_enter(_prev_state: StringName) -> void:
	_connect_signals()
	
	
func on_exit(_next_state: StringName) -> void:
	pass


func _connect_signals() -> void:
	practice_ui.easy_button.pressed.connect(
		self.transition.emit.bind(PracticeDeckStates.transition_card)
	)
