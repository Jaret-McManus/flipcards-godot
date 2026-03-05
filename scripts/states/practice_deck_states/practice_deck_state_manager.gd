class_name PracticeDeckStateManager extends StateManager


var practice_ui: PracticeDeckUI


func _ready() -> void:
	practice_ui = get_parent()
	for child: PracticeState in get_children():
		child.practice_ui = practice_ui
	super()
	
