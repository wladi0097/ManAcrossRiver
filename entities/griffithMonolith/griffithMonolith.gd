extends Entity


func die():
	Global.hasGriffithMonolith = true
	Global.redrawPlayerEasterEggs()
	self.queue_free()
