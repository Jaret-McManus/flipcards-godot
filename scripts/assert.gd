class_name Assert extends RefCounted


static func exports_nonnull(node: Node) -> void:
	var properties: Array[Dictionary] = node.get_property_list()
	for property: Dictionary in properties:
		if _is_property_export(property) and _is_property_nullable(property):
			var variable_name: String = property["name"]
			assert(
				node.get_indexed(variable_name) != null, 
				"%s: exported variable `%s` is not set!" % [node.name, variable_name]
			)


static func _is_property_export(property: Dictionary) -> bool:
	var has_export_flags: bool = property["usage"] & PROPERTY_USAGE_EDITOR
	has_export_flags = has_export_flags and (property["usage"] & PROPERTY_USAGE_STORAGE)
	has_export_flags = has_export_flags and (property["usage"] & PROPERTY_USAGE_SCRIPT_VARIABLE)
	return has_export_flags


static func _is_property_nullable(property: Dictionary) -> bool:
	var type: Variant.Type = property["type"]
	return type == TYPE_NIL or type == TYPE_OBJECT
