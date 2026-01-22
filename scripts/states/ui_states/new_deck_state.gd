extends UIState


var new_deck_scene: PackedScene = preload("uid://d86fwpwsq1i0")
var new_deck_ui: NewDeckUI = null


func on_enter(_prev_state: StringName) -> void:
	# populate popup
	new_deck_ui = new_deck_scene.instantiate()
	content_container.add_child(new_deck_ui)
	
	new_deck_ui.input.grab_focus()
	_connect_signals()
	
	
func on_exit(_next_state: StringName) -> void:
	# depopulate popup
	if new_deck_ui:
		content_container.remove_child.call_deferred(new_deck_ui)
		new_deck_ui.queue_free()
		new_deck_ui = null


func _background_click(event: InputEvent) -> void:
	if event is not InputEventMouseButton: return
	
	var mouse_event: InputEventMouseButton = event
	if mouse_event.is_pressed() and mouse_event.button_index == MOUSE_BUTTON_LEFT:
		self.transition.emit(UIStates.select_deck)
	

func _create_deck() -> void:
	var input: LineEdit = new_deck_ui.input
	if input.text.strip_edges() == "":
		new_deck_ui.error_text = "[color=red]Name cannot be empty![/color]"
		return
	
	Decks.add_deck(
		Deck.new(new_deck_ui.input.text)
	)
	
	self.transition.emit(UIStates.select_deck)
		
		
func _connect_signals() -> void:
	new_deck_ui.gui_input.connect(_background_click)
	new_deck_ui.exit_btn.pressed.connect(
		self.transition.emit.bind(UIStates.select_deck)
	)
	new_deck_ui.create_deck_btn.pressed.connect(
		self._create_deck
	)
	new_deck_ui.input.text_submitted.connect(
		self._create_deck.unbind(1)
	)
