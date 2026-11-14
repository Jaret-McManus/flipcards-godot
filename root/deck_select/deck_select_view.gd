@tool
class_name DeckSelectView extends View

@export var model: DeckSelectModel

@export_group("Internal Nodes")
@export var top_bar_margin: MarginContainer
@export var title_label: RichTextLabel
@export var grid: CenteredGridContainer
@export var controller: DeckSelectController
@export var add_deck_popup: AddDeckPopup
@export var add_deck_button: PaddedButton


func _ready() -> void:
	_setup_model()
	_setup_controller(model)
	_setup_view(model)


func add_deck(deck: Deck) -> void:
	grid.add_node(DeckView.create(deck.name, deck.cards.size()))


func _on_top_bar_margin_changed(margin: Margin) -> void:
	top_bar_margin["theme_override_constants/margin_top"] = margin.top
	top_bar_margin["theme_override_constants/margin_right"] = margin.right
	top_bar_margin["theme_override_constants/margin_bottom"] = margin.bottom
	top_bar_margin["theme_override_constants/margin_left"] = margin.left


func _on_title_font_size_changed(p_size: int) -> void:
	title_label["theme_override_font_sizes/normal_font_size"] = p_size


func _popup_toggle_buttons(p_is_visible: bool) -> void:
	ControlUtils.set_button_disabled(add_deck_button, p_is_visible)


func _set_add_deck_visibility(p_is_visible: bool) -> void:
	add_deck_popup.visible = p_is_visible
	_popup_toggle_buttons(p_is_visible)
	if p_is_visible: add_deck_popup.setup_open()


func _setup_model() -> void:
	var decks: Array[Deck] = DeckSaveLoad.load_all_decks()
	model.build(self, decks)
	model.top_bar_margin_changed.connect(_on_top_bar_margin_changed)
	model.title_font_size_changed.connect(_on_title_font_size_changed)
	model.popup_visibility_changed.connect(_set_add_deck_visibility)


func _setup_controller(p_model: DeckSelectModel) -> void:
	controller.build(p_model)


func _setup_view(p_model: DeckSelectModel) -> void:
	add_deck_popup.build(p_model)
