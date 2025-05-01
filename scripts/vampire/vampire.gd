extends Node2D

var playerDetected = false
var doorDetected = false
var KILL_TIME = 3.0
var asking = false
var SPEED = 600
var direction:int
var current_player: Node2D

@onready var label = $Label
@onready var line_edit = $Label/LineEdit

func _ready():
	label.hide()
	line_edit.hide()

func _process(_delta: float) -> void:
	if direction == 0:
		position.y += SPEED * _delta
	elif direction == 1:
		position.y -= SPEED * _delta
	elif direction == 2:
		position.x -= SPEED * _delta
	elif direction == 3:
		position.x += SPEED * _delta
	if playerDetected && doorDetected:
		if not asking:
			label.text = "ME DEJAS ENTRAR?"
			label.show()
			line_edit.text = ""
			line_edit.show()
			line_edit.grab_focus()
			asking = true
	else:
		game_over()

func _on_area_2d_area_entered(area):
	print("CHOQUE CON: "+area.name)
	if area.name == "Player_interaction":
		playerDetected = true
		KILL_TIME = 3.0 #Reseteamos el KILL_TIME
		asking = false
		current_player = area
		current_player.get_parent().ATTACKED = true
	if area.name == "Open_door":
		SPEED = 0
		doorDetected = true

func _on_body_exited(body) -> void:
	if body.name == "Player":
		playerDetected = false
		label.hide()
		line_edit.hide()
		asking = false
		body.ATTACKED = false

func _on_ResponseInput_text_submitted(new_text: String) -> void:
	print("Texto ingresado:", new_text)

	if new_text.strip_edges().to_upper() == "NO":
		print("Respuesta correcta detectada")

		label.text = ""
		line_edit.hide()
		playerDetected = false
		asking = false
		KILL_TIME = 3.0 #Reseteamos el KILL_TIME

		if current_player:
			current_player.ATTACKED = false

		# Mueve al vampiro a otro lugar
		position = Vector2(randf_range(100, 900), randf_range(100, 700))
	else:
		label.text = "..."
		game_over()

func game_over():
	label.text = "fuiste"
	line_edit.editable = false
