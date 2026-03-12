extends Sprite2D

func _ready():
	start_pulse()

func start_pulse():
	# This makes the heart beat forever
	var tween = create_tween().set_loops()
	
	# Scale up slightly
	tween.tween_property(self, "scale", Vector2(1.2, 1.2), 0.4).set_trans(Tween.TRANS_SINE)
	
	# Scale back to normal
	tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.4).set_trans(Tween.TRANS_SINE)
