extends Node2D

signal fishing_minigame_ended

# Hit mark Y min and max range
const MIN_Y_RANGE = 50
const MAX_Y_RANGE = 100

# Hook speed height and speed limit
const HOOK_SPEED = 0.5
const HOOK_LIMIT = 142

# Y - Position that hook will always start
const INITIAL_HOOK_Y_POSITION = 20

var HIT_MARK_RANDOM_Y_POSITION = randi_range(MIN_Y_RANGE, MAX_Y_RANGE)

var inHitMark = false

func _ready():
	$Hitmark.position.y = HIT_MARK_RANDOM_Y_POSITION
	$Hook.position.y = INITIAL_HOOK_Y_POSITION
	hideHitmark()

func _process(delta):
	if $Hook.position.y == HOOK_LIMIT:
		resetHook()
		fishing_minigame_ended.emit(false)
	if Globals.playerState == Globals.STATE.FISHING:
		$Hook.position.y += HOOK_SPEED
	if inHitMark:
		if Input.is_action_just_pressed("fish"):
			resetHook()
			fishing_minigame_ended.emit(true)
	if Globals.playerState == Globals.STATE.FISHING:
		if Input.is_action_just_pressed("fish") and !inHitMark:
			resetHook()
			fishing_minigame_ended.emit(false)

func _on_hitmark_area_entered(area):
	if area.name == "Hook":
		inHitMark = true
		
func _on_hitmark_area_exited(area):
	if area.name == "Hook":
		inHitMark = false

func showHitmark():
	$Hitmark.visible = true

func hideHitmark():
	$Hitmark.visible = false

func resetHook():
	inHitMark = false
	$Hook.position.y = INITIAL_HOOK_Y_POSITION
	$Hitmark.position.y = randi_range(MIN_Y_RANGE, MAX_Y_RANGE)
