@tool
class_name DeckHomeController extends Node

var model: DeckHomeModel


func _input(event: InputEvent) -> void:
	if event.is_action(&"ui_cancel") and model.add_card_popup_open:
		model.add_card_popup_open = false


func on_add_card_pressed() -> void:
	model.add_card_popup_open = true


func on_add_card_submit(a_text: String, b_text: String) -> void:
	model.add_card_popup_open = false
	
	var new_card: Card = Card.new_card(a_text, b_text)
	model.add_card(new_card)
