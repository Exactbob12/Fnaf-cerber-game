extends Node

func _process(_delta):
	if Global.devmenutoggled == false:
		self.text = ""
func _on_text_submitted(new_text):
	match self.name:
		"Shift Reality":
			new_text = new_text.replace("`", "")
			Global.shiftReality = (new_text == "true")  # Convert to appropriate type if needed
			print("Global.shiftReality updated to:", Global.shiftReality)
			self.text = ""
		"Shift Reality2":
			new_text = new_text.replace("`", "")
			Global.devmenuunlocked = (new_text == "true")  # Convert to appropriate type if needed
			print("Global.devmenuunlocked updated to:", Global.devmenuunlocked)
			self.text = ""
		"Shift Reality3":
			new_text = new_text.replace("`", "")
			Global.scene = int(new_text)  # Convert to appropriate type if needed
			print("Global.scene updated to:", Global.scene)
			self.text = ""
