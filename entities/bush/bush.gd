extends Entity


func _ready():
	pass

func die():
	$CollisionShape2D.queue_free()
	$Sprite.queue_free()
	$CPUParticles2D.emitting = true
	yield(get_tree().create_timer(.2), "timeout")
	queue_free()
