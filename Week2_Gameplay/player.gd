extends CharacterBody2D

const SPEED = 400.0
const JUMP_VELOCITY = -600.0
const DASH_SPEED = 1200.0

func _physics_process(delta: float) -> void:
	# Add Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Check Inputs
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		print("I am jumping!") # This will show in the 'Output' log

	var direction := Input.get_axis("left", "right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
