class_name AddDeckPopup extends PanelContainer

signal submitted_add_deck(deck_name: String)

const StringResult = Result.StringResult

@export_group("Internal Nodes")
@export var name_input: LineEdit
@export var name_error: Label

var _g_any_error: bool = false


func setup_open() -> void:
	name_input.text = ""
	name_error.text = ""
	name_input.grab_focus()


func _on_submit() -> void:
	_g_any_error = false
	
	var name_result := _clean_and_validate_input(name_input.text)
	_set_error_from_result(name_error, name_result)
	
	#TODO: check if name is available
	
	if not _g_any_error:
		submitted_add_deck.emit(name_result.value)


func _clean_and_validate_input(string: String) -> StringResult:
	string = string.strip_edges()
	if not string: return StringResult.err("Deck name cannot be empty!")
	
	var regex: RegEx = RegEx.new()
	regex.compile("\\s{1,}")
	regex.sub(string, " ", true)
	
	return StringResult.ok(string)


func _set_error(error: Label, error_msg: String) -> void:
	error.text = error_msg
	error.visible = true


func _set_error_from_result(error: Label, result: StringResult) -> void:
	_set_error(error, result.error_msg)
	error.visible = result.has_error
	_g_any_error = _g_any_error || result.has_error
