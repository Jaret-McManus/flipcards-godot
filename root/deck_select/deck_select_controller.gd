class_name DeckSelectController extends Node

const StringResult = Result.StringResult
const StringOption = Option.StringOption

var _model: DeckSelectModel
var _any_add_deck_error: bool = false


func setup(p_model: DeckSelectModel) -> void:
	_model = p_model


#func _input(event: InputEvent) -> void:
	#if event.is_action(&"ui_cancel") and _model.is_popup_visible:
		#_model.is_popup_visible = false


func _on_add_deck_pressed() -> void:
	_model.is_popup_visible = true
	

func _on_close_popup() -> void: 
	_model.is_popup_visible = false


func _on_add_deck_submitted(deck_name: String) -> void:
	_any_add_deck_error = false
	
	var name_result := _clean_and_validate_input(deck_name)
	var error_option: StringOption = name_result \
		.then(_check_naming_collision) \
		.to_error_option()
	
	_model.set_add_deck_error(error_option)
	
	if error_option.is_none():
		var new_deck: Deck = Deck.new_deck(name_result.value)
		_model.add_deck(new_deck)
		_model.is_popup_visible = false


func _clean_and_validate_input(string: String) -> StringResult:
	string = string.strip_edges()
	if not string: return StringResult.err("Deck name cannot be empty!")
	
	var regex: RegEx = RegEx.new()
	regex.compile("\\s{1,}")
	string = regex.sub(string, " ", true)
	
	return StringResult.ok(string)


func _check_naming_collision(p_name: String) -> StringResult:
	if _model.is_deck_name_collision(p_name):
		return StringResult.err("Deck with name \"%s\" already exists!" % p_name)
	return StringResult.ok("")
