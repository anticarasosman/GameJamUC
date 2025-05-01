extends Node

@onready var ally_spawn_point_1 = $Ally_spawn_point
@onready var ally_spawn_point_2 = $Ally_spawn_point2
@onready var ally_spawn_point_3 = $Ally_spawn_point3
@onready var ally_spawn_point_4 = $Ally_spawn_point4

func _ready():
	var ally_wait_time = 1
	while (!Global.game_over):
		var ally_position = 4
		#var ally_position = randi_range(0, 3)
		print("ESPERAMOS: ", ally_wait_time, " SEGUNDOS")
		await get_tree().create_timer(ally_wait_time).timeout
		if ally_position == 0:
			ally_spawn_point_1.spawnAlly()
		elif ally_position == 1:
			ally_spawn_point_2.spawnAlly()
		elif ally_position == 2:
			ally_spawn_point_3.spawnAlly()
		elif ally_position == 3:
			ally_spawn_point_4.spawnAlly()
		ally_wait_time = randi_range(3, 10)
