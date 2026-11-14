@tool
class_name DeckSelectModel extends Resource

signal popup_visibility_changed

@export_group("Model Data")
@export var is_popup_visible: bool:
	set(b): is_popup_visible = b; popup_visibility_changed.emit(b)
	
var view: DeckSelectView
var decks: Dictionary[StringName, Deck]


func build(p_view: DeckSelectView, p_decks: Dictionary[StringName, Deck]) -> void:
	view = p_view
	decks = p_decks
	for deck: Deck in decks.values():
		view.add_deck(deck)


func add_deck(deck: Deck) -> void:
	decks.set(deck.name, deck)
	DeckSaveLoad.save_deck(deck)
	view.add_deck(deck)


func is_deck_name_collision(name: String) -> bool:
	return name in decks
