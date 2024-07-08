extends Button
#chat gpt taught me how to do half of this💀 -Walmart
func _ready():
	# Connect the pressed signal to the _on_button_pressed method
	self.connect("pressed", Callable(self, "_on_button_pressed"))
func _on_button_pressed():
	# Use match to determine action based on button name
	match self.name:
		"Play":
			Global.scene = 1
		"Settings":
			Global.scene = 2
		"Exit":
			Global.scene = 3
			DisplayServer.window_set_title(". . .emit txen uoy eeS")
			get_tree().quit()
		"Credits":
			Global.scene = 4
		_:
			# Handle unknown button or errors
			print("Unknown button pressed")
func _process(delta):
	# Adjust visibility based on current scene
	if Global.scene == 0:
		self.visible = true
	else:
		self.visible = false
