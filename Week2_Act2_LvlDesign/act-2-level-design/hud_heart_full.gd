extends Sprite2D

func _ready():
	start_pulse()

func start_pulse():
	# Create a tween that loops forever
	var tween = create_tween().set_loops()
	
	# 1. Scale up to 1.2x size over 0.3 seconds
	tween.tween_property(self, "scale", Vector2(1.2, 1.2), 0.3).set_trans(Tween.TRANS_SINE)
	
	# 2. Scale back down to 1.0x size over 0.3 seconds
	tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.3).set_trans(Tween.TRANS_SINE)
