extends Area2D

signal cactus_exited
var speed

# Called when the node enters the scene tree for the first time.
func _ready():
	speed = randf_range(0.2, 0.5)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y += speed

func _on_visible_on_screen_notifier_2d_screen_exited():
	cactus_exited.emit()
	queue_free()
