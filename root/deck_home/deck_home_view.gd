@tool
class_name DeckHomeView extends View

@export var model: DeckHomeModel

@export_group("Internal Nodes")
@export var controller: DeckHomeController

@export var top_section: Control
@export var centered_grid: CenteredGridContainer
@export var add_card_popup: AddCardPopup

@export var start_practice_btn: PaddedButton
@export var add_card_btn: PaddedButton
@export var back_deck_btn: PaddedButton


func _ready() -> void:
	_setup_model()
	_setup_controller()


func set_add_card_visibility(p_is_visible: bool) -> void:
	add_card_popup.visible = p_is_visible
	_popup_toggle_buttons(p_is_visible)
	if p_is_visible: add_card_popup.setup_open()


func add_card_view(card: Card) -> void:
	var card_view := CardView.create(card)
	centered_grid.add_node(card_view)


func _popup_toggle_buttons(p_is_visible: bool) -> void:
	ControlUtils.set_button_disabled(start_practice_btn, p_is_visible)
	ControlUtils.set_button_disabled(add_card_btn, p_is_visible)
	ControlUtils.set_button_disabled(back_deck_btn, p_is_visible)


func _setup_model() -> void:
	model.set_view(self)
	model.top_screen_percentage_changed.connect(_on_top_screen_percentage_changed)


func _setup_controller() -> void:
	controller.model = model
	add_card_btn.pressed.connect(controller.on_add_card_pressed)
	add_card_popup.submitted_add_card.connect(controller.on_add_card_submit)


func _on_top_screen_percentage_changed(new_percentage: float) -> void:
	top_section.custom_minimum_size.y = (new_percentage / 100.0) * self.size.y
