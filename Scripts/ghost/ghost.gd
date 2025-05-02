extends CharacterBody2D

@export var min_distance: float = 50.0
var player: NodePath
var speed = 150
var player_pos
var target_pos
var target: Node2D
var watched: bool = false
var HP: int
var multiplier = 1
var regeneration_amount = 20
var regeneration_interval: float = 1

func _ready():
	var regeneration_timer = Timer.new()
	add_child(regeneration_timer)
	regeneration_timer.wait_time = regeneration_interval
	regeneration_timer.timeout.connect(_on_regeneration_tick)
	regeneration_timer.start()
	HP = 100

func _on_regeneration_tick():
	speed = 150
	HP = min(HP + regeneration_amount, 100)

func seen():
	print("ME ESTAN VIENDO")
	speed = 0
	HP -= 1
	if HP <= 0:
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
	queue_free()
