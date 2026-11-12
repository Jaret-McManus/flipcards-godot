class_name CardView extends PanelContainer

const CARD_VIEW_SCENE = preload("uid://dg7cio7p6lin5")

@export var side_a_label: RichTextLabel
@export var side_b_label: RichTextLabel


static func create(card: Card) -> CardView:
	var instance: CardView = CARD_VIEW_SCENE.instantiate()
	instance.side_a_label.text = card.side_a_text
	instance.side_b_label.text = card.side_b_text
	return instance
