extends CharacterBody2D

const SPEED = 360.0
const ACCEL = 8.0

#Inventory
var INVENTORY = []
const INVENTORY_SPACE = 3

var input: Vector2

# ATTACKED STATUS
var ATTACKED = false

# FlashLight Battery
const max_power = 8.0
var power = max_power
var lightIsOn = false
@onready var light: PointLight2D = $Marker2D/Light/TextureLight

# Interactions Label
@onready var all_interactions = []
@onready var interaction_label = $InteractionComponents/Label

# Vampire Text ATTACK
@export var answer_field: LineEdit
@export var question_field: Label

var current_vampire: Node = null

var PRIORITY = {
	"VampAttack": 3,
	"Door": 2,
	"Item": 1,
	"none": 0
}

func _ready():
	answer_field.connect("text_submitted", Callable(self, "_on_ResponseInput_text_submitted"))

	
func get_input():
	input.x = Input.get_action_strength("Move right") - Input.get_action_strength("Move left")
	input.y = Input.get_action_strength("Move down") - Input.get_action_strength("Move up")
	if !ATTACKED:
		return input.normalized()
	else:
		return Vector2(0, 0)
	
func _process(delta):
	var playerInput = get_input()
	velocity = lerp(velocity, playerInput * SPEED, delta * ACCEL)
	move_and_slide()

	# Ver interacciones
	update_interactions()
	
	# See flashlight
	update_light(delta)
	
	if Input.is_action_just_pressed("FlashLight"):
		lightIsOn = !lightIsOn
		
	if all_interactions and Input.is_action_just_pressed("Interact"):
		handle_interaction(all_interactions[0])

func update_light(delta):
	print(power)
	if lightIsOn:
		power -= delta
	else:
		power += delta
		
	power = clamp(power, 0, max_power)
	
	if power > 0:
		if lightIsOn:
			light.show()
		else:
			light.hide()
	else:
		light.hide()
		lightIsOn = false
		
var needs_sort = false

func _on_player_interaction_area_entered(area: Area2D) -> void:
	if area is InteractArea and not all_interactions.has(area):
		all_interactions.append(area)
		needs_sort = true

func _on_player_interaction_area_exited(area: Area2D) -> void:
	if all_interactions.has(area):
		all_interactions.erase(area)
		needs_sort = true

func update_interactions() -> void:
	if needs_sort:
		all_interactions.sort_custom(Callable(self, "_compare_interactions"))
		needs_sort = false

	if all_interactions.size() > 0 and all_interactions[0] is InteractArea:
		var ia = all_interactions[0] as InteractArea
		interaction_label.text = ia.interact_value
	else:
		interaction_label.text = "Nothing"


func handle_interaction(area: Area2D) -> void:
	match area.interact_type:
		"VampAttack":
			var vamp = area.get_parent()
			current_vampire = vamp
			vamp.receive_interaction()

func _compare_interactions(a, b):
	var a_priority = PRIORITY.get(a.interact_type, 0)
	var b_priority = PRIORITY.get(b.interact_type, 0)
	return b_priority - a_priority  # Higher priority first
			
func _on_ResponseInput_text_submitted(text: String) -> void:
	if text.strip_edges().to_upper() == "NO" and current_vampire:
		current_vampire.cancel_attack()
		current_vampire = null  # ya no estás interactuando con ninguno
		hide_dialogue()
	else:
		question_field.text = "..."

func show_dialog(text: String) -> void:
	question_field.text = text
	question_field.show()

	answer_field.text = ""
	answer_field.editable = true
	answer_field.show()
	answer_field.grab_focus()

func hide_dialogue() -> void:
	question_field.text = ""
	question_field.hide()
	answer_field.text = ""
	answer_field.hide()
	
	
func game_over():
	hide_dialogue()
	print("oh shit nigga")
