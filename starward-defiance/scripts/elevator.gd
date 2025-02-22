extends AnimatableBody2D

const SPEED: float = 100.0

@onready var player_tooltip: Label = %PlayerTooltip
@onready var area_2d: Area2D = $Area2D
@onready var ray_cast_bottom: RayCast2D = $RayCastBottom
@onready var ray_cast_top: RayCast2D = $RayCastTop

var is_ridable = false
var at_bottom = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_tooltip.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ray_cast_bottom.is_colliding():
		at_bottom = true
		
	if ray_cast_top.is_colliding():
		at_bottom = false
		
	if velocity.y == 0
		if is_ridable:
			if Input.is_action_just_pressed("interact"):
				if at_bottom:
					velocity.y = -SPEED
				else:
					velocity.y = SPEED

func _on_area_2d_body_entered(body: Node2D) -> void:
	player_tooltip.text = "press (e) to ride elevator"
	player_tooltip.visible = true
	is_ridable = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	player_tooltip.visible = false
	is_ridable = false
