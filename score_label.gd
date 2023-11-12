extends Label


@export var player_id: int = 0


func _ready() -> void:
	var score: int = 0
	if player_id == 0:
		score = GlobalScore.p1_score
	elif player_id == 1:
		score = GlobalScore.p2_score
	
	text = "Player %s score: %s" % [player_id + 1, score]
