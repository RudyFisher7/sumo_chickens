extends Node3D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ((GlobalScore.p1_score == GlobalScore.win_score) or (GlobalScore.p2_score == GlobalScore.win_score)):
		if !$AudioEnding.playing:
			$AudioEnding.play()
		if !$AudioApplause.playing:
			$AudioApplause.play()
