class_name DeckSelectModel extends Node

signal decks_populated(decks: Dictionary[StringName, Deck])
signal add_deck_error_updated(error_message: String)
signal popup_visibility_changed(is_visible: bool)
signal deck_added(deck: Deck)

const StringOption = Option.StringOption

@export var is_popup_visible: bool:
	set(b): is_popup_visible = b; popup_visibility_changed.emit(b)

var _add_deck_error: String:
	set(s): _add_deck_error = s; add_deck_error_updated.emit(s)

var decks: Dictionary[StringName, Deck]


func _ready() -> void:
	decks = DeckSaveLoad.load_all_decks()
	decks_populated.emit(decks)


func add_deck(deck: Deck) -> void:
	decks.set(deck.name, deck)
	DeckSaveLoad.save_deck(deck)
	deck_added.emit(deck)


func is_deck_name_collision(deck_name: String) -> bool:
	return deck_name in decks


func set_add_deck_error(error_option: StringOption) -> void:
	if error_option.is_some():
		_add_deck_error = error_option.value
	else:
		_add_deck_error = ""
