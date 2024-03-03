extends Node

func _ready():
	$Overview/Player.connect("fishing_minigame_started", _on_fishing_minigame_started)
	$FishingBar.connect("fishing_minigame_ended", _on_fishing_minigame_ended)
func _process(delta):
	pass

func _on_fishing_minigame_started():
	$FishingBar.can_fall = true
	$FishingBar.showHitmark()

func _on_fishing_minigame_ended():
	$Overview/Player.can_move = true
	$Overview/Player.delete_cactus()
	$FishingBar.hideHitmark()
