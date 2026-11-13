@tool
class_name DeckSelectModel extends Resource

signal top_bar_margin_changed(margin: Margin)
signal title_font_size_changed(size: int)

signal popup_visibility_changed

@export_group("Model Data")
@export var is_popup_visible: bool:
	set(b): is_popup_visible = b; popup_visibility_changed.emit(b)

@export_group("Control Parameters")
@export var top_bar_margin: Margin
@export_range(0, 256) var title_font_size: int:
	set(i): title_font_size = i; title_font_size_changed.emit(i)
	
var view: DeckSelectView
var decks: Array[Deck]


func build(p_view: DeckSelectView) -> void:
	top_bar_margin.changed.connect(
		top_bar_margin_changed.emit.bind(top_bar_margin)
	)
	view = p_view


func add_deck(deck: Deck) -> void:
	decks.append(deck)
	view.add_deck(deck)
