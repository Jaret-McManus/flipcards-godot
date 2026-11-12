class_name DeckSelectController extends Node

var model: DeckSelectModel


func build(p_model: DeckSelectModel) -> void:
	model = p_model


func on_add_deck() -> void:
	var deck := Deck.new("test")
	model.add_deck(deck)
