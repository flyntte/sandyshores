extends Marker2D

# Cactus to spawn
var cactus_scene = preload("res://cactus/cactus.tscn")

var spawn_time
var can_spawn = true

# Called when the node enters the scene tree for the first time.
# Picks a random number to spawn the next cactus
func _ready():
	reset_timer()
	Globals.connect("game_over", _on_game_over)
	Globals.connect("game_restarted", _on_game_restarted)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawn():
	var new_spawn = cactus_scene.instantiate()
	new_spawn.connect("cactus_exited", _on_cactus_exited)
	add_child(new_spawn)

func _on_spawn_time_timeout():
	spawn()
	$SpawnTime.stop()

func reset_timer():
	spawn_time = randf_range(0.1, 2.0)
	$SpawnTime.wait_time = spawn_time
	$SpawnTime.start()

func stop_spawner():
	can_spawn = false
	$SpawnTime.stop()

func _on_cactus_exited():
	if can_spawn:
		reset_timer()

func _on_game_over(score, time):
	stop_spawner()

func _on_game_restarted():
	can_spawn = true
	reset_timer()
