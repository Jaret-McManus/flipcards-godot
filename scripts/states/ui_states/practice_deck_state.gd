class_name PracticeDeckState extends UIState


var ui_instance: PracticeDeckUI
var curr_card_time: float = 0.0
var timer_label: Label
@export var scene: PackedScene

func on_enter(_prev_state: StringName) -> void:
	ui_instance = scene.instantiate()
	timer_label = ui_instance.timer_label
	_connect_signals()
	_practice_deck_init()
	content_container.add_child(ui_instance)


func on_exit(_next_state: StringName) -> void:
	content_container.remove_child(ui_instance)
	ui_instance = null
	

func _practice_deck_init() -> void:
	ui_instance.header_title.text = "Practicing %s" % Decks.current_deck.name
	ui_instance.timer_label.text = "0:00"
	
	var card: Card = Decks.current_deck.cards.pick_random()
	ui_instance.card.side_a_text = card.side_a
	ui_instance.card.side_b_text = card.side_b


func _process(delta: float) -> void:
	if not timer_label: return
	curr_card_time += delta
	var time_string: String = _format_time(curr_card_time)
	if timer_label.text != time_string:
		timer_label.text = time_string
		
	
func _format_time(p_seconds: float) -> String:
	var total_seconds: int = floori(p_seconds)
	var seconds: int = total_seconds % 60
	var minutes: int = int(total_seconds / 60.0)
	return "%d:%02d" % [minutes, seconds]
	
	
func _connect_signals() -> void:
	ui_instance.quit_btn.pressed.connect(
		self.transition.emit.bind(UIStates.edit_deck)
	)
