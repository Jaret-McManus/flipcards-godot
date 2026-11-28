class_name DeckSaveLoad

const _save_path: String = "user://decks/"
const _file_type: String = "tres"
static var _save_file_path_template: String = \
	_save_path + "%s.{file_type}".format({"file_type": _file_type})


static func save_deck(deck: Deck) -> void:
	_ensure_deck_dir_exists(_save_path)
	
	var error := ResourceSaver.save(
		deck, _save_file_path_template % deck.name
	)
	
	if error > 0: printerr("Error saving deck: %s" % error_string(error))


static func load_deck(_name: String) -> void:
	pass


static func load_all_decks() -> Dictionary[StringName, Deck]:
	var files: PackedStringArray = ResourceLoader.list_directory(_save_path)
	
	var decks: Dictionary[StringName, Deck] = {}
	for file: String in files:
		var path: String = _save_path + file
		var deck: Deck = ResourceLoader.load(path) as Deck
		var deck_name: StringName = file.trim_suffix(".%s" % _file_type)
		decks.set(deck_name, deck)
	
	return decks


static func delete_deck(deck: Deck) -> void:
	var filename: String = _get_filename(deck)
	var global_path: String = ProjectSettings.globalize_path(filename)
	var error: Error = DirAccess.remove_absolute(global_path)
	
	if error != OK:
		push_error("Error deleting file: %s" % error_string(error))


static func _get_filename(deck: Deck) -> String:
	return _save_file_path_template % deck.name


static func _ensure_deck_dir_exists(save_path: String) -> void:
	var global_path: String = ProjectSettings.globalize_path(save_path)
	if not DirAccess.dir_exists_absolute(global_path):
		DirAccess.make_dir_recursive_absolute(global_path)
