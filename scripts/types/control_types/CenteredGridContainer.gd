class_name CenteredGridContainer extends VBoxContainer


@export var NUM_COLUMNS: int = 3
var rows: Array[HBoxContainer] = [] # dummy spacers
var total_elements: int = 0


class Spacer extends Control: pass


static func create(num_columns: int) -> CenteredGridContainer:
	var grid: CenteredGridContainer = CenteredGridContainer.new()
	grid.NUM_COLUMNS = num_columns
	
	return grid


func add_node(node: Node) -> void:
	if total_elements % NUM_COLUMNS == 0:
		_add_row()

	total_elements += 1
	_add_node_with_spacers(node)


func _add_node_with_spacers(node: Node) -> void:
	var elems_in_curr_row: int = total_elements % NUM_COLUMNS
	if elems_in_curr_row == 0: elems_in_curr_row = NUM_COLUMNS # 0 means full row
	
	var last_row: HBoxContainer = rows.back()
	var last_spacer: Node = last_row.get_child(-1)
	last_row.add_child(node)
	
	var spacer_flex: float = (NUM_COLUMNS - elems_in_curr_row) / 2.0
	(last_row.get_child(0) as Control).size_flags_stretch_ratio = spacer_flex
	(last_spacer as Control).size_flags_stretch_ratio = spacer_flex
	
	if elems_in_curr_row == NUM_COLUMNS:
		var first_spacer: Control = last_row.get_child(0)
		last_row.remove_child(first_spacer)
		last_row.remove_child(last_spacer)
	else:
		last_row.move_child(last_spacer, -1)	


func remove_node_reorder() -> void:
	Error.quit("CenteredGridContainer::remove_node_reorder is not implemented!")

		
func _make_spacer(flex_ratio: float) -> Spacer:
	var spacer: Spacer = Spacer.new()
	spacer.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	spacer.size_flags_stretch_ratio = flex_ratio
	return spacer


func _add_row() -> void:
	var new_row: HBoxContainer = HBoxContainer.new()
	new_row.add_child(_make_spacer(0.0))
	new_row.add_child(_make_spacer(0.0))
	#new_row.add_theme_constant_override(&"separation", 10)
	rows.append(new_row)
	self.add_child(new_row)


func clear() -> void:
	rows = []
	total_elements = 0
	Utils.remove_children_free(self)
