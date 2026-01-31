class_name Deck extends RefCounted


var name: String
var cards: Array[Card] = []
var num_cards: int
var dir_path: String


func _init(p_name: String, p_num_cards: int = 0) -> void:
	self.name = p_name
	self.dir_path = "%s/%s" % [Decks.DATA_FOLDER_PATH, p_name]
	self.num_cards = p_num_cards


func load_get_cards() -> Array[Card]:
	cards.clear()
	
	var card_filenames: Array[String] = _get_sorted_card_filenames()
	for card_filename: String in card_filenames:
		var card: Card = load(card_filename)
		cards.append(card)
	
	return cards


func add_card(side_a: String, side_b: String) -> void:
	var new_card: Card = Card.create(side_a, side_b)
	var filename: String = "%s.res" % [_get_file_path(side_a)]
	ResourceSaver.save(new_card, filename)


func _get_file_path(file_name: String) -> String:
	return "%s/%s" % [dir_path, file_name]


func _get_sorted_card_filenames() -> Array[String]:
	var card_filenames: Array[String] = Array(Array(DirAccess.get_files_at(dir_path)), TYPE_STRING, "", null)
	card_filenames = Array(card_filenames.map(_get_file_path), TYPE_STRING, "", null)
	card_filenames.sort_custom(
		func (filename_1: String, filename_2: String): 
			var modify_time_1 = FileAccess.get_modified_time(filename_1)
			var modify_time_2 = FileAccess.get_modified_time(filename_2)
			return modify_time_1 < modify_time_2
	)
	
	return card_filenames
