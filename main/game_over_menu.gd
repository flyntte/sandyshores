extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.connect("game_over", _on_game_over)
	Globals.connect("game_restarted", _on_game_restarted)
	hide()

func _on_game_over(score, time):
	$ColorRect/VBoxContainer/HBoxContainer/ScoreLabel.text = "Score: " + str(score)
	$ColorRect/VBoxContainer/HBoxContainer/TimeLabel.text = "Played time: " + str(time)
	show()
	$ColorRect/VBoxContainer/TryAgainButton.grab_focus()

func _on_game_restarted():
	hide()
	$ColorRect/VBoxContainer/HBoxContainer/ScoreLabel.text = "Score:"
	$ColorRect/VBoxContainer/HBoxContainer/TimeLabel.text = "Played time: "

func _on_try_again_button_pressed():
	Globals.resetGame()
