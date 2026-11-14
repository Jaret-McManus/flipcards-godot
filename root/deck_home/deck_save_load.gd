class_name DeckSaveLoad

const save_path: String = "user://decks/"
const save_file_path_template: String = save_path + "%s.tres"

static func save_deck(deck: Deck) -> void:
	var global_path: String = ProjectSettings.globalize_path(save_path)
	if not DirAccess.dir_exists_absolute(global_path):
		DirAccess.make_dir_recursive_absolute(global_path)
	
	var error := ResourceSaver.save(
		deck, save_file_path_template % deck.name
	)
	
	if error > 0: printerr("Error saving deck: %s" % error_string(error))


static func load_deck(_name: String) -> void:
	pass


static func load_all_decks() -> Array[Deck]:
	var files: PackedStringArray = ResourceLoader.list_directory(save_path)
	
	var decks: Array[Deck] = []
	for file: String in files:
		print("file found: %s" % file)
		var path: String = save_path + file
		var deck: Deck = ResourceLoader.load(path) as Deck
		decks.append(deck)
	
	return decks
