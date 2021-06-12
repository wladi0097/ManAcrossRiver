extends CanvasLayer

onready var animationPLayer = $AnimationPlayer
onready var control = $Control

func _ready():
	pass
	
func reset():
	$Timer.reset()
	animationPLayer.play_backwards("credits")

func playGoToLevel():
	animationPLayer.play("fade")
	yield(animationPLayer, "animation_finished")
	
func playPickUpWeapon():
	animationPLayer.play("tape")
	yield(animationPLayer, "animation_finished")
	

func playCredits():
	var ourScores = """
* TheRealWlad: 02:22:2
* Lichstart: N/A
* Vlad: N/A
"""
	
	$GameEnd/VBoxContainer/ScoreBoard.text = "* You: " + $Timer.stopAndGetTime() + ourScores
	
	yield(get_tree().create_timer(1), "timeout")
	animationPLayer.play("credits")
