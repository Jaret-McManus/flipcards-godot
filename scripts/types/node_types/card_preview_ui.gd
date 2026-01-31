class_name CardPreview extends MarginContainer


@export_group("Nodes")
@export var side_a_lbl: Label
@export var side_b_lbl: Label
@export var edit_texture: TextureButton

static var card_preview_scene: PackedScene = preload("uid://eaqmt7iqnlnt")

	
static func create(card: Card, transition_to_card_edit: Callable) -> CardPreview:
	var new_preview: CardPreview = card_preview_scene.instantiate()
	new_preview.side_a_lbl.text = card.side_a
	new_preview.side_b_lbl.text = card.side_b
	
	new_preview.mouse_entered.connect(
		new_preview._on_hover
	)
	new_preview.mouse_exited.connect(
		new_preview._on_unhover
	)
	
	new_preview.edit_texture.mouse_entered.connect(
		func(): new_preview.edit_texture.set_instance_shader_parameter(&"hover", true)
	)
	new_preview.edit_texture.mouse_exited.connect(
		func(): new_preview.edit_texture.set_instance_shader_parameter(&"hover", false)
	)
	new_preview.edit_texture.pressed.connect(
		func(): 
			Decks.current_card = card
			transition_to_card_edit.call()
			print("transition to card edit")
	)
	return new_preview


func _on_hover() -> void:
	self.edit_texture.visible = true
	

func _on_unhover() -> void:
	self.edit_texture.visible = false
