extends Camera2D
var speed = 4000 # SPEED OF ROTATION
var time = 0 # CODED TIMER
var frame: int = 0 # COOLDOWN REUSING OLD VAR
var x = 1 # WALL SELECTION
var room = 0
var roomcode = 0
var antagPos = [-1, -1, -1, -1] # storing 4 antags Catber, Neuro, Evil, Slugber
var Lastcam = 1
var Id :String= "0"
@onready var c_1 = $"../Rooms/C1"
@onready var c_2 = $"../Rooms/C2"

func _on_left_mouse_entered():
	if Global.scene == 1:
		if frame == 0:
			x = x-1
			if x<0:
				x=0
			time = 1

func _on_right_mouse_entered():
	if Global.scene == 1:
		if frame == 0:
			x += 1
			if x>2:
				x=2
			time = 1

func _on_cam_trigger_mouse_shape_entered(shape_idx):
	if Global.scene == 1:
		if frame ==0:
			room = Lastcam


func _process(delta):
	if Global.scene == 1:
		frame = int(time) % 2
		# MOVEMENTS
		if room == 0:
			%Rooms.animation = "0"
			c_1.hide()
			c_2.hide()
			if x == 0: # Left
				position = position.move_toward(Vector2(-2000, 0), delta * speed)
			elif x == 1: # Center
				position = position.move_toward(Vector2(0, 0), delta * speed)
			elif x == 2: # Right
				position = position.move_toward(Vector2(2000, 0), delta * speed)
			
			# COOLDOWN TIMER ON MOVEMENT
		if frame != 0:
			time += delta*1.5
		
		if room != 0:                              #room id creation
			c_1.show()
			c_2.show()
			roomcode = room
			for i in antagPos:
				if antagPos[i] == room:
					roomcode = roomcode + (10 ** (i + 2))
			Id= str(roomcode)
			%Rooms.animation = Id
	else:
		%Rooms.animation = "title"





func _on_c_1_pressed():
	if room != 0:
		room = 1


func _on_c_2_pressed():
	if room != 0:
		room = 2

