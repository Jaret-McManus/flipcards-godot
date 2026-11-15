class_name ObjectUtils extends RefCounted


static func check_signals(object: Object) -> void:
	var script: Script = object.get_script()
	if not script: 
		push_warning("Checking signals in object without script!: <%s>" % object)
	var signals: Array[Dictionary] = object.get_signal_list()
	for signal_dict: Dictionary in signals:
		var signal_name: StringName = signal_dict["name"]
		var is_user_signal: bool = script.has_script_signal(signal_name)
		if not is_user_signal: continue
		if object.get_signal_connection_list(signal_name).size() <= 0:
			if object is Node:
				var node: Node = object as Node
				push_error("In node <%s>: signal `%s` not connected to any callable!" % [node.name, signal_name])
			else:
				push_error("In script <%s>: signal `%s` not connected to any callable!" % [script.get_global_name(), signal_name])
