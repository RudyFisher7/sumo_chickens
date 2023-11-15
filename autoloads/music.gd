extends AudioStreamPlayer


var _battle: AudioStreamMP3 = preload("res://audio/master_of_chonk_trimmed.mp3")


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS


func play_battle_music() -> void:
	if stream != null:
		if playing:
			stop()
	
	stream = _battle
	stream.loop = true
	play()
