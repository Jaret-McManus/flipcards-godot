class_name PresentCardState extends PracticeState


var _signals_connected: bool = false


func on_enter(_prev_state: StringName) -> void:
	if not _signals_connected: _connect_signals()
	
	
func on_exit(_next_state: StringName) -> void:
	_signals_connected = false


func _connect_signals() -> void:
	_connect_status_button(
		practice_ui.dont_know_button, PracticeDeckStates.CardStatus.DONT_KNOW
	)
	_connect_status_button(
		practice_ui.hard_button, PracticeDeckStates.CardStatus.HARD
	)
	_connect_status_button(
		practice_ui.moderate_button, PracticeDeckStates.CardStatus.MODERATE
	)
	_connect_status_button(
		practice_ui.easy_button, PracticeDeckStates.CardStatus.EASY
	)
	_signals_connected = true


func _connect_status_button(button: RichButton, state: PracticeDeckStates.CardStatus) -> void:
	button.pressed.connect(
		self.transition.emit.bind(
			PracticeDeckStates.transition_card, 
			state
		)
	)
