extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	match self.name:
		"Shift Reality Label":
			self.text = str("S.R:",Global.shiftReality)
		"Shift Reality Label2":
			self.text = str("D.M:",Global.devmenuunlocked)
		"Shift Reality Label3":
			self.text = str("S.E:",Global.scene)
