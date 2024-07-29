extends Button
#chat gpt taught me how to do half of this💀 -Walmart

func _ready():
	# Connect the pressed signal to the _on_button_pressed method
	self.connect("pressed", Callable(self, "_on_button_pressed"))

func _on_button_pressed():
	# Use match to determine action based on button name
	match self.name:
		"Play":
			Global.scene = 5
			print("Switching to scene 5")
		"continue":
			Global.scene = 1
			Global.start_night()
			print("Switching to scene 1")
		"Settings":
			Global.scene = 2
			print("Switching to scene 2")
		"Exit":
			DisplayServer.window_set_title(". . .noos uoy eeS")
			get_tree().quit()
		"Credits":
			Global.scene = 4
			print("Switching to scene 4")
		"selnight":
			Global.scene = 6
			print("Switching to scene 6")
		_:
			# Handle unknown button or errors
			print("Unknown button pressed")

func _process(_delta):
	# Adjust visibility based on current scene
	match self.name:
		"Play":
			if Global.scene == 0:
				self.visible = true
			else:
				self.visible = false
		"selnight":
			if Global.scene == 5:
				self.visible = true
			else:
				self.visible = false
		"continue":
			self.text = str("Continue (night: ",Global.night,")")
			if Global.scene == 5:
				self.visible = true
			else:
				self.visible = false
		_:
			## Handle unknown button or errors
			pass
