extends Area2D

enum Direction {DOWN, UP, LEFT, RIGHT}  # Debe coincidir con el enum de vampire_spawner.gd

var playerDetected = false
var input_active = false
var current_player: Node2D
var moving = true
var direction: int
var SPEED = 300
var reached_door = false

@onready var label = get_node("/root/Game/VampAttack/InviteLabel")
@onready var input = get_node("/root/Game/VampAttack/ResponseInput")
@onready var door = get_node("/root/Game/Door")  # Asume que existe un nodo Door con propiedad "open"

func _ready():
	label.hide()
	input.hide()
	input.connect("text_submitted", Callable(self, "_on_ResponseInput_text_submitted"))

func _process(delta):
	if moving:
		if direction == 0:
			position.y += SPEED * delta
		elif direction == 1:
			position.y -= SPEED * delta
		elif direction == 2:
			position.x -= SPEED * delta
		elif direction == 3:
			position.x += SPEED * delta
	
	# Verificar si llegó a la puerta
	if !reached_door and global_position.distance_to(door.global_position) < 20:
		reached_door = true
		SPEED = 0
		moving = false
		if playerDetected and door.open:
			show_question()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		playerDetected = true
		current_player = body
		current_player.ATTACKED = true
		if reached_door and door.open:
			show_question()

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		playerDetected = false
		hide_question()
		body.ATTACKED = false

func show_question():
	label.text = "ME DEJAS ENTRAR?"
	label.show()
	input.text = ""
	input.show()
	input.grab_focus()
	input_active = true

func hide_question():
	label.hide()
	input.hide()
	input_active = false

func _on_ResponseInput_text_submitted(new_text: String) -> void:
	print("Texto ingresado:", new_text)

	if new_text.strip_edges().to_upper() == "NO":
		print("Respuesta correcta detectada")
		hide_question()
		playerDetected = false
		current_player.ATTACKED = false
		queue_free()  # Elimina al vampiro
	else:
		label.text = "..."
		Global.game_over = true  # Asumiendo que tienes una variable global para game over
