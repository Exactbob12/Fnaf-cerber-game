extends Panel


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Global.devmenutoggled and Global.devmenuunlocked:
		self.show()
	else:
		self.hide()

func _input(event):
	# Ensure the event is a key event
	if event is InputEventKey:
		var key_event = event as InputEventKey
		if Global.devmenuunlocked == true:
			if key_event.pressed and not key_event.is_echo():
				# Check for "`" (backtick) key press
				if key_event.keycode == KEY_QUOTELEFT:
					Global.devmenutoggled = not Global.devmenutoggled
					print("Developer menu toggled:", Global.devmenutoggled)
