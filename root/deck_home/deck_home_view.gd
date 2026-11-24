@tool
class_name DeckHomeView extends SubcontentView

const DECK_HOME_SCENE = preload("uid://c82giurngorkg")

@export var model: DeckHomeModel

@export_group("Internal Nodes")
@export var controller: DeckHomeController

@export var top_section: Control
@export var deck_label: Label
@export var centered_grid: CenteredGridContainer
@export var card_popup: CardPopup

@export var start_practice_btn: PaddedButton
@export var add_card_btn: PaddedButton
@export var back_deck_btn: PaddedButton


static func create(deck: Deck) -> DeckHomeView:
	var instance: DeckHomeView = DECK_HOME_SCENE.instantiate()
	instance.model.setup(instance, deck)
	instance.controller.setup(instance.model)
	instance.setup(deck, instance.model)
	
	ObjectUtils.check_signals(instance.model)
	ObjectUtils.check_signals(instance.controller)
	ObjectUtils.check_signals(instance)
	
	return instance


func bind_signals_to_root(root_view: RootView) -> void:
	back_deck_btn.pressed.connect(
		_transition_to_deck_select.bind(root_view)
	)
	start_practice_btn.pressed.connect(
		_transition_to_practice_deck.bind(root_view)
	)


## Populates [DeckHomeView] object with data from [Deck].
## Also connects view to mutation signals from [DeckHomeModel]
func setup(deck: Deck, p_model: DeckHomeModel) -> void:
	deck_label.text = deck.name
	
	p_model.open_add_card_popup.connect(_on_open_add_card_popup)
	p_model.new_card_added.connect(_add_card_view)
	p_model.open_edit_card_popup.connect(_on_open_edit_card_popup)
	p_model.close_popup.connect(_on_close_popup)
	
	for card: Card in deck.cards:
		_add_card_view(card)


func _on_open_add_card_popup() -> void:
	_toggle_nonpopup_buttons(false)
	card_popup.setup_add_card_popup()
	card_popup.visible = true


func _on_open_edit_card_popup(card_view: CardView) -> void:
	_toggle_nonpopup_buttons(false)
	card_popup.setup_edit_card_popup(card_view)
	card_popup.visible = true


func _on_close_popup() -> void:
	_toggle_nonpopup_buttons(true)
	card_popup.visible = false


func _add_card_view(card: Card) -> void:
	var card_view := CardView.create(card)
	card_view.edit_card_pressed.connect(
		controller.on_edit_card_pressed
	)
	card_view.delete_card_pressed.connect(
		print.bind("Not implemeneted delete card view yet!")
	)
	centered_grid.add_node(card_view)


func _toggle_nonpopup_buttons(is_on: bool) -> void:
	ControlUtils.set_button_disabled(start_practice_btn, not is_on)
	ControlUtils.set_button_disabled(add_card_btn, not is_on)
	ControlUtils.set_button_disabled(back_deck_btn, not is_on)


func _transition_to_deck_select(root_view: RootView) -> void:
	var deck_select_view: DeckSelectView = DeckSelectView.create()
	root_view.set_subview(deck_select_view)


func _transition_to_practice_deck(root_view: RootView) -> void:
	var deck_practice_view: DeckPractiveView = DeckPractiveView.create(model.deck)
	root_view.set_subview(deck_practice_view)
