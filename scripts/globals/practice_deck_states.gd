extends Node


var present_card: StringName = &"PresentCardState"
var reveal_card: StringName = &"RevealCardState"
var transition_card: StringName = &"TransitionCardState"
var end_practice: StringName = &"EndPracticeState"

enum CardStatus {
	DONT_KNOW, HARD, MODERATE, EASY, NULL
}
