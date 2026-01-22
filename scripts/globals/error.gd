extends Node # to get tree for quitting


func quit(err: String) -> void:
	print_rich("[color=red]%s[/color]" % err)
	get_tree().quit(1)
