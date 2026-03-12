extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Fixed: Removed invisible characters at the end of this line
var spawn_point = Vector2(100, 100)
var took_damage = false

# If your Health_bar is inside a CanvasLayer called HUD, 
# you might need: $"../HUD/Health_bar"
@onready var health_ui = $"../Health_bar"

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		
		if collider.name == "TileMapSpike" and not took_damage:
			respawn()

func respawn():
	took_damage = true
	
	# Fail-safe check: prints an error if the path is wrong
	if health_ui:
		health_ui.remove_heart()
	else:
		print("Error: health_ui not found! Check your node path.")
	
	position = spawn_point
	velocity = Vector2.ZERO
	
	await get_tree().create_timer(0.2).timeout
	took_damage = false
