class_name DeckView extends PanelContainer

const DECK_VIEW_SCENE = preload("uid://yiyx7x0jxk24")

@export var name_label: Label
@export var count_label: Label

@export_group("Internal Nodes")
@export var button: Button


static func create(p_name: String, p_card_count: int) -> DeckView:
	var instance: DeckView = DECK_VIEW_SCENE.instantiate()
	instance.name_label.text = p_name
	instance.count_label.text = "Number of Cards: %d" % p_card_count
	return instance
	
