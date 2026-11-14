class_name Deck extends Resource

@export var name: String
@export var cards: Array[Card]


static func new_deck(p_name: String)-> Deck:
	var deck := Deck.new()
	deck.name = p_name
	deck.cards = []
	return deck


func _to_string() -> String:
	return "Deck<name: %s, cards: %s>" % [name, cards]
