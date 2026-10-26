@tool
class_name DeckHomeModel extends Resource

var view: DeckHomeView

@export_group("Control Parameters")
signal top_screen_percentage_changed(new_float: float)
@export_range(0.0,100.0,1.0) var top_screen_percentage: float:
	set(f):
		top_screen_percentage = f
		top_screen_percentage_changed.emit(f)

@export_group("Data")


static func create(p_view: DeckHomeView) -> DeckHomeModel:
	var deck_home_model := DeckHomeModel.new()
	deck_home_model.view = p_view
	return deck_home_model
