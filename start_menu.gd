extends Node3D


func _enter_tree() -> void:
	GlobalMusic.stop()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		get_viewport().set_input_as_handled()
		get_tree().change_scene_to_file("res://Chicken/chicken_tester_3d.tscn")
