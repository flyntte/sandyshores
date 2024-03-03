extends Node2D

const HOOK_SPEED = 0.5
const HOOK_LIMIT = 201
const INITIAL_HOOK_Y_POSITION = 80
var HIT_MARK_RANDOM_Y_POSITION = randi_range(90, 150)
var inHitMark = false
var catched = false

func _ready():
	$Hitmark.position.y = HIT_MARK_RANDOM_Y_POSITION

func _process(delta):
	if $Hook.position.y == HOOK_LIMIT:
		pass
	else:
		if catched == false:
			$Hook.position.y += HOOK_SPEED
	if inHitMark:
		if Input.is_action_just_pressed("fish"):
			catched = true
			$Timer.start()

func _on_hitmark_area_entered(area):
	if area.name == "Hook":
		inHitMark = true
		
func _on_hitmark_area_exited(area):
	if area.name == "Hook":
		inHitMark = false

func resetHook():
	inHitMark = false
	catched = false
	$Hook.position.y = INITIAL_HOOK_Y_POSITION
	$Hitmark.position.y = randi_range(90, 150)

func _on_timer_timeout():
	resetHook()
