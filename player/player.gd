extends Area2D

signal fishing_minigame_started

# Represents that we are in the center marker
var currentPosition = 2

var current_possible_fish

var can_move = true

func _ready():
	position.x = Globals.centerMarkerXPosition
	position.y = Globals.centerMarkerYPosition
	Globals.connect("game_over", _on_game_over)
	Globals.connect("game_restarted", _on_game_restarted)

func _process(delta):
	if Input.is_action_just_pressed("move_left") and Globals.playerState == Globals.STATE.IDLE and can_move:
		if currentPosition == 1:
			pass
		else:
			setCurrentPosition(-1)
			
	if Input.is_action_just_pressed("move_right") and Globals.playerState == Globals.STATE.IDLE and can_move:
		if currentPosition == 3:
			pass
		else:
			setCurrentPosition(1)
				
	if Input.is_action_just_pressed("fish") and Globals.playerState == Globals.STATE.IDLE and current_possible_fish != null and can_move:
		print("Fishing...")
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
	if current_possible_fish != null and Globals.playerState == Globals.STATE.IDLE:
		current_possible_fish.stop()
		fishing_minigame_started.emit()

func delete_cactus():
	if current_possible_fish != null:
		current_possible_fish.queue_free()
		current_possible_fish = null

func _on_area_entered(area):
	if area.name == "Cactus":
		current_possible_fish = area
		
func _on_area_exited(area):
	if area.name == "Cactus":
		current_possible_fish = null

func _on_game_over(score, time):
	can_move = false

func _on_game_restarted():
	can_move = true
	position.x = Globals.centerMarkerXPosition
	position.y = Globals.centerMarkerYPosition
