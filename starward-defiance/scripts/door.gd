extends AnimatableBody2D

@onready var area_2d: Area2D = $Area2D
@onready var player_tooltip: Label = $"../../Player/PlayerTooltip"
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer2
@onready var timer: Timer = $Timer

var is_open: bool = false

func _ready() -> void:
	player_tooltip.visible = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	player_tooltip.text = "press (e) to open"
	player_tooltip.visible = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	player_tooltip.visible = false

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		is_open = true
		timer.start()
d		animation_player.play("open")

func _on_timer_timeout() -> void:
	animation_player.play("close")
