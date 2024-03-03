extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.connect("health_changed", _on_health_changed)
	Globals.connect("score_changed", _on_score_changed)
	Globals.connect("time_left_changed", _on_time_left_changed)
	Globals.connect("game_restarted", _on_game_restarted)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_health_changed():
	$VBoxContainer/MarginContainer3/HeartsContainer/Heart.frame += 1

func _on_score_changed():
	$VBoxContainer/MarginContainer/ScoreLabel.text = str(Globals.score)

func _on_time_left_changed(time):
	$VBoxContainer/MarginContainer2/TimeLabel.text = str(time)

func _on_game_restarted():
	$VBoxContainer/MarginContainer3/HeartsContainer/Heart.frame = 0
