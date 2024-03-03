extends Node

signal game_over
signal game_restarted

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

func _process(delta):
	if lives == 0:
		#game_over.emit()
		#resetGame()
		#print("GAME OVER")
		pass
func _on_in_game_timer_timeout():
	inGameTimer += 1
	
func _on_time_left_to_fish_timeout():
	if timeLeftToFish == 0:
		setPlayerHealth(-1)
		checkLives()
		timeLeftToFish = TIMERS.timeLeftToFish
		return
		
	timeLeftToFish -= 1
	print("Time Left: " + str(timeLeftToFish))
	#print("Player lives left: " + str(lives))
	
func resetGame():
	timeLeftToFish = TIMERS.timeLeftToFish
	inGameTimer = TIMERS.inGameTimer
	score = 0
	lives = 3
	$InGameTimer.start()
	$TimeLeftToFish.start()
	game_restarted.emit()

func setPlayerHealth(value):
	lives += value
	
func setPlayerScore(value):
	score += value
	print("Score" + str(score))
	
func setInGameTimer(value):
	inGameTimer = value
	
func setTimeLeftToFish(value):
	timeLeftToFish = value
	
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

func _on_game_over(lives, score):
	$InGameTimer.stop()
	$TimeLeftToFish.stop()
	print("GAME OVER")
