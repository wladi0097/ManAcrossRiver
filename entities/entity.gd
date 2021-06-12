extends Node
class_name Entity

func _ready():
	pass # Replace with function body.
	
func die():
	self.queue_free()
