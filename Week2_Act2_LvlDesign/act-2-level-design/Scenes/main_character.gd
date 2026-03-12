extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var spawn_point = Vector2(100, 100)
var took_damage = false

# Make sure this path is correct for your Health_bar node!
@onready var health_ui = $"../Health_bar"

func _physics_process(delta: float) -> void:
	# Add gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Movement
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	# Collision detection for Spikes or Enemies
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		
		# If you hit a Spike OR an Enemy from the side, you respawn
		if (collider.name == "TileMapSpike" or "Enemy" in collider.name) and not took_damage:
			respawn()

func respawn():
	took_damage = true
	if health_ui:
		health_ui.remove_heart()
	
	position = spawn_point
	velocity = Vector2.ZERO
	
	await get_tree().create_timer(0.5).timeout
	took_damage = false
