extends Control

func _change_scene():
	get_tree().change_scene_to_file("res://Instructions.tscn")

func _on_JuanButton2_pressed():
	Global.player = "res://ChildPlayer.tscn"
	Global.character_chosen = "Juan"
	_change_scene()

func _on_JuanButton_pressed():
	Global.player = "res://ChildPlayer.tscn"
	Global.character_chosen = "Juan"
	_change_scene()

func _on_AllieButton2_pressed():
	Global.player = "res://ChildPlayer2.tscn"
	Global.character_chosen = "Allie"
	_change_scene()

func _on_AllieButton_pressed():
	Global.player = "res://ChildPlayer2.tscn"
	Global.character_chosen = "Allie"
	_change_scene()

func _on_AshButton2_pressed():
	Global.player = "res://ChildPlayer3.tscn"
	Global.character_chosen = "Ash"
	_change_scene()

func _on_AshButton_pressed():
	Global.player = "res://ChildPlayer3.tscn"
	Global.character_chosen = "Ash"
	_change_scene()

func _on_JordanButton2_pressed():
	Global.player = "res://ChildPlayer4.tscn"
	Global.character_chosen = "Jordan"
	_change_scene()

func _on_JordanButton_pressed():
	Global.player = "res://ChildPlayer4.tscn"
	Global.character_chosen = "Jordan"
	_change_scene()

func _on_FinnButton2_pressed():
	Global.player = "res://ChildPlayer5.tscn"
	Global.character_chosen = "Finn"
	_change_scene()

func _on_FinnButton_pressed():
	Global.player = "res://ChildPlayer5.tscn"
	Global.character_chosen = "Finn"
	_change_scene()

func _on_KylieButton2_pressed():
	Global.player = "res://ChildPlayer6.tscn"
	Global.character_chosen = "Kylie"
	_change_scene()
	
func _on_KylieButton_pressed():
	Global.player = "res://ChildPlayer6.tscn"
	Global.character_chosen = "Kylie"
	_change_scene()
