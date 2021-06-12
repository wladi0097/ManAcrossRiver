extends Node2D
class_name WorldWithSword

func _ready():
	pass


func _on_Exit_body_entered(body):
	Global.switchToHub()


func _on_Sword_body_entered(body):
	Global.pickUpNextWeapon()
	$Sword.queue_free()
