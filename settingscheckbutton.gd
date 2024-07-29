extends CheckButton


func _process(_delta):
	# Adjust visibility based on current scene
	Global.settings.splashScreenEnabled = self.button_pressed
	match self.name:
		"Splashscreenoption":
			if Global.scene == 2:
				self.visible = true
			else:
				self.visible = false
		_:
			## Handle unknown switch or errors
			pass
