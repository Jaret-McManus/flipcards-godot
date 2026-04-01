class_name PresentCardState extends PracticeState


var _signals_connected: bool = false


func on_enter(_prev_state: StringName, _data: Variant = null) -> void:
	if not _signals_connected: _connect_signals()
	
	# show practice buttons, hide continue button
	practice_ui.practice_button_mode = true
	practice_ui.continue_button_mode = false
	
	
func on_exit(_next_state: StringName) -> void:
	#_signals_connected = false
	pass


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
			PracticeDeckStates.reveal_card, 
			state
		)
	)
