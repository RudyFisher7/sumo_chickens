extends Node3D


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_home"):
		get_viewport().set_input_as_handled()
		if get_tree().paused:
			get_tree().paused = false
		%Area3D.body_exited.disconnect(%Area3D._on_body_exited) # This code is getting gross... I should clean this up after the jam
		get_tree().change_scene_to_file("res://start_menu.tscn")
	elif event.is_action_pressed("ui_accept"):
#		$"../Control/VBoxContainer5".visible = not $"../Control/VBoxContainer5".visible
#		$"../Control/ColorRect".visible = not $"../Control/ColorRect".visible
		get_viewport().set_input_as_handled()
		get_tree().paused = !get_tree().paused
		print("paused %s" % get_tree().paused)
