extends Camera2D

var speed = 4000 # SPEED OF ROTATION
var time = 0 # CODED TIMER
var frame: int = 0 # COOLDOWN REUSING OLD VAR
var x = 0 # WALL SELECTION
var room = 0
var roomcode = 0
var antagPos = [-1, -1, -1, -1] # storing 4 antags Catber, Neuro, Evil, Slugber

func _on_left_mouse_entered():
	x = 1
	time = 0

func _on_center_mouse_entered():
	x = 0
	time = 0

func _on_right_mouse_entered():
	x = 2
	time = 0

func _process(delta):
	if Global.scene == 1:
		frame = int(time) % 2
		if frame == 0: # CHECKS IF OFF COOLDOWN
			# MOVEMENTS
			if x == 1: # Left
				position = position.move_toward(Vector2(-2000, 0), delta * speed)
			elif x == 0: # Center
				position = position.move_toward(Vector2(0, 0), delta * speed)
			elif x == 2: # Right
				position = position.move_toward(Vector2(2000, 0), delta * speed)
				
			# COOLDOWN TIMER ON MOVEMENT
			if frame != 0:
				time += delta
		else:
			for i in range(antagPos.size()):
				if antagPos[i] == room:
					roomcode = roomcode + (10 ** (i + 2))
