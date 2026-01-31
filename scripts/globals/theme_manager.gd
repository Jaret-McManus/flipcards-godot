@tool
class_name ThemeManager extends Node

var header_color: Color:
	set(c): 
		header_color = c
		
		var style_box: StyleBoxFlat = header_theme["PanelContainer/styles/panel"]
		style_box.bg_color = c
		style_box.border_color = c
	
@export_group("Export constants")
@export var main_theme: Theme
@export var header_theme: Theme
@export var footer_theme: Theme
