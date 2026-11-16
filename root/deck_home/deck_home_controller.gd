@tool
class_name DeckHomeController extends Node

const PopupMode = DeckHomeModel.PopupMode
const ObjectOption = Option.ObjectOption

var model: DeckHomeModel


func _input(event: InputEvent) -> void:
	if event.is_action(&"ui_cancel") and model.is_popup_open():
		model.set_popup_mode(PopupMode.CLOSED)


func on_add_card_pressed() -> void:
	model.set_popup_mode(PopupMode.ADD_CARD)

## intended to be injected into each card view
func on_edit_card_pressed(card_view: CardView) -> void:
	model.set_popup_mode(PopupMode.EDIT_CARD, ObjectOption.some(card_view))


func on_add_card_submit(a_text: String, b_text: String) -> void:
	model.set_popup_mode(PopupMode.CLOSED)
	
	var new_card: Card = Card.new_card(a_text, b_text)
	model.add_card(new_card)


func on_edit_card_submit(card_view: CardView, side_a: String, side_b: String) -> void:
	model.set_popup_mode(PopupMode.CLOSED)
	model.update_card(card_view.card, side_a, side_b)
	card_view.update_from_card()
