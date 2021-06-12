extends Control

onready var label := $Label
onready var timer := $Timer
var timerRunning = false

var ms = 0
var s = 0
var m = 0

func _ready():
	pass
	
func _input(event):
	if event.is_action_released("timer"):
		self.visible = !self.visible
		
	if !timerRunning:
		timer.start()
		timerRunning = true


func _process(delta):
	
	if ms > 9:
		s += 1
		ms = 0
	
	if s > 59:
		m += 1
		s = 0
		
	label.text = cleanTimeString(m)+":"+cleanTimeString(s)+":"+str(ms)
	
func cleanTimeString(time):
	return "0" + str(time) if time < 10 else str(time)
	
func stopAndGetTime():
	timer.stop();
	return label.text
	
func reset():
	timer.stop()
	ms = 0
	s = 0
	m = 0
	timerRunning = false
	

func _on_Timer_timeout():
	ms += 1
