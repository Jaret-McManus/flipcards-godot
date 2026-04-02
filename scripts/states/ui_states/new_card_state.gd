extends UIState


var new_card_scene: PackedScene = preload("uid://ios7ddtnwga5")
var new_card_ui: NewCardUI


func on_enter(_prev_state: StringName) -> void:
	# populate ui
	new_card_ui = new_card_scene.instantiate()
	content_container.add_child(new_card_ui)
	
	new_card_ui.side_a_input.grab_focus()
	_connect_signals()


func on_exit(_next_state: StringName) -> void:
	new_card_ui.queue_free()
	new_card_ui = null
	

func _on_submit() -> void:
	var failure: bool = false
	
	var side_a_stripped: String = new_card_ui.side_a_text.strip_edges()
	var side_b_stripped: String = new_card_ui.side_b_text.strip_edges()
	if side_a_stripped == "":	
		failure = true;
		new_card_ui.side_a_error_text = "[color=red]Side A cannot be empty![/color]"
	elif _does_card_exist(side_a_stripped):
		failure = true
		new_card_ui.side_a_error_text = \
			"[color=red]Card with a Side A of \"%s\" already exists!" % [side_a_stripped]
	
	if side_b_stripped == "":
		failure = true
		new_card_ui.side_b_error_text = "[color=red]Side B cannot be empty![/color]"
		
	if failure: 
		return
		
	_add_new_card()
	

func _add_new_card() -> void:
	Decks.current_deck.add_card(
		new_card_ui.side_a_text,
		new_card_ui.side_b_text,
		
	)
	self.transition.emit(UIStates.edit_deck)
	


func _connect_signals() -> void:
	new_card_ui.exit_btn.pressed.connect(
		self.transition.emit.bind(UIStates.edit_deck)
	)
	new_card_ui.submit_btn.pressed.connect(_on_submit)


func _does_card_exist(card_name: String) -> bool:
	return FileAccess.file_exists(
		"%s/%s.res" % [Decks.current_deck.dir_path, card_name]
	)
