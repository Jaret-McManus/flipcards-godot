extends UIState


@export var edit_card_ui: PackedScene

const POPUP_TITLE: String = "Edit Card"
var ui_instance: NewCardUI


func on_enter(_prev_state: StringName) -> void:
	ui_instance = edit_card_ui.instantiate()
	# Hijack NewCardUI to be an EditCardUI
	_edit_card_init()
	content_container.add_child(ui_instance)


func on_exit(_next_state: StringName) -> void:
	content_container.remove_child(ui_instance)
	

func _edit_card_init() -> void:
	ui_instance.popup_title = POPUP_TITLE
	ui_instance.side_a_text = Decks.current_card.side_a
	ui_instance.side_b_text = Decks.current_card.side_b
	
	_connect_signals()
	

func _connect_signals() -> void:
	ui_instance.exit_btn.pressed.connect(
		self.transition.emit.bind(UIStates.edit_deck)
	)
	ui_instance.submit_btn.pressed.connect(_on_submit)
	
	
func _on_submit() -> void:
	var failure: bool = false
	if Utils.input_is_empty(ui_instance.side_a_input):
		failure = true
		ui_instance.side_a_error_text = "Side A cannot be empty!"
	if Utils.input_is_empty(ui_instance.side_b_input):
		failure = true
		ui_instance.side_a_error_text = "Side B cannot be empty!"
		
	if failure: return
	_edit_card()
	self.transition.emit(UIStates.edit_deck)
	

func _edit_card() -> void:
	var file_path: String = _get_file_path(Decks.current_deck.dir_path, Decks.current_card.side_a)
	var new_file_path: String = _get_file_path(Decks.current_deck.dir_path, ui_instance.side_a_text)
	DirAccess.remove_absolute(
		ProjectSettings.globalize_path(file_path)
	)
	
	var new_card: Card = Card.create(ui_instance.side_a_text, ui_instance.side_b_text)
	ResourceSaver.save(new_card, new_file_path)
	
	
func _get_file_path(dir_name: String, file_name: String, file_extension: String = "res") -> String:
	return"%s/%s.%s" % [dir_name, file_name, file_extension]
