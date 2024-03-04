extends Node2D

signal fishing_minigame_ended

# Hit mark Y min and max range
const MIN_Y_RANGE = 50
const MAX_Y_RANGE = 100

# Hook speed height and speed limit
var hook_speed = 0.5
const HOOK_LIMIT = 142

# Y - Position that hook will always start
const INITIAL_HOOK_Y_POSITION = 20

var HIT_MARK_RANDOM_Y_POSITION = randi_range(MIN_Y_RANGE, MAX_Y_RANGE)

var inHitMark = false

func _ready():
	Globals.connect("score_changed", _on_score_changed)
	Globals.connect("game_restarted", _on_game_restarted)
	$Hitmark.position.y = HIT_MARK_RANDOM_Y_POSITION
	$Hook.position.y = INITIAL_HOOK_Y_POSITION
	hideHitmark()

func _process(delta):
	if $Hook.position.y == HOOK_LIMIT:
		$AudioFail.play()
		resetHook()
		fishing_minigame_ended.emit(false)
	if Globals.playerState == Globals.STATE.FISHING:
		$Hook.position.y += hook_speed
	if inHitMark:
		if Input.is_action_just_pressed("fish"):
			resetHook()
			$AudioCatch.play()
			fishing_minigame_ended.emit(true)
	if Globals.playerState == Globals.STATE.FISHING:
		if Input.is_action_just_pressed("fish") and !inHitMark:
			resetHook()
			$AudioFail.play()
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

func _on_score_changed():
	if Globals.score == 5:
		hook_speed += 0.2
	if Globals.score == 10:
		hook_speed += 0.3
	if Globals.score == 15:
		hook_speed += 0.2
	if Globals.score == 20:
		hook_speed += 0.2
		
func _on_game_restarted():
	hook_speed = 0.5
