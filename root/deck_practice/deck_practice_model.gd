class_name DeckPracticeModel extends Node

signal time_updated(time_string: String)
signal card_updated(card: Card, index: int, total_cards: int)
signal practice_finished()

enum SubmissionType { EASY, MEDIUM, HARD, DONT_KNOW }


var deck: Deck

var _elapsed_time: float = 0.0
var _num_cards_to_practice: int = 10
var _cards: Array[Card] = []
var _index: int = 0

var _time_string: String:
	set(s): _time_string = s; time_updated.emit(s)


func _process(delta: float) -> void: 
	_elapsed_time += delta
	var formatted_time: String = _format_time(_elapsed_time)
	if _time_string != formatted_time:
		_time_string = formatted_time


func setup(p_deck: Deck) -> void: 
	deck = p_deck
	_cards = _collect_cards(deck.cards, _num_cards_to_practice)
	init_card()


func init_card() -> void:
	card_updated.emit(_cards[_index], _index, _num_cards_to_practice)


func next_card(_type: SubmissionType) -> void:
	_index += 1
	if _index < _num_cards_to_practice:
		card_updated.emit(_cards[_index], _index, _num_cards_to_practice)
	else:
		print("Emitting `practice_finished`")
		practice_finished.emit()


func _collect_cards(all_cards: Array[Card], number_cards: int) -> Array[Card]:
	var cards: Array[Card] = all_cards.duplicate()
	cards.shuffle()
	
	var cards_to_study: Array[Card]
	cards_to_study.assign(ArrayUtil.first(cards, number_cards))
	
	var cards_taken: int = cards_to_study.size()
	while cards_taken < number_cards:
		cards.shuffle()
		
		var next_card_batch: Array[Card]
		next_card_batch.assign(ArrayUtil.first(cards, number_cards - cards_taken))
		
		cards_to_study.append_array(next_card_batch)
		cards_taken = cards_to_study.size()
	
	return cards_to_study


func _format_time(time_seconds: float) -> String:
	var minutes: int = int(time_seconds / 60.0)
	var seconds: int = int(time_seconds) % 60
	return "{minutes}:{seconds}".format({ 
		"minutes": minutes, 
		"seconds": str(seconds).pad_zeros(2)
	})
