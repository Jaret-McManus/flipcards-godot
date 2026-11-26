@tool
class_name DeckHomeModel extends Resource

signal open_add_card_popup()
signal open_edit_card_popup(card_to_edit: Card)
signal open_delete_card_popup(card_to_edit: Card)
signal new_card_added(card: Card)
signal close_popup()

const CARD_SCENE := preload("uid://dg7cio7p6lin5")
const ObjectOption = Option.ObjectOption

enum PopupMode { CLOSED, ADD_CARD, EDIT_CARD, DELETE_CARD }

var _view: DeckHomeView
var deck: Deck
var current_card_view: CardView
var popup_mode: PopupMode


func setup(p_view: DeckHomeView, p_deck: Deck) -> void:
	_view = p_view
	deck = p_deck


func is_popup_open() -> bool: return popup_mode != PopupMode.CLOSED


func set_popup_mode(
	p_popup_mode: PopupMode, card_view_option: ObjectOption = ObjectOption.none()
) -> void:
	popup_mode = p_popup_mode
	
	if popup_mode == PopupMode.CLOSED:
		close_popup.emit()
	elif popup_mode == PopupMode.ADD_CARD:
		open_add_card_popup.emit()
	elif popup_mode == PopupMode.EDIT_CARD:
		assert(card_view_option.is_some())
		var card_view: CardView = card_view_option.value as CardView
		current_card_view = card_view
		open_edit_card_popup.emit(card_view)
	elif popup_mode == PopupMode.DELETE_CARD:
		assert(card_view_option.is_some())
		var card_view: CardView = card_view_option.value as CardView
		current_card_view = card_view
		open_delete_card_popup.emit(card_view)
	else: 
		assert(false, "Popup mode (%s) not supported" % popup_mode)


func add_card(card: Card) -> void:
	deck.cards.append(card)
	DeckSaveLoad.save_deck(deck)
	new_card_added.emit(card)


func update_card(card: Card, side_a: String, side_b: String) -> void:
	card.side_a_text = side_a
	card.side_b_text = side_b
	DeckSaveLoad.save_deck(deck)


func delete_card(card: Card) -> void:
	deck.cards.erase(card)
	DeckSaveLoad.save_deck(deck)
	_view.reinstantiate_cards()
