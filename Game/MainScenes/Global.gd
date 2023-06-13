extends Node

var player = "res://ChildPlayer2.tscn"
var level1
#var databaseConnector = load("DatabaseConnector.tscn").instance()
var enemy
var dragon
var dragon2
var dragon3
var dragon4
var dragon5
var dragon6
var dragon7
var dragon8
var camera
var lives = 3

var firebaseLogin
var q1_try_counter = 0
var q2_try_counter = 0
var q3_try_counter = 0
var q4_try_counter = 0
var rapid_correct1 : int = 0
var rapid_correct2: int = 0

var q1_try_counter_second_try = 0
var q2_try_counter_second_try  = 0
var q3_try_counter_second_try  = 0
var q4_try_counter_second_try  = 0
var rapid_correct1_second_try  = 0

var playButtonPressed
var startTime
var endTime
var gameStarts = 1

var age

var endQuestion1Answer 
var endQuestion2Answer
var endQuestion3Answer
var endQuestion4Answer
var endQuestion5Answer

var surveyAnswer1
var surveyAnswer2
var surveyAnswer3

var gender
var character_chosen

	

#func girl():
#	var packedscene = PackedScene.new()
#	packedscene.pack(player)
#	ResourceSaver.save(player, packedscene)
