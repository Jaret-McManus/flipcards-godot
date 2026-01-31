class_name SelectDeckUI extends PanelContainer


@export_group("Nodes")
@export var grid: CenteredGridContainer
@export var scroll_container: ScrollContainer
@export var new_deck_btn: Button


func add_to_grid(node: Node) -> void:
	grid.add_node(node)
	

func clear_grid() -> void:
	grid.clear()


func toggle_button_interactions() -> void:
	new_deck_btn.disabled = not new_deck_btn.disabled
		
