extends Node3D


func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		get_tree().change_scene_to_file("res://Chicken/chicken_tester_3d.tscn")
