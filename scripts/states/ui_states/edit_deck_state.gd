extends UIState


var edit_deck_scene: PackedScene = preload("uid://wcttx08l2xic")
var edit_deck_ui: EditDeckUI = null


func on_enter(prev_state: StringName) -> void:
	# full initialization of ui
	if prev_state != UIStates.new_card:
		edit_deck_ui = edit_deck_scene.instantiate()
		content_container.add_child(edit_deck_ui)
		_connect_signals()
	else: # prev state was new card
		edit_deck_ui.toggle_button_interactions()
	
	# init ui
	edit_deck_ui.populate(_transition_to_card_edit)
	
	
func on_exit(next_state: StringName) -> void:
	#depopulate ui
	if next_state in [UIStates.new_card, UIStates.edit_card]:
		edit_deck_ui.toggle_button_interactions()
		return
	
	if edit_deck_ui: edit_deck_ui = null
	Decks.current_deck = null
	Utils.remove_children_free(content_container)
	

func _connect_signals() -> void:
	edit_deck_ui.new_card_btn.pressed.connect(
		self.transition.emit.bind(UIStates.new_card)
	)
	edit_deck_ui.back_btn.pressed.connect(
		self.transition.emit.bind(UIStates.select_deck)
	)
	
func _transition_to_card_edit() -> void:
	self.transition.emit(UIStates.edit_card)
