extends Area2D

var playerDetected = false
var KILL_TIME = 3.0
var input_active = false
var current_player: Node2D  # Guarda referencia al jugador detectado

@onready var label = get_node("/root/Game/VampAttack/InviteLabel")
@onready var input = get_node("/root/Game/VampAttack/ResponseInput")

func _ready():
	label.hide()
	input.hide()

	input.connect("text_submitted", Callable(self, "_on_ResponseInput_text_submitted"))


func _process(_delta: float) -> void:
	if playerDetected:
		if KILL_TIME > 0:
			KILL_TIME -= _delta
			if not input_active:
				label.text = "ME DEJAS ENTRAR?"
				label.show()
				
				input.text = ""
				input.show()
				input.grab_focus()
				
				input_active = true
		else:
			game_over()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		playerDetected = true
		KILL_TIME = 3.0 #Reseteamos el KILL_TIME
		input_active = false
		current_player = body
		current_player.ATTACKED = true

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		playerDetected = false
		label.hide()
		input.hide()
		input_active = false
		body.ATTACKED = false

func _on_ResponseInput_text_submitted(new_text: String) -> void:
	print("Texto ingresado:", new_text)

	if new_text.strip_edges().to_upper() == "NO":
		print("Respuesta correcta detectada")

		label.text = ""
		input.hide()
		playerDetected = false
		input_active = false
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
	input.editable = false
