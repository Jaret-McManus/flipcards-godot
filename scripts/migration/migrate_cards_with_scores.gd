@tool
extends EditorScript


func _run() -> void:
	var decks := DeckSaveLoad.load_all_decks()
	for deck: Deck in decks.values():
		_update_cards(deck.cards)
		print("updated all cards in Deck: %s" % deck)
		print("saving...")
		DeckSaveLoad.save_deck(deck)
		print()


func _update_cards(cards: Array[Card]) -> void:
	for card: Card in cards:
		card.score = Score.new_score()
		print("Added score rsrc to %s" % card)
