extends Control

var up = true
var count = 0

func _ready():
	MainMusicController.play_music()
	
func _on_Timer_timeout():
	if up and count < .2: 
		count = count + .1	
		$fireworks.set_rotation(count)
	elif !up and count > 0: 
		count = count -.1
		$fireworks.set_rotation(count)
	elif count == .2 or count == 0:
		if up: 
			count == count -.1
		else:
			count == count +.1
		up = !up	
	

func _on_PlayButton_pressed():
	Global.playButtonPressed = 1
	Global.startTime = Time.get_unix_time_from_system()
	
	get_tree().change_scene_to_file("res://ChooseACharacter.tscn")
	
	
