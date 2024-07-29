extends Node

var currenttime: float = 0.0
var variation: float = randf_range(-0.2, 0.2)
var defaultnighttime: float = 3#540.0
var tph: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Stopwatch is ready")
	Global.connect("night_started", Callable(self, "_Night_Started"))
	Global.connect("night_end", Callable(self, "_Night_End"))

func gethour():
	var hour = currenttime / tph
	return floor(hour) + 2

func _Night_Started():
	variation = randf_range(-0.2, 0.2)
	print("Night started signal received")
	Global.started = true
	currenttime = 0.0

func _Night_End():
	Global.reset()
	print("night end")
	Global.started = false
	$"Time label".text = ""
	if gethour() == 8:
		Global.night = Global.night + 1
		print("Night unlocked: ",Global.night)
	currenttime = 0.00

func _process(delta):
	if Global.started:
		if Global.scene == 1:
			currenttime += delta
			tph = (defaultnighttime / 6) * (1 + variation)
			$"Time label".text = str(gethour(), " AM") #, "[", round(tph * 100.0) / 100.0, "s]", "{", round((variation * 100) * 100.0) / 100.0, "%} (", round(currenttime * 100.0) / 100.0, ")"
		else:
			Global.end_night()
		if currenttime >= defaultnighttime * (1 + variation):
			Global.end_night()
		Global.currentam = gethour()
	else:
		$"Time label".text = ""
