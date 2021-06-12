extends WorldWithSword

func _ready():
	pass 

func _on_Sword_body_entered_spawn_helpers(body):
	$Helper.visible = true
	pass
