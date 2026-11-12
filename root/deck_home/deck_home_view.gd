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
	if p_is_visible: _popup_wipe()


func _popup_toggle_buttons(p_is_visible: bool) -> void:
	_toggle_button(start_practice_btn, p_is_visible)
	_toggle_button(add_card_btn, p_is_visible)
	_toggle_button(back_deck_btn, p_is_visible)


func _toggle_button(button: PaddedButton, popup_visible: bool) -> void:
	button.disabled = popup_visible
	button.button_focus_mode = Control.FOCUS_NONE if popup_visible else Control.FOCUS_ALL


func _popup_wipe() -> void:
	add_card_popup.a_input.text = ""
	add_card_popup.a_error.text = ""
	add_card_popup.b_input.text = ""
	add_card_popup.b_error.text = ""


func _setup_model() -> void:
	model.set_view(self)
	model.top_screen_percentage_changed.connect(_on_top_screen_percentage_changed)


func _setup_controller() -> void:
	controller.model = model
	add_card_btn.pressed.connect(controller.on_add_card_pressed)


func _on_top_screen_percentage_changed(new_percentage: float) -> void:
	top_section.custom_minimum_size.y = (new_percentage / 100.0) * self.size.y
