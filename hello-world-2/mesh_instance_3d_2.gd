extends MeshInstance3D

# Adjust speed: 1.0 is slow, 5.0 is fast
var bounce_speed = 3.0   
# Adjust height: 0.5 is a small hop, 2.0 is a big jump
var bounce_height = 1.0  

var time_passed = 0.0

func _process(delta):
	time_passed += delta
	
	# The sin() function moves the object smoothly up and down
	# on the Y-axis (vertical)
	position.y = sin(time_passed * bounce_speed) * bounce_height
	
