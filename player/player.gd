extends Area2D

signal fishing_minigame_started

# Represents that we are in the center marker
var currentPosition = 2

var current_possible_fish

func _ready():
	position.x = Globals.centerMarkerXPosition
	position.y = Globals.centerMarkerYPosition

func _process(delta):
	if Input.is_action_just_pressed("move_left") and Globals.playerState == Globals.STATE.IDLE:
		if currentPosition == 1:
			pass
		else:
			setCurrentPosition(-1)
			
	if Input.is_action_just_pressed("move_right") and Globals.playerState == Globals.STATE.IDLE:
		if currentPosition == 3:
			pass
		else:
			setCurrentPosition(1)
				
	if Input.is_action_just_pressed("fish") and Globals.playerState == Globals.STATE.IDLE and current_possible_fish != null:
		print("Fishing...")
		Globals.setPlayerState(Globals.STATE.FISHING)
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
	if current_possible_fish != null and Globals.playerState == Globals.STATE.FISHING:
		current_possible_fish.stop()
		fishing_minigame_started.emit()

func delete_cactus():
	current_possible_fish.queue_free()
	current_possible_fish = null

func _on_area_entered(area):
	if area.name == "Cactus":
		current_possible_fish = area
		
func _on_area_exited(area):
	if area.name == "Cactus":
		current_possible_fish = null
