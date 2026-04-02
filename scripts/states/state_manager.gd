@abstract
class_name StateManager extends Node


@export var INIT_STATE: State


var curr_state: State
var state_dict: Dictionary[StringName, State]


func _ready() -> void:
	var children: Array[Node] = get_children()
	for child:Node in children:
		if child is not State: 
			Error.quit("%s's has a child that isn't a State!" % self.name)
			
		var state: State = child 
		state_dict[state.name] = state 
		state.transition.connect(_state_transition)
	
	curr_state = INIT_STATE
	curr_state.on_enter(&"")


func _process(delta: float) -> void:
	curr_state.process(delta)


func _state_transition(next_state_name: StringName) -> void:
	if not next_state_name: 
		Error.quit("%s attempted to transition to a null state!" % self.name)
		
	if next_state_name == curr_state.name: return # nothing to do
	
	if next_state_name not in state_dict:
		Error.quit(
			"State: \"%s\", not found in %s state machine!" % [next_state_name, self.name]
		)
	
	var prev_state: State = curr_state
	prev_state.on_exit(next_state_name)
	
	curr_state = state_dict[next_state_name]
	
	curr_state.on_enter(prev_state.name)
