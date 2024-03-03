extends Node

func _ready():
	$Overview/Player.connect("fishing_minigame_started", _on_fishing_minigame_started)
	$FishingBar.connect("fishing_minigame_ended", _on_fishing_minigame_ended)
func _process(delta):
	pass

func _on_fishing_minigame_started():
	$FishingBar.showHitmark()
	Globals.setPlayerState(Globals.STATE.FISHING)

func _on_fishing_minigame_ended(catched):
	# Catched determines if the player caught or didn't caught the cactus
	# Catched is coming from fishing_bar.gd (fishing_minigame_ended.emit())
	
	$FishingBar.hideHitmark()
	$Overview/Player.delete_cactus()
	Globals.setPlayerState(Globals.STATE.IDLE)
	Globals.setPlayerStats(catched)
