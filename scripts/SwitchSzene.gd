extends CanvasLayer

onready var animationPLayer = $AnimationPlayer
onready var control = $Control

func _ready():
	pass
	
func reset():
	$Timer.reset()
	control.hide()
	$AnimatedSprite.hide()
	$GameEnd.hide()

func playGoToLevel():
	animationPLayer.play("fade")
	yield(animationPLayer, "animation_finished")
	
func playPickUpWeapon():
	animationPLayer.play("tape")
	yield(animationPLayer, "animation_finished")
	

func playCredits():
	var ourScores = """
* TheRealWlad: 02:22:2   * Lichstars: 01:51:7
* Vlad: 02:23:2
"""
	
	$GameEnd/VBoxContainer/ScoreBoard.text = "** You: " + $Timer.stopAndGetTime() + " **" + ourScores
	
	yield(get_tree().create_timer(1), "timeout")
	animationPLayer.play("credits")
