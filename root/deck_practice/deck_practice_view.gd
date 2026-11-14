class_name DeckPractiveView extends SubcontentView

var model: DeckPracticeModel


static func create(deck: Deck) -> DeckPractiveView:
	var view := DeckPractiveView.new()
	view.model = DeckPracticeModel.new_model(deck.cards)
	return view


func bind_signals(_parent: RootView) -> void: pass
