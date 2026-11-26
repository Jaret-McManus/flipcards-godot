class_name DeckSelectView extends SubcontentView

const DECK_SELECT_SCENE = preload("uid://cor2feloiy1ih")

signal open_deck(deck: Deck)

var _empty_section: EmptySection


@export_group("Internal Nodes")
@export_subgroup("MVC")
@export var controller: DeckSelectController
@export var model: DeckSelectModel

@export_subgroup("Middle Content")
@export var main_section: ScrollContainer
@export var grid: CenteredGridContainer

@export_subgroup("Popup")
@export var add_deck_popup: AddDeckPopup

@export_subgroup("Footer")
@export var add_deck_button: PaddedButton


func _ready() -> void:
	controller.setup(model)
	Assert.exports_nonnull(self)


static func create() -> DeckSelectView:
	var instance: DeckSelectView = DECK_SELECT_SCENE.instantiate()
	return instance


func bind_signals_to_root(root_model: RootModel) -> void:
	open_deck.connect(_transition_to_deck_home.bind(root_model))


func _add_deck(deck: Deck) -> void:
	# remove no decks section
	if _empty_section: main_section.remove_child(_empty_section)
		
	var deck_view: DeckView = DeckView.create(deck.name, deck.cards.size())
	grid.add_node(deck_view)
	
	deck_view.button.pressed.connect(
		open_deck.emit.bind(deck)
	)

func _popup_toggle_buttons(p_is_visible: bool) -> void:
	ControlUtils.set_button_disabled(add_deck_button, p_is_visible)


#region signals from DeckSelectModel
func _on_decks_populated(decks: Dictionary[StringName, Deck]) -> void:
	if decks.size() == 0:
		_empty_section = EmptySection.create_populate(main_section, "decks")
	else:
		for deck: Deck in decks.values():
			_add_deck(deck)


func _on_popup_visibility_changed(p_is_visible: bool) -> void:
	add_deck_popup.visible = p_is_visible
	_popup_toggle_buttons(p_is_visible)
	if p_is_visible: add_deck_popup.setup_open()


func _on_add_deck_error_message_updated(error_message: String) -> void:
	add_deck_popup.name_error.text = error_message


func _on_deck_added(deck: Deck) -> void:
	_add_deck(deck)
#endregion


func _transition_to_deck_home(deck: Deck, root_model: RootModel) -> void:
	var deck_home_view: DeckHomeView = DeckHomeView.create(deck)
	root_model.set_subview(deck_home_view)
