extends Camera2D
var speed = 4000 #SPEED OF ROTATION
var time = 0 #CODED TIMER
var frame :int= 0 #COOLDOWN REUSING OLD VAR
var x = 0 #WALL SELECTION
var mouse :int= get_global_mouse_position().x     #gets X coord of mouse
func _process(delta):
	if Global.scene == 1:
		mouse = get_global_mouse_position().x   
		frame = int(time)%2
		if(frame==0): #CHECKS IF OFF COOLDOWN
		#CHECKS IF GOES TO LEFT ROOM
			if (mouse < -315):
				if (mouse>-350):
					x = 1
					time = time+1
		#CHECK IF GOES TO RIGHT ROOM
			if (mouse < 700):
				if (mouse > 660):
					x = 2
					time = time+1
		#CHECKS IF GOES TO CENTRE
		if (mouse<-567):
			if(mouse>-600):
				x= 0
				time = time+1
		if (mouse<950):
			if(mouse>910):
				x= 0
				time = time+1
	#MOVEMENTS
	if (x == 1): #Left
		position = position.move_toward(Vector2(-1000,-65),delta * speed)
	if (x == 0): #centre
		position = position.move_toward(Vector2(182,-65),delta * speed)
	if (x==2): #Right
		position = position.move_toward(Vector2(1364,-65), delta * speed)
	#COOLDOWN TIMER ON MOVEMENT
	if (frame != 0):
		time = time+delta
