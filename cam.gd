extends Camera2D

var speed = 4000 # SPEED OF ROTATION
var time = 0 # CODED TIMER
var frame: int = 0 # COOLDOWN REUSING OLD VAR
var x = 1 # WALL SELECTION
var room = 0
var roomcode = 0
var antagPos = [-1, -1, -1, -1] # storing 4 antags Catber, Neuro, Evil, Slugber
var Lastcam = 1
var Id: String = "0"
@onready var c_1 = $"../Rooms/C1"
@onready var c_2 = $"../Rooms/C2"
@onready var rooms = $"../Rooms"
@onready var color_rect = $"../ColorRect2"
var input_text := ""
var devinput := ""
var key_sequence := ["UP", "UP", "DOWN", "DOWN", "LEFT", "RIGHT", "LEFT", "RIGHT", "B", "A"]
var current_index = 0

func _ready():
	Global.connect("resetgame", Callable(self, "_game_reset"))
	Global.scene = 8

func _process(delta):
	if Global.scene == 0:
		c_1.hide()
		c_2.hide()
		rooms.hide()
	if Global.scene == 1:
		frame = int(time) % 2
		if room == 0:
			%Rooms.animation = "0"
			c_1.hide()
			c_2.hide()
			rooms.hide()
			if x == 0: # Left
				position = position.move_toward(Vector2(-2000, 0), delta * speed)
			elif x == 1: # Center
				position = position.move_toward(Vector2(0, 0), delta * speed)
			elif x == 2: # Right
				position = position.move_toward(Vector2(2000, 0), delta * speed)
		if frame != 0:
			time += delta * 1.5
		if room != 0:
			c_1.show()
			c_2.show()
			rooms.show()
			roomcode = room
			for i in range(antagPos.size()):
				if antagPos[i] == room:
					roomcode = roomcode + (10 ** (i + 2))
			Id = str(roomcode)
			%Rooms.animation = Id
	else:
		%Rooms.animation = "title"

func _game_reset():
	print("camera reset")
	position = Vector2(0, 0)
	if Global.currentam != 8:
		Global.scene = 0
	Global.power = 100
	Global.inlaptop = false
	speed = 4000 # SPEED OF ROTATION
	time = 0 # CODED TIMER
	frame = 0 # COOLDOWN REUSING OLD VAR
	x = 1 # WALL SELECTION
	room = 0
	roomcode = 0
	antagPos = [-1, -1, -1, -1] # storing 4 antags Catber, Neuro, Evil, Slugber
	Lastcam = 1
	Id = "0"
	input_text = ""
	Global.CharPositons = [0, 1, 0, 0, 2]
	Global.currentcam = -1
	c_1.hide()
	c_2.hide()
	rooms.hide()

func _input(event):
	if event is InputEventKey:
		var key_event = event as InputEventKey
		if Global.scene != 0:
			if Input.is_key_pressed(KEY_ESCAPE):
				Global.reset()
				print("Switching to scene 0")
		if Global.shiftReality == false and Global.scene == 0:
			if not Input.is_key_pressed(KEY_SHIFT):
				input_text = ""
				print("Resetting input_text")
			if Input.is_key_pressed(KEY_SHIFT):
				if key_event.unicode != 0:
					input_text += str(key_event.unicode)
			if input_text == "82696576738489":
				print("Shift reality")
				Global.shiftReality = true
				input_text = "" 
		if Global.devmenuunlocked == false and Global.scene == 0:
			if key_event.pressed and not key_event.is_echo():
				var expected_key = key_sequence[current_index]
				if (expected_key == "UP" and key_event.keycode == KEY_UP) or (expected_key == "DOWN" and key_event.keycode == KEY_DOWN) or (expected_key == "LEFT" and key_event.keycode == KEY_LEFT) or (expected_key == "RIGHT" and key_event.keycode == KEY_RIGHT) or (expected_key == "B" and key_event.keycode == KEY_B) or (expected_key == "A" and key_event.keycode == KEY_A):
					print(key_sequence[current_index])
					current_index += 1
					if current_index >= key_sequence.size():
						print("Developer menu unlocked")
						Global.devmenuunlocked = true
						expected_key = key_sequence[0]
						current_index = 0
				else:
					print("Sequence Broken, reseting")
					expected_key = key_sequence[0]
					current_index = 0

func _on_cam_trigger_mouse_entered():
	if Id != "0":
		if frame == 0:
			room = 0
			Id = "0"
			$"cam pull up or put down".play()
	else:
		if Global.scene == 1:
			if frame == 0:
				room = Lastcam
				$"cam pull up or put down".play()

func _on_c_1_pressed():
	if room != 0:
		room = 1
		$"cam switch button".play()

func _on_c_2_pressed():
	if room != 0:
		room = 2
		$"cam switch button".play()
