extends Area2D

signal cactus_exited
var speed
var random_speed_range = randf_range(0.2, 0.5)

# Called when the node enters the scene tree for the first time.
func _ready():
	speed = random_speed_range
	Globals.connect("game_over", _on_game_over)
	Globals.connect("game_restarted", _on_game_restarted)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y += speed

func stop():
	speed = 0

func _on_visible_on_screen_notifier_2d_screen_exited():
	cactus_exited.emit()
	queue_free()

func _on_tree_exited():
	cactus_exited.emit()
	queue_free()

func _on_game_over(score, time):
	stop()

func _on_game_restarted():
	speed = random_speed_range
	queue_free()
