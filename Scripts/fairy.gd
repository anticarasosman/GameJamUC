extends CharacterBody2D

var SPEED = 250.0

func _ready():
	velocity = Vector2(-200, 200).normalized() * SPEED

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal())

func _on_area_2d_area_entered(area):
	if area.name == "Open_door":
		area.open = false
