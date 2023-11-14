extends Node3D

var played = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !played and ((GlobalScore.p1_score == GlobalScore.win_score) or (GlobalScore.p2_score == GlobalScore.win_score)):
		played = true
		$AudioEnding.play()
		$AudioApplause.play()

