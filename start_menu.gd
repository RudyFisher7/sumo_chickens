extends Node3D

var _menu: AudioStreamMP3 = preload("res://audio/chonky_tonky.mp3")

func _enter_tree() -> void:
	GlobalMusic.stream = _menu
	GlobalMusic.stream.loop = true
	GlobalMusic.play()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		get_viewport().set_input_as_handled()
#		$AudioStreamPlayer2.play()
#		await $AudioStreamPlayer2.finished
		get_tree().change_scene_to_file("res://Chicken/chicken_tester_3d.tscn")
