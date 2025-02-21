extends CharacterBody2D


const SPEED = 250.0
const JUMP_VELOCITY = -400.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var platform_ray_cast: RayCast2D = $RayCast2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	var direction := Input.get_axis("move_left", "move_right")
	
	if platform_ray_cast.is_colliding():
		if Input.is_action_just_pressed("duck"):
			collision_shape.set_deferred("disabled", true)
	else:
		collision_shape.set_deferred("disabled", false)
	
	# Flip sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("walking")
	else:
		if velocity.y > 0:
			animated_sprite.play("falling")
		else:
			animated_sprite.play("jumping")
	
	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
