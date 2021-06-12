extends Entity

func _ready():
	$AnimationPlayer.play("laugh")
	
func die():
	$AnimatedSprite.visible = false
	$Sprite.visible = false
	$CPUParticles2D.emitting = true
	Global.switchToGameEnd()
