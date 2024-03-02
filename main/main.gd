extends Node

var farLeftMarkerXPosition = 0
var centerMarkerXPosition = 0
var centerMarkerYPosition = 0
var farRightMarkerXPosition = 0

func _ready():
	# Get all of our markers child nodes X position. (Additional Y for center)
	farLeftMarkerXPosition = $FarLeft.position.x
	centerMarkerXPosition = $Center.position.x
	centerMarkerYPosition = $Center.position.y
	farRightMarkerXPosition = $FarRight.position.x
	
	# Set inital player position from main
	$Player.position.y = centerMarkerYPosition
	$Player.position.x = centerMarkerYPosition
	
	# Set all marker position variables in player
	$Player.setMarkerPositions(farLeftMarkerXPosition, centerMarkerXPosition, farRightMarkerXPosition)
	
func _process(delta):
	pass
