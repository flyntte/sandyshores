extends Area2D

# Represents that we are in the center marker
var currentPosition = 2

func _ready():
	position.x = Globals.centerMarkerXPosition
	position.y = Globals.centerMarkerYPosition

func _process(delta):
	if Input.is_action_just_pressed("move_left"):
		if currentPosition == 1:
			print("Can't move further to the left ")
		else:
			setCurrentPosition(-1)
			
	if Input.is_action_just_pressed("move_right"):
		if currentPosition == 3:
			print("Can't move further to the right ")
		else:
			setCurrentPosition(1)

func setCurrentPosition(value):
	currentPosition += value
	
	# 1 = Far Left
	# 2 = Center
	# 3 = Far Right
	if currentPosition == 1:
		position.x = Globals.farLeftMarkerXPosition
	if currentPosition == 2:
		position.x = Globals.centerMarkerXPosition
	if currentPosition == 3:
		position.x = Globals.farRightMarkerXPosition
