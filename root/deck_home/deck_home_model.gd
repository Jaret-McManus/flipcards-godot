@tool
class_name DeckHomeModel extends Resource

const CARD_SCENE := preload("uid://dg7cio7p6lin5")

var _view: DeckHomeView
var deck: Deck = Deck.new_deck("hardcoded")

@export_group("Control Parameters")
signal top_screen_percentage_changed(new_float: float)
@export_range(0.0,100.0,1.0) var top_screen_percentage: float:
	set(f):
		top_screen_percentage = f
		top_screen_percentage_changed.emit(f)

@export_group("Data")
@export var add_card_popup_open: bool = false:
	set(b):
		add_card_popup_open = b
		_view.set_add_card_visibility(b)


func set_view(p_view: DeckHomeView) -> void:
	_view = p_view


func add_card(card: Card) -> void:
	deck.cards.append(card)
	DeckSaveLoad.save_deck(deck)
	_view.add_card_view(card)
