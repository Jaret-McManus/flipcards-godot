class_name AddDeckPopup extends PanelContainer

signal submitted_add_deck(deck_name: String)

const StringResult = Result.StringResult
const StringOption = Option.StringOption

@export_group("Internal Nodes")
@export var name_input: LineEdit
@export var name_error: Label

var _g_any_error: bool = false
var _model: DeckSelectModel


func build(p_model: DeckSelectModel) -> void:
	_model = p_model


func setup_open() -> void:
	name_input.text = ""
	name_error.text = ""
	name_input.grab_focus()


func _on_submit() -> void:
	_g_any_error = false
	
	var name_result := _clean_and_validate_input(name_input.text)
	var error_option: StringOption = name_result \
		.then(_check_naming_collision) \
		.to_error_option()

	_set_error_from_option(name_error, error_option)
	
	if not _g_any_error:
		submitted_add_deck.emit(name_result.value)


func _clean_and_validate_input(string: String) -> StringResult:
	string = string.strip_edges()
	if not string: return StringResult.err("Deck name cannot be empty!")
	
	var regex: RegEx = RegEx.new()
	regex.compile("\\s{1,}")
	regex.sub(string, " ", true)
	
	return StringResult.ok(string)


func _check_naming_collision(p_name: String) -> StringResult:
	if _model.is_deck_name_collision(p_name):
		return StringResult.err("Deck with name \"%s\" already exists!" % p_name)
	return StringResult.ok("")


func _set_error(error: Label, error_msg: String) -> void:
	error.text = error_msg
	error.visible = true


func _set_error_from_option(error: Label, error_option: StringOption) -> void:
	_set_error(error, error_option.value)
	error.visible = error_option.has_value
	_g_any_error = _g_any_error || error_option.has_value
