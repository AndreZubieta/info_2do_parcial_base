extends Node

var levels = []
var current_level_index = 0

func get_current_level():
	return levels[current_level_index]

func next_level():
	current_level_index += 1
	if current_level_index >= levels.size():
		current_level_index = 0