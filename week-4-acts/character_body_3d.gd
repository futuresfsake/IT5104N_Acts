extends CharacterBody3D

# --- Movement Settings ---
@export var SPEED = 8.0
@export var JUMP_VELOCITY = 6.5
@export var TILT_AMOUNT = 0.25
@export var LEAN_SPEED = 10.0

# --- Internal Variables ---
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var fps_label : Label

@onready var sprite = $Sprite3D

func _ready():
	# This part creates a visible FPS counter for your screenshot proof
	fps_label = Label.new()
	add_child(fps_label)
	# Position the label at the top left
	fps_label.position = Vector2(20, 20)
	# Give it a bit of scale so it's readable in the screenshot
	fps_label.scale = Vector2(1.5, 1.5)

func _physics_process(delta):
	# 1. Update the FPS Counter
	fps_label.text = "FPS: " + str(Engine.get_frames_per_second())
	# Color the text green if it's 60+ to show it's optimized
	if Engine.get_frames_per_second() >= 60:
		fps_label.modulate = Color.GREEN
	else:
		fps_label.modulate = Color.YELLOW

	# 2. Gravity Logic
	if not is_on_floor():
		velocity.y -= gravity * delta

	# 3. Jump with Squash and Stretch
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		# Make the sprite skinny and tall when jumping
		sprite.scale = Vector3(0.6, 1.4, 1.0) 

	# 4. Movement and Tilting
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		
		# Lean the sprite into the movement
		var target_rotation = -input_dir.x * TILT_AMOUNT
		sprite.rotation.z = lerp(sprite.rotation.z, target_rotation, delta * LEAN_SPEED)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		# Smoothly reset rotation
		sprite.rotation.z = lerp(sprite.rotation.z, 0.0, delta * LEAN_SPEED)

	# 5. Land Bounce: If we just hit the floor, squash down
	if is_on_floor() and sprite.scale.y > 1.0:
		sprite.scale = Vector3(1.3, 0.7, 1.0) # Flatten out on landing

	# 6. Smoothly return sprite to normal scale
	sprite.scale = sprite.scale.lerp(Vector3(1, 1, 1), delta * 6.0)

	move_and_slide()
