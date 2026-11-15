@tool
class_name DeckHomeController extends Node

var model: DeckHomeModel


func _input(event: InputEvent) -> void:
	if event.is_action(&"ui_cancel") and model.is_popup_open:
		model.close_popup.emit()


func on_add_card_pressed() -> void:
	model.set_popup_open(DeckHomeModel.PopupMode.ADD_CARD)


func on_add_card_submit(a_text: String, b_text: String) -> void:
	model.close_popup.emit()
	
	var new_card: Card = Card.new_card(a_text, b_text)
	model.add_card(new_card)
