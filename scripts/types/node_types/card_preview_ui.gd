class_name CardPreview extends MarginContainer


@export var side_a_lbl: Label
@export var side_b_lbl: Label

static var card_preview_scene: PackedScene = preload("uid://eaqmt7iqnlnt")

	
static func create(card: Card) -> CardPreview:
	var new_preview: CardPreview = card_preview_scene.instantiate()
	new_preview.side_a_lbl.text = card.side_a
	new_preview.side_b_lbl.text = card.side_b
	
	return new_preview
