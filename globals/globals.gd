extends Node


var farLeftMarkerXPosition = 32
var centerMarkerXPosition = 128
var centerMarkerYPosition = 131
var farRightMarkerXPosition = 224

# Player Current State
var playerState = STATE.FISHING

func setPlayerState(state):
	playerState = state

# Player States
const STATE = {
	IDLE = "idle",
	FISHING = "fishing"
}
