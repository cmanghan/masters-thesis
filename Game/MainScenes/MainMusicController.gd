extends Control

var music = AudioStreamPlayer.new()
var music_clip : AudioStream = load("res://Assets/Music/SwingingPants.ogg")


func play_music ():
	add_child(music)
	var stream = music_clip
	music.set_stream(stream)
	music.play()

func stop_music():
	music.stop()
