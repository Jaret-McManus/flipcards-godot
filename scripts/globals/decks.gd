extends Node


const DATA_FOLDER_PATH: String = "user://data"
var current_deck: Deck
var current_card: Card


func add_deck(deck: Deck) -> void:
	var dir_name: String = "%s/%s" % [DATA_FOLDER_PATH, deck.name]
	DirAccess.make_dir_recursive_absolute(
		ProjectSettings.globalize_path(dir_name)
	)
	

func get_decks() -> Array[Deck]: 
	var decks: Array[Deck] = []
	for deck_dir: String in DirAccess.get_directories_at(DATA_FOLDER_PATH):
		var num_cards: int = _get_card_count(deck_dir)
		decks.append(Deck.new(deck_dir, num_cards))
		
	return decks


func _get_card_count(deck_dir_name: String) -> int:
	var deck_path: String = "%s/%s" % [DATA_FOLDER_PATH, deck_dir_name]
	return DirAccess.get_files_at(deck_path).size()
