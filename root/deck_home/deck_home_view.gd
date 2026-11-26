class_name DeckHomeView extends SubcontentView

const DECK_HOME_SCENE = preload("uid://c82giurngorkg")

var _empty_section: EmptySection

@export_group("Internal Nodes")
@export_subgroup("MVC")
@export var _controller: DeckHomeController
@export var _model: DeckHomeModel

@export_subgroup("Header")
@export var _deck_label: Label
@export var _start_practice_btn: PaddedButton

@export_subgroup("Middle Section")
@export var _main_section: ScrollContainer
@export var _centered_grid: CenteredGridContainer

@export_subgroup("Popup")
@export var _card_popup: CardPopup

@export_subgroup("Footer")
@export var _add_card_btn: PaddedButton
@export var _back_deck_btn: PaddedButton


static func create(deck: Deck) -> DeckHomeView:
	var instance: DeckHomeView = DECK_HOME_SCENE.instantiate()
	Assert.exports_nonnull(instance)
	
	instance._model.setup(deck)
	instance._controller.setup(instance._model)
	instance.setup(deck, instance._model)
	
	ObjectUtils.check_signals(instance._model)
	ObjectUtils.check_signals(instance._controller)
	ObjectUtils.check_signals(instance)
	
	return instance


func bind_signals_to_root(root_model: RootModel) -> void:
	_back_deck_btn.pressed.connect(
		_transition_to_deck_select.bind(root_model)
	)
	_start_practice_btn.pressed.connect(
		_transition_to_practice_deck.bind(root_model)
	)


func setup(deck: Deck, model: DeckHomeModel) -> void:
	_deck_label.text = deck.name
	_fetch_cards(model, _centered_grid)


#region model connections
func on_open_add_card_popup() -> void:
	_card_popup.setup_add_card_popup()
	_open_popup()


func on_card_added(card: Card) -> void: _add_card_view(card)


func on_open_edit_card_popup(card_view: CardView) -> void:
	_card_popup.setup_edit_card_popup(card_view)
	_open_popup()


func on_open_delete_card_popup(card_view: CardView) -> void:
	_card_popup.setup_delete_card_popup(card_view)
	_open_popup()


func on_close_popup() -> void:
	_toggle_nonpopup_buttons(true)
	_card_popup.visible = false


func on_card_deleted() -> void:
	_fetch_cards(_model, _centered_grid)
#endregion


func _open_popup() -> void:
	_toggle_nonpopup_buttons(false)
	_card_popup.visible = true


func _add_card_view(card: Card) -> void:
	if _empty_section: _main_section.remove_child(_empty_section)
	
	var card_view := CardView.create(card, _controller)
	_centered_grid.add_node(card_view)


func _fetch_cards(model: DeckHomeModel, grid: CenteredGridContainer) -> void:
	grid.clear()
	
	if model.deck.cards.size() == 0:
		_empty_section = EmptySection.create_populate(_main_section, "cards")
	
	for card: Card in model.deck.cards:
		_add_card_view(card)


func _toggle_nonpopup_buttons(is_on: bool) -> void:
	ControlUtils.set_button_disabled(_start_practice_btn, not is_on)
	ControlUtils.set_button_disabled(_add_card_btn, not is_on)
	ControlUtils.set_button_disabled(_back_deck_btn, not is_on)


func _transition_to_deck_select(root_model: RootModel) -> void:
	var deck_select_view: DeckSelectView = DeckSelectView.create()
	root_model.set_subview(deck_select_view)


func _transition_to_practice_deck(root_model: RootModel) -> void:
	var deck_practice_view: DeckPractiveView = DeckPractiveView.create(_model.deck)
	root_model.set_subview(deck_practice_view)
