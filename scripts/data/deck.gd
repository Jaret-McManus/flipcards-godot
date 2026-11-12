class_name Deck extends Resource

@export var name: String
@export var cards: Array[Card]


func _init(p_name: String) -> void:
	name = p_name
	cards = []


func _to_string() -> String:
	return "%s: %s" % [name, cards]
