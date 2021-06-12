extends Node

var maps = [
	preload("res://worlds/1/level.tscn"),
	preload("res://worlds/2/level.tscn"),
	preload("res://worlds/3/level.tscn"),
	preload("res://worlds/4/level.tscn"),
]

var hub = preload("res://worlds/hub/hub.tscn")

var currentWeapon = 1
var currentLevel = 0
var player

func _ready():
	pass
	
func _input(event):
	if event.is_action_pressed("reset"):
		SwitchSzene.reset()
		self.currentWeapon = 1
		self.currentLevel = 0
		get_tree().change_scene_to(hub)

func pickUpNextWeapon():
	SwitchSzene.playPickUpWeapon()
	currentWeapon = currentWeapon + 1
	currentLevel = currentLevel + 1
	player.equipWeapon()

func switchToLevel():
	SwitchSzene.playGoToLevel()
	get_tree().change_scene_to(maps[currentLevel])

func switchToHub():
	SwitchSzene.playGoToLevel()
	get_tree().change_scene_to(hub)
	
func switchToGameEnd():
	SwitchSzene.playCredits()
