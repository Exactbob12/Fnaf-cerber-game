extends Label

#func _process(_delta):
	#label_settings.font_size = 76 * pow(minf(Global.scaleX, Global.scaleY), 0.34)
	## Check if the scene is the main menu (scene index 0)
	#if Global.scene == 0 or Global.scene == 5 or Global.scene == 6:
		#self.visible = true
	#else:
		#self.visible = false
