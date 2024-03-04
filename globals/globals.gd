extends Node

signal game_over
signal game_restarted
signal health_changed
signal score_changed
signal time_left_changed

var farLeftMarkerXPosition = 32
var centerMarkerXPosition = 128
var centerMarkerYPosition = 131
var farRightMarkerXPosition = 224

# Player Current State
var playerState = STATE.IDLE

# Timer Constant

const TIMERS = {
	timeLeftToFish =  10,
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
	connect("game_over", _on_game_over)
	#connect("health_changed", _on_health_changed)
	#connect("score_changed", _on_score_changed)

func _process(delta):
	#if lives == 0:
		##game_over.emit()
		##resetGame()
		##print("GAME OVER")
		pass
func _on_in_game_timer_timeout():
	inGameTimer += 1
	
func _on_time_left_to_fish_timeout():
	if timeLeftToFish == 0:
		setPlayerHealth(-1)
		checkLives()
		timeLeftToFish = TIMERS.timeLeftToFish
		time_left_changed.emit(timeLeftToFish)
		return
		
	timeLeftToFish -= 1
	time_left_changed.emit(timeLeftToFish)
	#print("Player lives left: " + str(lives))
	
func stopTimeLeftToFish():
	$TimeLeftToFish.stop()
	
func startTimeLeftToFish():
	$TimeLeftToFish.start()

	
func resetGame():
	timeLeftToFish = TIMERS.timeLeftToFish
	inGameTimer = TIMERS.inGameTimer
	score = 0
	lives = 3
	health_changed.emit()
	$InGameTimer.start()
	$TimeLeftToFish.start()
	health_changed.emit()
	score_changed.emit()
	time_left_changed.emit(timeLeftToFish)
	game_restarted.emit()

func setPlayerHealth(value):
	lives += value
	health_changed.emit()
	
func setPlayerScore(value):
	score += value
	score_changed.emit()
	
func setInGameTimer(value):
	inGameTimer = value
	
func setTimeLeftToFish(value):
	timeLeftToFish = value
	time_left_changed.emit(timeLeftToFish)
	
func setPlayerStats(catched):
	# if catched equals true then we must add one to the player score
	# else if catched equals false then we must remove one live from player
	# but leave the score as is
	
	if catched:
		setPlayerScore(1)
	else:
		setPlayerHealth(-1)
		checkLives()
		
	print("Lives left: " + str(lives))
	
	resetTimers()
	
func resetTimers():
	$InGameTimer.wait_time = 1
	$TimeLeftToFish.wait_time = 1
	
	setTimeLeftToFish(TIMERS.timeLeftToFish)

func checkLives():
	if lives == 0:
		game_over.emit(score, inGameTimer)

#func _on_health_changed():
	#pass
	#
#func _on_score_changed():
	#pass

func _on_game_over(lives, score):
	$InGameTimer.stop()
	$TimeLeftToFish.stop()
	print("GAME OVER")
