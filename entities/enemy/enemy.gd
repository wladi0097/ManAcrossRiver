extends Entity

func _ready():
	$AnimationPlayer.play("laugh")
	
func die():
	$CollisionShape2D.queue_free()
	$AnimatedSprite.visible = false
	$Sprite.visible = false
	$CPUParticles2D.emitting = true
	Global.switchToGameEnd()
