extends Node2D

# Splash screen states
enum SplashState {
	FADE_IN_1,
	DISPLAY_1,
	FADE_OUT_1,
	FADE_IN_2,
	DISPLAY_2,
	FADE_OUT_2,
	FADE_OUT_BG,
	DONE
}

var current_state = SplashState.FADE_IN_1
var splash_time = 0.0
var fade_duration = 2.0
var display_duration = 1.0
var splash_alpha = 0.0
var bg_alpha = 1.0
var deathStopWatchToggle = false
var deathStopwatch = 0.0
var deathtime = 900.0
var splash1 = null
var splash2 = null
var color_rect = null

func _ready():
	splash1 = $Splash1
	splash2 = $Splash2
	color_rect = $ColorRect
	$Splashscreenoption.button_pressed = Global.settings.splashScreenEnabled
	if Global.settings.splashScreenEnabled:
		splash1.modulate = Color(1, 1, 1, 0)
		splash2.modulate = Color(1, 1, 1, 0)
		color_rect.color = Color(0, 0, 0, 1)
		color_rect.show()
		splash1.show()
		splash2.hide()
	else:
		Global.scene = 0

func _process(delta):
	if deathStopWatchToggle:
		deathStopwatch += delta
	if Global.settings.splashScreenEnabled:
		splash_time += delta
		
		match current_state:
			SplashState.FADE_IN_1:
				splash_alpha = min(splash_time / fade_duration, 1.0)
				splash1.modulate = Color(1, 1, 1, splash_alpha)
				if splash_time >= fade_duration:
					splash_time = 0.0
					current_state = SplashState.DISPLAY_1
			
			SplashState.DISPLAY_1:
				if splash_time >= display_duration:
					splash_time = 0.0
					current_state = SplashState.FADE_OUT_1
			
			SplashState.FADE_OUT_1:
				splash_alpha = 1.0 - min(splash_time / fade_duration, 1.0)
				splash1.modulate = Color(1, 1, 1, splash_alpha)
				if splash_time >= fade_duration:
					splash_time = 0.0
					splash1.hide()
					splash2.show()
					current_state = SplashState.FADE_IN_2
			
			SplashState.FADE_IN_2:
				splash_alpha = min(splash_time / fade_duration, 1.0)
				splash2.modulate = Color(1, 1, 1, splash_alpha)
				if splash_time >= fade_duration:
					splash_time = 0.0
					current_state = SplashState.DISPLAY_2
			
			SplashState.DISPLAY_2:
				if splash_time >= display_duration:
					splash_time = 0.0
					current_state = SplashState.FADE_OUT_2
			
			SplashState.FADE_OUT_2:
				splash_alpha = 1.0 - min(splash_time / fade_duration, 1.0)
				splash2.modulate = Color(1, 1, 1, splash_alpha)
				if splash_time >= fade_duration:
					splash_time = 0.0
					splash2.hide()
					current_state = SplashState.FADE_OUT_BG

			SplashState.FADE_OUT_BG:
				Global.scene = 0
				bg_alpha = 1.0 - min(splash_time / fade_duration, 1.0)
				color_rect.color = Color(0, 0, 0, bg_alpha)
				if splash_time >= fade_duration:
					splash_time = 0.0
					current_state = SplashState.DONE
			
			SplashState.DONE:
				color_rect.hide()

func _on_death():
	Global.scene = 9
	print("Death signal received")
	deathStopwatch = 0.0
	var labelscale = 0.0
	deathStopWatchToggle = true
	$VideoStreamPlayer.stop()
	$VideoStreamPlayer/Label.modulate = Color(1, 1, 1, 0)
	$VideoStreamPlayer/Label.show()
	$VideoStreamPlayer.play()
	clamp(labelscale, 0.0, 220.0)
	while deathStopwatch <= deathtime:
		labelscale += pow(labelscale, 0.34) * get_process_delta_time()
		$VideoStreamPlayer/Label.scale = Vector2(labelscale, labelscale)
		$VideoStreamPlayer/Label.modulate.a = min(deathStopwatch / deathtime, 1.0)
	if deathStopwatch >= deathtime:
		$VideoStreamPlayer.stop()
		$VideoStreamPlayer/Label.hide()
