class_name CardPopup extends PanelContainer

signal submitted_add_card(side_a: String, side_b: String)
signal submitted_edit_card(card_view: CardView, side_a: String, side_b: String)

const StringResult = Result.StringResult
const ObjectOption = Option.ObjectOption
const PopupMode = DeckHomeModel.PopupMode

@export_group("Internal Nodes")
@export var popup_title: Label

@export var a_input: LineEdit
@export var a_error: Label

@export var b_input: LineEdit
@export var b_error: Label

@export var submit_button: PaddedButton

var _g_any_error: bool = false
var _popup_mode: PopupMode
var _current_editing_card_view: Option.ObjectOption


func setup_edit_card_popup(card_view: CardView) -> void:
	_popup_mode = PopupMode.EDIT_CARD
	_current_editing_card_view = ObjectOption.some(card_view)
	
	popup_title.text = "Edit Card"
	a_input.text = card_view.card.side_a_text
	a_error.text = ""
	b_input.text = card_view.card.side_b_text
	b_error.text = ""
	
	submit_button.text = "Edit Card"
	
	a_input.grab_focus()


func setup_add_card_popup() -> void:
	_popup_mode = PopupMode.ADD_CARD
	popup_title.text = "Add New Card"
	
	a_input.text = ""
	a_error.text = ""
	b_input.text = ""
	b_error.text = ""
	
	submit_button.text = "Add Card"
	
	a_input.grab_focus()


func _on_submit() -> void:
	_g_any_error = false
	
	var a_text_result := _clean_and_validate_input(a_input.text, "A")
	_set_error_from_result(a_error, a_text_result)
	
	var b_text_result := _clean_and_validate_input(b_input.text, "B")
	_set_error_from_result(b_error, b_text_result)
	
	if not _g_any_error and _popup_mode == PopupMode.ADD_CARD:
		submitted_add_card.emit(a_text_result.value, b_text_result.value)
	elif not _g_any_error and _popup_mode == PopupMode.EDIT_CARD:
		var card_view_to_edit: CardView = _current_editing_card_view.value as CardView
		submitted_edit_card.emit(
			card_view_to_edit,
			a_text_result.value,
			b_text_result.value
		)
		_current_editing_card_view = ObjectOption.none()


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
