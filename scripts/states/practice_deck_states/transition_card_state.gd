class_name TransitionCardState extends PracticeState


var card_status: PracticeDeckStates.CardStatus


func on_enter(_prev_state: StringName) -> void:
	self.transition.emit(PracticeDeckStates.present_card)
	
	
func on_exit(_next_state: StringName) -> void:
	pass	
