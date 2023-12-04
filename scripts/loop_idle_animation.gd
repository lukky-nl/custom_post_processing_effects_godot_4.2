extends AnimationPlayer

func _process(delta):
	if !is_playing():
		play("idle")
