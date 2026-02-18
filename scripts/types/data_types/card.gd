class_name Card extends Resource


@export var side_a: String
@export var side_b: String

var creation_time: float
var modified_time: float


static func create(p_side_a: String, p_side_b: String, are_modifying: bool = false) -> Card:
	var new_card: Card = Card.new()
	new_card.side_a = p_side_a
	new_card.side_b = p_side_b
	
	# timestamps
	if not are_modifying:
		new_card.creation_time = Time.get_unix_time_from_system()
		new_card.modified_time = new_card.creation_time
	else:
		new_card.modified_time = Time.get_unix_time_from_system()
	
	return new_card
	
