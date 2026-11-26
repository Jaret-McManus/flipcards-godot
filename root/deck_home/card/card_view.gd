class_name CardView extends PanelContainer

signal edit_card_pressed(card_view: CardView)
signal delete_card_pressed(card_view: CardView)

const CARD_VIEW_SCENE = preload("uid://dg7cio7p6lin5")

@export var display_only: bool = false

@export_group("Internal Nodes")
@export var side_a_label: RichTextLabel
@export var side_b_label: RichTextLabel
@export var delete_button: PaddedButton
@export var edit_button: PaddedButton

var card: Card


static func create(p_card: Card, p_deck_home_controller: DeckHomeController) -> CardView:
	var instance: CardView = CARD_VIEW_SCENE.instantiate()
	instance.card = p_card
	instance.side_a_label.text = p_card.side_a_text
	instance.side_b_label.text = p_card.side_b_text
	
	instance.edit_card_pressed.connect(
		p_deck_home_controller.on_edit_card_pressed
	)
	instance.delete_card_pressed.connect(
		p_deck_home_controller.on_delete_card_pressed
	)
	
	return instance


func _ready() -> void:
	if display_only:
		delete_button.queue_free()
		edit_button.queue_free()
		mouse_entered.disconnect(_on_mouse_entered)
		mouse_exited.disconnect(_on_mouse_exited)


func update_from_card() -> void:
	side_a_label.text = card.side_a_text
	side_b_label.text = card.side_b_text


func _emit_edit() -> void: edit_card_pressed.emit(self)


func _emit_delete() -> void: delete_card_pressed.emit(self)


func _on_mouse_entered() -> void: _set_button_visibility(true)


func _on_mouse_exited() -> void: _set_button_visibility(false)


func _set_button_visibility(on: bool) -> void:
	delete_button.visible = on
	edit_button.visible = on
