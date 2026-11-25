class_name DeckPracticeModel extends Node

signal time_updated(time_string: String)
signal card_updated(card: Card, index: int, total_cards: int)
signal practice_finished(time_elapsed: String, cards_practiced: int, score: Score)

const SubmissionType = Card.SubmissionType

var deck: Deck

var _is_practicing: bool = true
var _elapsed_time: float = 0.0

var _num_cards_to_practice: int = 10
var _score: Score = Score.new_score()
var _cards: Array[Card] = []
var _index: int = 0


var _time_string: String:
	set(s): _time_string = s; time_updated.emit(s)


func _process(delta: float) -> void: 
	if not _is_practicing: process_mode = Node.PROCESS_MODE_DISABLED
	
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


func next_card(type: SubmissionType) -> void:
	var current_card: Card = _cards[_index]
	current_card.update_score(type)
	_score.add_submission(type)
	
	if _index + 1 >= _num_cards_to_practice:
		_is_practicing = false
		practice_finished.emit(
			_time_string, _num_cards_to_practice, _score
		)
		DeckSaveLoad.save_deck(deck)
		return
	
	_index += 1
	card_updated.emit(_cards[_index], _index, _num_cards_to_practice)



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
