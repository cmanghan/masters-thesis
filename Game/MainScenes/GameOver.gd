extends Control

func _ready():
	MainMusicController.play_music()
	
func _on_GameOverButton_pressed():
	get_tree().change_scene_to_file("res://TitleMenu.tscn")
	Global.lives = 3
	Global.gameStarts = Global.gameStarts + 1 

func _on_CreditsButton_pressed():
	get_tree().change_scene_to_file("res://Credits.tscn")

