extends CharacterBody2D

var SPEED = 250.0
@onready var animation_player = $AnimationPlayer

func _ready():
	animation_player.play("brillo")
	velocity = Vector2(-200, 200).normalized() * SPEED

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal())

func die():
	Global.enemy_budget -= 1
	animation_player.play("death")
	self.queue_free()
