@tool
class_name PracticeDeckUI extends MarginContainer
#PracticeDeckState


var cards: Array[Card]

@export var practice_button_mode: bool = true:
	set(b):
		practice_button_mode = b
		dont_know_button.visible = b				
		hard_button.visible = b
		easy_button.visible = b
		moderate_button.visible = b
		
@export var continue_button_mode: bool = false:
	set(b):
		continue_button_mode = b
		continue_button.visible = b
		card.answer_visible = b

@export_group("Internal Nodes")
@export var header_title: Label
@export var timer_label: Label
@export var card: PracticeCard
@export var quit_btn: Button
@export var dont_know_button: RichButton
@export var hard_button: RichButton
@export var moderate_button: RichButton
@export var easy_button: RichButton
@export var continue_button: RichButton
@export var state_manager: PracticeDeckStateManager
