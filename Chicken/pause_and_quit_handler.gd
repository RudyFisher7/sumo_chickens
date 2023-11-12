extends Node3D


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_home"):
		get_viewport().set_input_as_handled()
		if get_tree().paused:
			get_tree().paused = false
		get_tree().change_scene_to_file("res://start_menu.tscn")
	elif event.is_action_pressed("ui_accept"):
		get_viewport().set_input_as_handled()
		get_tree().paused = !get_tree().paused
		print("paused %s" % get_tree().paused)
