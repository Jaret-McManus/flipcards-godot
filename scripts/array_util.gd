class_name ArrayUtil extends RefCounted


static func first(array: Array, count: int) -> Array:
	var collected: Array = []
	var index: int = 0
	while index < count and index < array.size():
		collected.append(array[index])
		index += 1
	
	return collected
