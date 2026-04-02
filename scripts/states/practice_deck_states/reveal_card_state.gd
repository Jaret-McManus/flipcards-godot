extends PracticeState

var signals_connected: bool = false	
	
	
func on_enter(_prev_state: StringName) -> void:
	if not signals_connected: _connect_signals()
	
	practice_ui.practice_button_mode = false
	practice_ui.continue_button_mode = true
	
	
func _connect_signals() -> void:
	practice_ui.continue_button.pressed.connect(
		self.transition.emit.bind(PracticeDeckStates.transition_card)
	)
	signals_connected = true
