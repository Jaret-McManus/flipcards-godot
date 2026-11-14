extends RefCounted

const option_template: String = \
"class {type_upper}Option extends _BaseOption:
	var value: {type}
	
	
	static func none() -> {type_upper}Option:
		var none_option: {type_upper}Option = {type_upper}Option.new()
		none_option.has_value = false
		return none_option
	
	
	static func some(p_{type_lower}: {type}) -> {type_upper}Option:
		var some_option: {type_upper}Option = {type_upper}Option.new()
		some_option.has_value = true
		some_option.value = p_{type_lower}
		return some_option"


static func generate_into_clipboard(type: String) -> void:
	var option_class: String = option_template.format({
		"type": type, "type_lower": type.to_lower(), "type_upper": type.capitalize()
	})
	print(option_class)
	print()
	DisplayServer.clipboard_set(option_class)
