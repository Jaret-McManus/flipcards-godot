@tool
class_name DeckHomeModel extends Resource

signal open_add_card_popup()
signal open_edit_card_popup(card_to_edit: Card)
signal close_popup()

const CARD_SCENE := preload("uid://dg7cio7p6lin5")
const ObjectOption = Option.ObjectOption

enum PopupMode { ADD_CARD, EDIT_CARD }

var _view: DeckHomeView
var deck: Deck
var current_card: Card # for editting

@export_group("Data")
@export var popup_mode: PopupMode:
	set(pm): popup_mode = pm
@export var is_popup_open: bool = false:
	set(b): 
		is_popup_open = b
		


func build(p_view: DeckHomeView, p_deck: Deck) -> void:
	_view = p_view
	deck = p_deck


func set_popup_open(p_popup_mode: PopupMode, card_option: ObjectOption = ObjectOption.none()) -> void:
	popup_mode = p_popup_mode
	if popup_mode == PopupMode.ADD_CARD:
		open_add_card_popup.emit()
	elif popup_mode == PopupMode.EDIT_CARD:
		assert(card_option.has_value)
		var card: Card = card_option.value as Card
		current_card = card
		open_edit_card_popup.emit(card)


func add_card(card: Card) -> void:
	deck.cards.append(card)
	DeckSaveLoad.save_deck(deck)
	_view.add_card_view(card)
