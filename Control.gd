extends Node2D

var new_rolls = {"roll1": [1, 2], "roll2": [2, 3], "roll3": [3, 4]}

func _ready():
	for rolls in new_rolls.keys():
		var view: Array = (new_rolls[rolls])
		print(view[1])
