class_name DeckPracticeModel extends Node

signal time_updated(time_string: String)

var deck: Deck

var _elapsed_time: float = 0.0
var _num_cards_to_practice: int

var _time_string: String:
	set(s): _time_string = s; time_updated.emit(s)


func _process(delta: float) -> void: 
	_elapsed_time += delta
	var formatted_time: String = _format_time(_elapsed_time)
	if _time_string != formatted_time:
		_time_string = formatted_time



func setup(p_deck: Deck) -> void: deck = p_deck


func _format_time(time_seconds: float) -> String:
	var minutes: int = int(time_seconds / 60.0)
	var seconds: int = int(time_seconds) % 60
	return "{minutes}:{seconds}".format({ 
		"minutes": minutes, 
		"seconds": str(seconds).pad_zeros(2)
	})
