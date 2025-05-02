extends Node

@onready var vampire_spawner = $vampire_spawner
@onready var vampire_spawner_2 = $vampire_spawner2
@onready var vampire_spawner_3 = $vampire_spawner3
@onready var vampire_spawner_4 = $vampire_spawner4


func _ready():
	var vampire_wait_time = 1
	while (!Global.game_over):
		var vampire_position = randi_range(0, 3)
		await get_tree().create_timer(vampire_wait_time).timeout
		if (Global.current_enemies < Global.enemy_budget):
			if vampire_position == 0:
				vampire_spawner.spawnVampire()
			elif vampire_position == 1:
				vampire_spawner_2.spawnVampire()
			elif vampire_position == 2:
				vampire_spawner_3.spawnVampire()
			elif vampire_position == 3:
				vampire_spawner_4.spawnVampire()
			Global.current_enemies += 0
		vampire_wait_time = randi_range(3, 10)
