extends AnimatableBody2D

@onready var player_tooltip: Label = $"../../../Player/PlayerTooltip"
@onready var timer: Timer = $Timer
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var is_open: bool = false
var can_be_opened: bool = false

func _ready() -> void:
	player_tooltip.visible = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	player_tooltip.text = "press (e) to open"
	player_tooltip.visible = true
	can_be_opened = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	player_tooltip.visible = false
	can_be_opened = false

func _physics_process(delta: float) -> void:
	if can_be_opened:
		if Input.is_action_just_pressed("interact"):
			is_open = true
			animation_player.play("open")
			timer.start()

func _on_timer_timeout() -> void:
	pass
