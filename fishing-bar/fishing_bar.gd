extends Node2D

# Hit mark Y min and max range
const MIN_Y_RANGE = 50
const MAX_Y_RANGE = 130

# Hook speed height and speed limit
const HOOK_SPEED = 0.5
const HOOK_LIMIT = 142

# Y - Position that hook will always start
const INITIAL_HOOK_Y_POSITION = 20

# 
var HIT_MARK_RANDOM_Y_POSITION = randi_range(MIN_Y_RANGE, MAX_Y_RANGE)

var inHitMark = false
var catched = false

var timerStarted = false

func _ready():
	$Hitmark.position.y = HIT_MARK_RANDOM_Y_POSITION
	$Hook.position.y = INITIAL_HOOK_Y_POSITION

func _process(delta):
	if $Hook.position.y == HOOK_LIMIT:
		pass
	else:
		if catched == false:
			$Hook.position.y += HOOK_SPEED
	if inHitMark:
		if Input.is_action_just_pressed("fish"):
			
			# TODO: REMOVE 1 PLAYER HEALTH IF SPACE WAS PRESSED BUT NOT
			# INSIDE THE HITMARK
			
			catched = true
			if not timerStarted:
				$Timer.start()
				timerStarted = true

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
	$Hitmark.position.y = randi_range(MIN_Y_RANGE, MAX_Y_RANGE)

func _on_timer_timeout():
	timerStarted = false
	resetHook()
