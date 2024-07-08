extends Camera2D
var speed = 4000 #SPEED OF ROTATION
var time = 0 #CODED TIMER
var frame :int= 0 #COOLDOWN REUSING OLD VAR
var x = 0 #WALL SELECTION
var mouse :int= get_global_mouse_position().x     #gets X coord of mouse
var room = 0
var roomcode = 0
var antagPos = [-1,-1,-1,-1] # storing 4 antags Catber, Neuro , Evil ,Slugber
func _process(delta):
	if (Global.scene == 1):
		if (room == 0):
			mouse = get_global_mouse_position().x   
			frame = int(time)%2
			if(frame==0): #CHECKS IF OFF COOLDOWN 
			#CHECKS IF GOES TO LEFT ROOM
				if (mouse < -900):
					if (mouse>-930):
						x = 1
						time = time+1
			#CHECK IF GOES TO RIGHT ROOM
				if (mouse < 930):
					if (mouse > 900):
						x = 2
						time = time+1
			#CHECKS IF GOES TO CENTRE
				if (mouse<-1130):
					if(mouse>-1160):
						x= 0
						time = time+1
				if (mouse<1160):
					if(mouse>1100):
						x= 0
						time = time+1
			#MOVEMENTS
			if (x == 1): #Left
				position = position.move_toward(Vector2(-2000,0),delta * speed)
			if (x == 0): #centre
				position = position.move_toward(Vector2(0,0),delta * speed)
			if (x==2): #Right
				position = position.move_toward(Vector2(2000,0), delta * speed)
			#COOLDOWN TIMER ON MOVEMENT
			if (frame != 0):
				time = time+delta 
		else:
			for i in antagPos.size:
				if (antagPos[i] == room):
					roomcode = roomcode + (10**(i+2))
					
