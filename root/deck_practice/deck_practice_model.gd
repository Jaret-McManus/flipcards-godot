class_name DeckPracticeModel

var cards: Array[Card]


static func new_model(p_cards: Array[Card]) -> DeckPracticeModel:
	var model := DeckPracticeModel.new()
	model.cards = p_cards
	return model
