extends Marker2D

# Cactus to spawn
var cactus_scene = preload("res://cactus/cactus.tscn")

var spawn_time

# Called when the node enters the scene tree for the first time.
# Picks a random number to spawn the next cactus
func _ready():
	reset_timer()

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

func _on_cactus_exited():
	reset_timer()
