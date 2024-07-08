extends Label

func _process(delta):
	label_settings.font_size = 76 * pow(minf(Global.scaleX, Global.scaleY), 0.34)
	# Check if the scene is the main menu (scene index 0)
	if Global.scene == 0:
		self.visible = true
	else:
		self.visible = false
