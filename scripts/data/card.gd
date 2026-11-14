class_name Card extends Resource

@export var side_a_text: String
@export var side_b_text: String


static func new_card(p_side_a_text: String, p_side_b_text: String) -> Card:
	var card: Card = Card.new()
	card.side_a_text = p_side_a_text
	card.side_b_text = p_side_b_text
	return card


func _to_string() -> String:
	return "Card:<%s|%s>" % [side_a_text, side_b_text]
