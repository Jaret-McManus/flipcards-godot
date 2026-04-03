extends TextureButton


func _ready() -> void:
	self.mouse_entered.connect(_on_hover)
	self.mouse_exited.connect(_on_unhover)


func _on_hover() -> void:
	self.set_instance_shader_parameter(&"hover", true)


func _on_unhover() -> void:
	self.set_instance_shader_parameter(&"hover", false)
