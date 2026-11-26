class_name Option extends Node


class _BaseOption:
	var _has_value: bool = false
	
	func is_some() -> bool: return _has_value
	
	func is_none() -> bool: return not _has_value


class StringOption extends _BaseOption:
	var value: String
	
	
	static func none() -> StringOption:
		var none_option: StringOption = StringOption.new()
		none_option._has_value = false
		return none_option
	
	
	static func some(p_string: String) -> StringOption:
		var some_option: StringOption = StringOption.new()
		some_option._has_value = true
		some_option.value = p_string
		return some_option


class ObjectOption extends _BaseOption:
	var value: Object
	
	
	static func none() -> ObjectOption:
		var none_option: ObjectOption = ObjectOption.new()
		none_option._has_value = false
		return none_option
	
	
	static func some(p_object: Object) -> ObjectOption:
		var some_option: ObjectOption = ObjectOption.new()
		some_option._has_value = true
		some_option.value = p_object
		return some_option
