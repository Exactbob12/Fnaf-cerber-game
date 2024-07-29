extends Node

var power: float = 100
var inlaptop: bool = false
var scene: int = 0 #splash screens = -1, main menu = 0, office = 1, play menu = 5, settings = 2, credits = 4, night select = 6, night end = 7
var scaleX: float
var scaleY: float
var originalwidth: int = 1152
var originalheight: int = 648
var CharPositons: Array = [0, 1, 0, 0, 2]
var currentcam: int = -1
var shiftReality: bool = false
var night:int = 1
var savefilepath: String = "res://savefile.csv"
var devmenuunlocked: bool = false
var devmenutoggled: bool = false
var oldpersistantvardict
var prevam := 2
var currentam := 2
@onready var node2D = get_node("/root/Node2D")
var started: bool = false
var settings = {
	"splashScreenEnabled": true
}
var persistantvardict = {"shiftReality": shiftReality, "night": night, "devmenuunlocked": devmenuunlocked,"splashScreenEnabled": settings.splashScreenEnabled}
signal save_completed
signal night_started
signal night_end
signal resetgame
signal death

func _ready():
	clamp(night, 1, 11)
	loadsavefile()
	oldpersistantvardict = persistantvardict
	connect("death", Callable(node2D, "_on_death"))
	#set_dead()

func _process(_delta):
	scaleX = float(DisplayServer.window_get_size().x) / originalwidth
	scaleY = float(DisplayServer.window_get_size().y) / originalheight
	persistantvardict = {"shiftReality": shiftReality, "night": night, "devmenuunlocked": devmenuunlocked, "splashScreenEnabled": settings.splashScreenEnabled}
	if oldpersistantvardict != persistantvardict:
		savesavefile()
		oldpersistantvardict = persistantvardict

func savesavefile():
	print("attempting to save save file")
	if persistantvardict == {}:
		print("An error occured when trying to access persistant var dict, ERROR: empty, current value: ", persistantvardict)
	var savefile = FileAccess.open(savefilepath, FileAccess.WRITE)  # Open file in WRITE mode
	if savefile:
		for key in persistantvardict.keys():
			var line = key + "," + str(persistantvardict[key])  # Format as CSV line
			savefile.store_line(line)
		savefile.close()  # Close the file after writing
		print("saved(" + savefilepath + "): \n" + FileAccess.get_file_as_string(savefilepath))
		print("Save file written successfully.")
		emit_signal("save_completed")
	else:
		print("Failed to open save file for writing:", savefilepath)

func loadsavefile():
	if FileAccess.file_exists(savefilepath):
		if FileAccess.get_file_as_string(savefilepath).length() > 0:
			var file = FileAccess.open(savefilepath, FileAccess.READ)
			var loaded_data = {}
			while not file.eof_reached():
				var line = file.get_line().strip_edges()
				var parts = line.split(",")
				if parts.size() == 2:
					var key = parts[0]
					var value = parts[1]
					loaded_data[key] = value
			file.close()
			var any_set = false
			for key in loaded_data.keys():
				if persistantvardict.has(key):
					if key == "shiftReality":
						persistantvardict[key] = (loaded_data[key] == "true")
					else:
						persistantvardict[key] = loaded_data[key]
					if key == "night":
						persistantvardict[key] = int(loaded_data[key])
					else:
						persistantvardict[key] = loaded_data[key]
					if key == "devmenuunlocked":
						persistantvardict[key] = (loaded_data[key] == "true")
					else:
						persistantvardict[key] = loaded_data[key]
					if key == "splashScreenEnabled":
						persistantvardict[key] = (loaded_data[key] == "true")
					else:
						persistantvardict[key] = loaded_data[key]
					any_set = true
				else:
					print("Error: Key not found in persistantvardict:", key)
			if "shiftReality" in loaded_data:
				shiftReality = (loaded_data["shiftReality"] == "true")
			if "night" in loaded_data:
				night = int(loaded_data["night"])
			if "devmenuunlocked" in loaded_data:
				devmenuunlocked = (loaded_data["devmenuunlocked"] == "true")
			if "splashScreenEnabled" in loaded_data:
				settings.splashScreenEnabled = (loaded_data["splashScreenEnabled"] == "true")
			oldpersistantvardict = persistantvardict
			if any_set:
				print("Save file loaded successfully.")
			else:
				print("Error: No data found!")
				savesavefile()
				oldpersistantvardict = persistantvardict
		else:
			print("Save file empty! at (" + savefilepath + ")")
			savesavefile()
			oldpersistantvardict = persistantvardict
	else:
		print("Save file not found! Should be at (" + savefilepath + ")")
		savesavefile()
		oldpersistantvardict = persistantvardict

func end_night():
	emit_signal("night_end")

func start_night():
	emit_signal("night_started")

func reset():
	emit_signal("resetgame")

func set_dead():
	print("emmiting death signal")
	emit_signal("death")
