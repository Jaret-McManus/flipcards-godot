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
	instance._setup_model(deck)
	instance._setup_controller(instance.model)
	instance._setup_view(deck, instance.model)
	ObjectUtils.check_signals(instance.model)
	return instance


func bind_signals(root_view: RootView) -> void:
	back_deck_btn.pressed.connect(
		_transition_to_deck_select.bind(root_view)
	)


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


func add_card_view(card: Card) -> void:
	var card_view := CardView.create(card)
	centered_grid.add_node(card_view)


func _toggle_nonpopup_buttons(is_on: bool) -> void:
	ControlUtils.set_button_disabled(start_practice_btn, not is_on)
	ControlUtils.set_button_disabled(add_card_btn, not is_on)
	ControlUtils.set_button_disabled(back_deck_btn, not is_on)


func _setup_model(deck: Deck) -> void:
	model.build(self, deck)


func _setup_controller(p_model: DeckHomeModel) -> void:
	controller.model = p_model


func _setup_view(deck: Deck, p_model: DeckHomeModel) -> void:
	deck_label.text = deck.name
	
	p_model.open_add_card_popup.connect(_on_open_add_card_popup)
	p_model.open_edit_card_popup.connect(_on_open_edit_card_popup)
	p_model.close_popup.connect(_on_close_popup)
	
	for card: Card in deck.cards:
		var card_view: CardView = CardView.create(card)
		card_view.edit_card_pressed.connect(_on_open_edit_card_popup)
		card_view.delete_card_pressed.connect(
			print.bind("deleting %s" % self)
		)
		centered_grid.add_node(card_view)
	
	


func _transition_to_deck_select(root_view: RootView) -> void:
	var deck_select_view: DeckSelectView = DeckSelectView.create()
	root_view.set_subview(deck_select_view)
