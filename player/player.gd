extends Area2D

var currentPosition = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	position.x = getPosition(currentPosition)
	
func _process(delta):
	if Input.is_action_just_pressed("move_left"):
		if currentPosition == 1:
			print("Can't move further to the left ")
		else:
			currentPosition -= 1
			
	if Input.is_action_just_pressed("move_right"):
		if currentPosition == 3:
			print("Can't move further to the right ")
		else:
			currentPosition += 1
			
	setPosition(currentPosition)
	
func teleportPlayer(marker):
	if currentPosition ==  1:
		position = $FarLeft.position
	elif currentPosition == 2:
		position = $Center.position
	else:
		position = $FarRight.position

func getPosition(pos):
	# FarLeft = 1
	# Center = 2
	# FarRight = 3
	
	if currentPosition == 1:
		return $FarLeft.position.x
	if currentPosition == 2:
		return $Center.position.x
	if currentPosition == 3:
		return $FarRight.position.x

func setPosition(pos):
	position.x = getPosition(pos)
