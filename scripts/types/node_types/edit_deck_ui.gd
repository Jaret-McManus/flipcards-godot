class_name EditDeckUI extends Control


@export_group("Nodes")
@export var deck_title_lbl: Label
@export var deck_card_count_lbl: Label
@export var back_btn: Button
@export var new_card_btn: Button
@export var grid: CenteredGridContainer

var deck_title: String: 
	set(s): deck_title_lbl.text = s
var deck_card_count: String: 
	set(s): deck_card_count_lbl.text = s
	
	
func populate() -> void:
	deck_title = Decks.current_deck.name
	
	var cards: Array[Card] = Decks.current_deck.load_get_cards()
	
	deck_card_count = Utils.conditional_plural(cards.size(), "card")
	grid.clear()
	for card: Card in cards:
		var preview: CardPreview = CardPreview.create(card)
		grid.add_node(preview)
		

func toggle_button_interactions() -> void:
	back_btn.disabled = not back_btn.disabled
	new_card_btn.disabled = not new_card_btn.disabled
