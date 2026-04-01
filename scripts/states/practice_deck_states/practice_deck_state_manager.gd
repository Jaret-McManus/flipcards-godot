class_name PracticeDeckStateManager extends StateManager


var practice_ui: PracticeDeckUI


func _ready() -> void:
	practice_ui = get_parent()
	for child: PracticeState in get_children():
		child.practice_ui = practice_ui
	super()
	

func _state_transition(next_state_name: StringName, _data: Variant = null) -> void:
	super(next_state_name)
