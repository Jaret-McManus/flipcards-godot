@tool
class_name DeckHomeView extends SubcontentView

const DECK_HOME_SCENE = preload("uid://c82giurngorkg")

@export var model: DeckHomeModel

@export_group("Internal Nodes")
@export var controller: DeckHomeController

@export var top_section: Control
@export var deck_label: Label
@export var centered_grid: CenteredGridContainer
@export var add_card_popup: AddCardPopup

@export var start_practice_btn: PaddedButton
@export var add_card_btn: PaddedButton
@export var back_deck_btn: PaddedButton


static func create(deck: Deck) -> DeckHomeView:
	var instance: DeckHomeView = DECK_HOME_SCENE.instantiate()
	instance._setup_model(deck)
	instance._setup_controller()
	instance._setup_view(deck)
	return instance


func bind_signals(root_view: RootView) -> void:
	back_deck_btn.pressed.connect(
		func()->void:
			var deck_select_view: DeckSelectView = DeckSelectView.create()
			root_view.set_subview(deck_select_view)
	)


func set_add_card_visibility(p_is_visible: bool) -> void:
	add_card_popup.visible = p_is_visible
	_popup_toggle_buttons(p_is_visible)
	if p_is_visible: add_card_popup.setup_open()


func add_card_view(card: Card) -> void:
	var card_view := CardView.create(card)
	centered_grid.add_node(card_view)


func _popup_toggle_buttons(p_is_visible: bool) -> void:
	ControlUtils.set_button_disabled(start_practice_btn, p_is_visible)
	ControlUtils.set_button_disabled(add_card_btn, p_is_visible)
	ControlUtils.set_button_disabled(back_deck_btn, p_is_visible)


func _setup_model(deck: Deck) -> void:
	model.build(self, deck)
	model.top_screen_percentage_changed.connect(_on_top_screen_percentage_changed)


func _setup_controller() -> void:
	controller.model = model
	add_card_btn.pressed.connect(controller.on_add_card_pressed)
	add_card_popup.submitted_add_card.connect(controller.on_add_card_submit)


func _setup_view(deck: Deck) -> void:
	deck_label.text = deck.name
	for card: Card in deck.cards:
		centered_grid.add_node(CardView.create(card))


func _on_top_screen_percentage_changed(new_percentage: float) -> void:
	top_section.custom_minimum_size.y = (new_percentage / 100.0) * self.size.y
