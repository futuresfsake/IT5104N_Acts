extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Set this to a small X value to spawn on the left (e.g., 50 or 100)
var spawn_point = Vector2(100, 100) 

var took_damage = false

func _physics_process(delta: float) -> void:
	# Add the gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Movement logic
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	# Collision Detection
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		
		# Ensure the name matches your Spike node exactly
		if collider.name == "TileMapSpike":
			if not took_damage:
				# Using call_deferred prevents the "ghost" collision bug
				call_deferred("respawn")

func respawn():
	took_damage = true
	position = spawn_point # This moves you back to the left
	velocity = Vector2.ZERO
	# Reset damage flag after moving
	took_damage = false
