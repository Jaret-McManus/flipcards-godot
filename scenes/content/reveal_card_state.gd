extends PracticeDeckState


func _ready() -> void:
	_connect_signals()
	
	
func on_enter(_prev_state: StringName) -> void:
	ui_instance.card.answer_visible = true
	
	
func _connect_signals() -> void:
	ui_instance.continue_btn.pressed.connect(
		self.transition.emit.bind(PracticeDeckStates.transition_card)
	)
