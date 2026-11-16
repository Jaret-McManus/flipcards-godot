class_name CardView extends PanelContainer

signal edit_card_pressed(card_view: CardView)
signal delete_card_pressed()

const CARD_VIEW_SCENE = preload("uid://dg7cio7p6lin5")

@export var side_a_label: RichTextLabel
@export var side_b_label: RichTextLabel
@export var delete_button: PaddedButton
@export var edit_button: PaddedButton

var card: Card

static func create(p_card: Card) -> CardView:
	var instance: CardView = CARD_VIEW_SCENE.instantiate()
	instance.card = p_card
	instance.side_a_label.text = p_card.side_a_text
	instance.side_b_label.text = p_card.side_b_text
	return instance


func update_from_card() -> void:
	side_a_label.text = card.side_a_text
	side_b_label.text = card.side_b_text


func _emit_edit() -> void: edit_card_pressed.emit(self)


func _emit_delete() -> void: delete_card_pressed.emit()


func _on_mouse_entered() -> void: _set_button_visibility(true)


func _on_mouse_exited() -> void: _set_button_visibility(false)


func _set_button_visibility(on: bool) -> void:
	delete_button.visible = on
	edit_button.visible = on
