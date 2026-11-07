@tool
class_name DeckHomeView extends View

@export var model: DeckHomeModel

@export var card_scene: PackedScene
@export_group("Internal Nodes")
@export var top_section: Control
@export var button: PaddedButton
@export var centered_grid: CenteredGridContainer
@export var add_card: PaddedButton


static func create() -> DeckHomeView:
	var deck_home_view := DeckHomeView.new()
	return deck_home_view


func _ready() -> void:
	_connect_model_signals()
	add_card.pressed.connect(
		func()->void:
			print("pressed add card!")
			centered_grid.add_node(card_scene.instantiate())
	)


func _connect_model_signals() -> void:
	model.top_screen_percentage_changed.connect(_on_top_screen_percentage_changed)


func _on_top_screen_percentage_changed(new_percentage: float) -> void:
	top_section.custom_minimum_size.y = (new_percentage / 100.0) * self.size.y
