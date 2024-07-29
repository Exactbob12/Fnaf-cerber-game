extends Area2D

var toggled = true
func _process(_delta):
	if Global.scene == 1:
		#print(get_local_mouse_position().y," ",position.y)
		if get_local_mouse_position().y < position.y:
			toggled = true
		if toggled:
			self.visible = true	
		else: 
			self.visible = false
	else: 
		self.visible = false
func _mouse_enter():
	toggled = false
