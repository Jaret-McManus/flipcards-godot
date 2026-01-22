class_name SelectDeckState extends UIState


var select_deck_scene: PackedScene = preload("uid://ccbalvbiqkqch")
var select_deck_ui: SelectDeckUI = null


func on_enter(prev_state: StringName) -> void:
	# populate UI
	if prev_state != UIStates.new_deck:
		select_deck_ui = select_deck_scene.instantiate()
		content_container.add_child(select_deck_ui)
		
		select_deck_ui.new_deck_btn.pressed.connect(
			self.transition.emit.bind(UIStates.new_deck)
		)
	
	# populate decks
	select_deck_ui.clear_grid()
	for deck: Deck in Decks.get_decks():
		var on_click: Callable = _make_button_callback(deck)
		var deck_preview: DeckPreview = DeckPreview.create(deck, on_click)
		select_deck_ui.add_to_grid(deck_preview)
	
	if prev_state == UIStates.new_deck:
		select_deck_ui.toggle_button_interactions()
	
	
func on_exit(next_state: StringName) -> void:
	# depopulate UI
	if next_state == UIStates.new_deck: 
		select_deck_ui.toggle_button_interactions()
		return
		
	select_deck_ui = null
	Utils.remove_children_free(content_container)
	
	
func _make_button_callback(deck: Deck) -> Callable:
	return func ():
		Decks.current_deck = deck
		self.transition.emit(UIStates.edit_deck)
