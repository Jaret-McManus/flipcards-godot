class_name Result extends RefCounted


class _BaseResult:
	var has_error: bool = false
	var error_msg: String


class StringResult extends _BaseResult:
	var value: String
	
	static func err(p_error_msg: String) -> StringResult:
		var error_result: StringResult = StringResult.new()
		error_result.has_error = true
		error_result.error_msg = p_error_msg
		return error_result
	
	static func ok(p_string: String) -> StringResult:
		var success_result: StringResult = StringResult.new()
		success_result.value = p_string
		return success_result
