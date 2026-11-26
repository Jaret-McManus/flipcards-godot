class_name EmptySection extends CenterContainer

const EMPTY_SECTION_SCENE = preload("uid://dgcpt0crt42vk")

@export var label: Label


static func create(missing_type: String) -> EmptySection:
	var instance: EmptySection = EMPTY_SECTION_SCENE.instantiate()
	instance.label.text = instance.label.text % missing_type
	return instance


static func create_populate(control: Control, missing_type: String) -> EmptySection:
	var empty_section := create(missing_type)
	control.add_child(empty_section)
	return empty_section
