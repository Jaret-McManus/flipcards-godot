extends RefCounted

const result_template: String = \
"class {type_upper}Result extends _BaseResult:
	var value: {type}
	
	static func err(p_error_msg: String) -> {type_upper}Result:
		var error_result: {type_upper}Result = {type_upper}Result.new()
		error_result.has_error = true
		error_result.error_msg = p_error_msg
		return error_result
	
	static func ok(p_{type_lower}: {type}) -> {type_upper}Result:
		var success_result: {type_upper}Result = {type_upper}Result.new()
		success_result.value = p_{type_lower}
		return success_result"


static func generate_into_clipboard(type: String) -> void:
	var result_class: String = result_template.format({
		"type": type, "type_lower": type.to_lower(), "type_upper": type.capitalize()
	})
	print(result_class)
	print()
	DisplayServer.clipboard_set(result_class)
