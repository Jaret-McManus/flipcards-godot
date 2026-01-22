class_name DeckPreview extends MarginContainer


static var deck_preview_scene: PackedScene = preload("uid://dovuxy8ecetx8")
var deck_info: Deck

@export var name_label: Label
@export var num_cards_label: Label
@export var button: Button

static func create(p_deck_info: Deck, on_click: Callable) -> DeckPreview:
	var instance: DeckPreview = deck_preview_scene.instantiate()
	instance.deck_info = p_deck_info
	
	instance.name_label.text = p_deck_info.name
	
	var num_cards: int = p_deck_info.num_cards
	instance.num_cards_label.text = Utils.conditional_plural(num_cards, "card")
	
	instance.button.pressed.connect(on_click)
	
	return instance
	
