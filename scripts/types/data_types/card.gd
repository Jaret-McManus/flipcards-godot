class_name Card extends Resource


@export var side_a: String
@export var side_b: String


static func create(p_side_a: String = "ERROR", p_side_b: String = "ERROR") -> Card:
	var new_card: Card = Card.new()
	new_card.side_a = p_side_a
	new_card.side_b = p_side_b
	
	return new_card
	
