class_name Option extends Node


class _BaseOption:
	var has_value: bool = false


class StringOption extends _BaseOption:
	var value: String
	
	
	static func none() -> StringOption:
		var none_option: StringOption = StringOption.new()
		none_option.has_value = false
		return none_option
	
	
	static func some(p_string: String) -> StringOption:
		var some_option: StringOption = StringOption.new()
		some_option.has_value = true
		some_option.value = p_string
		return some_option
