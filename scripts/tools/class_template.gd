@tool
extends EditorScript

static var type = "DeckHomeController"

const create_template = \
"class_name {type}{super_type}


static func create() -> {type}:
	var {type_snake} := {type}.new()
	return {type_snake}"


func _run() -> void:
	var constructor := generate(type)
	DisplayServer.clipboard_set(constructor)
	print(constructor)
	print()


static func generate(p_type: String, p_super_type: String = "") -> String:
	return create_template.format({ 
		"type": p_type, 
		"type_snake": p_type.to_snake_case(),
		"super_type": "" if not p_super_type else " extends %s" % p_super_type
	})
	
