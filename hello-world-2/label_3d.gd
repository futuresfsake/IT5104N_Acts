extends Label3D

# Adjust speed: 1.0 is slow, 5.0 is very fast
var spin_speed = 2.0 

func _process(delta):
	# rotate_y makes it spin like a carousel
	rotate_y(spin_speed * delta)
	
