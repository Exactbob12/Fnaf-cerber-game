extends Node

var power:float = 100
var inlaptop:bool = false
var scene:int = 0
var scaleX:float
var scaleY:float
var originalwidth = 1152
var originalheight = 648
func _process(delta):
	scaleX = float(DisplayServer.window_get_size().x / originalwidth)
	scaleY = float(DisplayServer.window_get_size().y / originalheight)
	print(scaleX," ",scaleY)
