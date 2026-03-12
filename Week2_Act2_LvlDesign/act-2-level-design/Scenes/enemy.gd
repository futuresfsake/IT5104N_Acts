extends CharacterBody2D

const SPEED = 100.0
var direction = 1 

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if is_on_wall():
		direction *= -1
	
	velocity.x = direction * SPEED
	move_and_slide()
	
	# Flip sprite based on direction
	if direction > 0:
		$Sprite2D.flip_h = false
	else:
		$Sprite2D.flip_h = true

# This is the "Stomp" function. 
# Connect the Area2D 'body_entered' signal to THIS function.
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Pink":
		# Make the player bounce up
		body.velocity.y = -300 
		# Delete the enemy (self)
		queue_free()
