extends Area2D

signal fishing_minigame_started

# Represents that we are in the center marker
var currentPosition = 2

var can_fish = false
var current_possible_fish

var can_move = true

func _ready():
	position.x = Globals.centerMarkerXPosition
	position.y = Globals.centerMarkerYPosition

func _process(delta):
	if Input.is_action_just_pressed("move_left") and can_move:
		if currentPosition == 1:
			print("Can't move further to the left ")
		else:
			setCurrentPosition(-1)
			
	if Input.is_action_just_pressed("move_right") and can_move:
		if currentPosition == 3:
			print("Can't move further to the right ")
		else:
			setCurrentPosition(1)
	if Input.is_action_just_pressed("fish") and !can_fish:
		Globals.setPlayerState(Globals.STATE.FISHING)
	elif Input.is_action_just_pressed("fish") and can_fish:
		start_fishing_minigame()

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

func start_fishing_minigame():
	print("Player started fishing minigame")
	if current_possible_fish != null:
		current_possible_fish.stop()
		can_move = false
		can_fish = false
		fishing_minigame_started.emit()

func delete_cactus():
	current_possible_fish.queue_free()

func _on_area_entered(area):
	if area.name == "Cactus":
		can_fish = true
		current_possible_fish = area
		print("can fish")
