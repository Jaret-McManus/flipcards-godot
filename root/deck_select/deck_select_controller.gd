@tool
class_name DeckSelectController extends Node

var model: DeckSelectModel


func build(p_model: DeckSelectModel) -> void:
	model = p_model


func _input(event: InputEvent) -> void:
	if event.is_action(&"ui_cancel") and model.is_popup_visible:
		model.is_popup_visible = false


func on_add_deck() -> void:
	model.is_popup_visible = true


func _on_add_deck_submitted(deck_name: String) -> void:
	var deck: Deck = Deck.new_deck(deck_name)
	model.add_deck(deck)
	model.is_popup_visible = false
