extends Node2D

@export var player: NodePath
@export var ghost_scene: PackedScene
@export var horizontal_range: int
@export var vertical_range: int
var horizontal_pos: int
var vertical_pos: int

func _ready():
	var ghost_wait_time = randi_range(3, 10)
	var starting_horizontal_pos = self.global_position.x
	var starting_vertical_pos = self.global_position.y
	while (!Global.game_over):
		await get_tree().create_timer(ghost_wait_time).timeout
		horizontal_pos = randi_range(300, horizontal_range)
		horizontal_pos = randi_range(300, vertical_range)
		if Global.current_enemies < Global.enemy_budget:
			var ghost = ghost_scene.instantiate()
			var target = get_node(player)
			ghost.target = target
			ghost.global_position.x = target.global_position.x + horizontal_pos
			ghost.global_position.y = target.global_position.y + vertical_pos
			add_child(ghost)
