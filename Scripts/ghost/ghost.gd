extends CharacterBody2D

@onready var animation_player = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@export var min_distance: float = 50.0
var player: NodePath
var speed = 150
var player_pos
var target_pos
var target: Node2D
var watched: bool = false
var MAX_HP = 100
var HP = MAX_HP
var multiplier = 1
var regeneration_amount = 20
var regeneration_interval: float = 1

func _ready():
	animation_player.play("floating")
	var regeneration_timer = Timer.new()
	add_child(regeneration_timer)
	regeneration_timer.wait_time = regeneration_interval
	regeneration_timer.timeout.connect(_on_regeneration_tick)
	regeneration_timer.start()

func _on_regeneration_tick():
	speed = 150
	HP = min(HP + regeneration_amount, MAX_HP)
	sprite.self_modulate.a += 0.01
	
func seen():
	if sprite.self_modulate.a > 0.10:
		speed = 0
		HP -= 1
		sprite.self_modulate.a -= 0.01  # Reduce opacidad gradualmente
	else:
		die()

func _physics_process(delta) -> void:
	var direction = (target.position-position).normalized()
	velocity = direction * speed
	look_at(target.position)
	move_and_slide()

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		print("TOQUE AL JUGADOR")

func die():
	Global.enemy_budget -= 3
	queue_free()
