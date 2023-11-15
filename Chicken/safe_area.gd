extends Area3D


func _on_body_exited(body: Node3D) -> void:
	if body is Chicken3D:
		var loser: Chicken3D = body as Chicken3D
		
		if loser.player_id == Chicken3D.PLAYER_1:
			GlobalScore.p2_score += 1
		elif loser.player_id == Chicken3D.PLAYER_2:
			GlobalScore.p1_score += 1
		
		body_exited.disconnect(_on_body_exited) # for some reason this is being called twice
		$AudioDie.play()
		await $AudioDie.finished
		# Just reload the scene. Probably not efficient but good enough for a game jam.
		get_tree().change_scene_to_file("res://Chicken/chicken_tester_3d.tscn")
