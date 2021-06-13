extends KinematicBody2D


export var tryToReachManAcrossRiver: bool = false
var moveSpeed := 200
var swordSpeed := 0.1
var swordSpeeds = [0.1, 0.07, 0.05, 0.03, 0.01]
var canMove = true
var ready = false
onready var playerSprite := $Player
onready var eeGameCompleted := $EEGameCompleted
onready var eeBerserk := $EEBerserk
onready var Sword := $Sword
onready var animationPlayer := $AnimationPlayer

func _ready():
	Global.player = self
	self.equipWeapon()
	self.drawEasterEggs()
	
	if tryToReachManAcrossRiver:
		canMove = false
		self.reachToGameTransition()

func _physics_process(delta):
	if hasLastWeapon():
		self.mouseMovement()
	if !canMove:
		return
	
	self.movement(delta)
	self.mouseMovement()
	
func drawEasterEggs():
	print(Global.hasGriffithMonolith)
	eeGameCompleted.visible = Global.hasGameCompleted
	eeBerserk.visible = Global.hasGriffithMonolith
	
func hasLastWeapon():
	return Global.currentWeapon == 5
		
func reachToGameTransition():
	if hasLastWeapon():
		self.rotation = PI * 2
		return
	
	$AnimationPlayer.play("reach")
	tryToReachManAcrossRiver = false
	yield(get_tree().create_timer(1), "timeout")
	move_and_slide(Vector2(2000, 0))
	canMove = true
	pass
	
func equipWeapon():
	var weapon = Global.currentWeapon
	swordSpeed = swordSpeeds[weapon - 1]
	$swordCollision.replace_by(get_node("Swords/" + String(weapon) + "/swordCollision").duplicate())
	$sword.replace_by(get_node("Swords/" + String(weapon) + "/sword").duplicate())
	$SwordDetection/swordDetectionCollision.replace_by(get_node("Swords/" + String(weapon) + "/swordDetectionCollision").duplicate())

func movement(delta):
	var motion = Vector2()
	
	if Input.is_action_pressed("up"):
		motion.y -= 1
	if Input.is_action_pressed("right"):
		motion.x += 1
	if Input.is_action_pressed("down"):
		motion.y += 1
	if Input.is_action_pressed("left"):
		motion.x -= 1
		
	var movementHappend = motion.x != 0 || motion.y != 0;
#
	if movementHappend:
		tryToReachManAcrossRiver = false
		animationPlayer.play("walk")
	else:
		animationPlayer.stop()
		
	self.move_and_slide(motion * self.moveSpeed)

	
func mouseMovement():
	var newRotation = lerp_angle(self.rotation, get_global_mouse_position().angle_to_point(self.position), self.swordSpeed)
	var shouldFlip = get_global_mouse_position().x < self.global_position.x
	
	playerSprite.set_flip_v(shouldFlip)
	eeGameCompleted.set_flip_v(shouldFlip)
	eeBerserk.set_flip_v(!shouldFlip)
	eeBerserk.offset = Vector2(0,0) if shouldFlip else Vector2(0, 15)
	self.rotation = newRotation
	
func _on_SwordDetection_body_entered(body):
	body.die()


func _on_PlayerAttacked_body_entered(body):
	get_tree().reload_current_scene()
