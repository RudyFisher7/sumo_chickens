class_name Score
extends Node


var win_score: int = 3


var p1_score: int = 0
var p2_score: int = 0


var i: int = 0

func increment_i() -> void:
	i = (i + 1) % 8
