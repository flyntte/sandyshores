extends Node

var farLeftMarkerXPosition = 32
var centerMarkerXPosition = 128
var centerMarkerYPosition = 131
var farRightMarkerXPosition = 224

# Player Current State
var playerState = STATE.FISHING

# Timer Constant

const TIMERS = {
	timeLeftToFish =  5,
	inGameTimer = 0
}

func setPlayerState(state):
	playerState = state

# Player Global Variables
var lives = 3
var score = 0

var timeLeftToFish = TIMERS.timeLeftToFish
var inGameTimer = TIMERS.inGameTimer

# Player States
const STATE = {
	IDLE = "idle",
	FISHING = "fishing"
}

func _ready():
	print(lives)

func _process(delta):
	if lives == 0:
		reset()
		print("GAME OVER")
	
func _on_in_game_timer_timeout():
	inGameTimer += 1
	
func _on_time_left_to_fish_timeout():
	if timeLeftToFish == 0:
		setPlayerHealth(-1)
		timeLeftToFish = TIMERS.timeLeftToFish
		return
		
	timeLeftToFish -= 1
	print("Time Left: " + str(timeLeftToFish))
	
func reset():
	timeLeftToFish = TIMERS.timeLeftToFish
	inGameTimer = TIMERS.inGameTimer
	score = 0
	lives = 3
	
	$InGameTimer.stop()
	$TimeLeftToFish.stop()

func setPlayerHealth(value):
	lives += value
	print(lives)
