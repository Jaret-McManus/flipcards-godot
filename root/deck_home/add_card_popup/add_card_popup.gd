class_name AddCardPopup extends PanelContainer

signal submitted_add_card(side_a: String, side_b: String)

const StringResult = Result.StringResult

@export_group("Internal Nodes")
@export var a_input: LineEdit
@export var a_error: Label
@export var b_input: LineEdit
@export var b_error: Label

var _g_any_error: bool = false


func setup_open() -> void:
	a_input.text = ""
	a_error.text = ""
	b_input.text = ""
	b_error.text = ""
	a_input.grab_focus()


func _on_submit() -> void:
	_g_any_error = false
	
	var a_text_result := _clean_and_validate_input(a_input.text, "A")
	_set_error_from_result(a_error, a_text_result)
	
	var b_text_result := _clean_and_validate_input(b_input.text, "B")
	_set_error_from_result(b_error, b_text_result)
	
	if not _g_any_error:
		submitted_add_card.emit(a_text_result.value, b_text_result.value)


func _clean_and_validate_input(string: String, side: String) -> StringResult:
	string = string.strip_edges()
	if not string: return StringResult.err("Side %s cannot be empty!" % side)
	
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
