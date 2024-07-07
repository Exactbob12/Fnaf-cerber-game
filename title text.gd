extends Label

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	label_settings.font_size = 76*Global.scaleX
	if Global.scene == 0:
		self.visible = true
	else:
		self.visible = false
