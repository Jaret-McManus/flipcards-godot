class_name PracticeDeckUI extends MarginContainer
#PracticeDeckState


var cards: Array[Card]

@export_group("Internal Nodes")
@export var header_title: Label
@export var timer_label: Label
@export var card: PracticeCard
@export var quit_btn: Button
@export var dont_know_button: RichButton
@export var hard_button: RichButton
@export var moderate_button: RichButton
@export var easy_button: RichButton
@export var state_manager: PracticeDeckStateManager
