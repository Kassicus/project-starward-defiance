extends CharacterBody2D

const SPEED = 250.0
const JUMP_VELOCITY = -400.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var platform_ray_cast: RayCast2D = $PlatformRayCast
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var wall_ray_cast_right: RayCast2D = $WallRayCastRight
@onready var wall_ray_cast_left: RayCast2D = $WallRayCastLeft

var current_jumps = 0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
		if wall_ray_cast_left.is_colliding() or wall_ray_cast_right.is_colliding():
			if current_jumps < 1:
				if Input.is_action_just_pressed("jump"):
					current_jumps += 1
					velocity.y = JUMP_VELOCITY

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
		current_jumps = 0
		
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
