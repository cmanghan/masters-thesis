extends Control

var question2 = "Its okay to text funny jokes about the way a friend looks if the friend doesn't know"
var question3 = "Its okay to push little kids if they are in your way"
var qnum = 1

signal update_document
signal update_database


func _ready():
	$Loading.hide()
	$InstructionSet/InstructionsHolder.hide()
	$InstructionSet/InstructionsHolder/Set2/jump/slimeBlue_blue.set_modulate(Color(1.2,0.5,1))
	$InstructionSet/Quest.hide()
	$InstructionSet/Age.show()
	$InstructionSet/Age/Age13/LineEdit.hide()
	$InstructionSet/Age/Age13/AgeNext.hide()
	$InstructionSet/Gender.hide()
	$InstructionSet/Survey.hide()
	
func _on_Play_Button_pressed():
	$InstructionSet.hide()
	$Loading.show()
	$Loading/LoadingTimer.start()

func _on_LoadingTimer_timeout():
	$Loading/LoadingTimer.stop()
	get_tree().change_scene_to_file("res://Level1.tscn")
	MainMusicController.stop_music()


func _on_NextButton_pressed():
	$InstructionSet/InstructionsHolder/Set1.hide()
	$InstructionSet/InstructionsHolder/Set2.show()


func _on_PlayButton_pressed():
	#emit_signal("update_database")
	emit_signal("update_document")
	$InstructionSet.hide()
	$Loading.show()
	$Loading/LoadingTimer.start()
	

func _on_NextButton2_pressed():
	$InstructionSet/Quest.hide()
	$InstructionSet/InstructionsHolder.show()
	$InstructionSet/InstructionsHolder/Set2.hide()
	

func age_pressed():
	$InstructionSet/Age.hide()
	$InstructionSet/Gender.show()

func _gender_pressed():
	$InstructionSet/Gender.hide()
	$InstructionSet/Survey.show()
	
func _on_Age5_pressed():
	Global.age =5
	age_pressed()
	
func _on_Age6_pressed():
	Global.age =6
	age_pressed()

func _on_Age7_pressed():
	Global.age =7
	age_pressed()

func _on_Age8_pressed():
	Global.age =8
	age_pressed()

func _on_Age9_pressed():
	Global.age =9
	age_pressed()

func _on_Age10_pressed():
	Global.age =10
	age_pressed()

func _on_Age11_pressed():
	Global.age =11
	age_pressed()

func _on_Age12_pressed():
	Global.age =12
	age_pressed()

func _on_Age13_pressed():
	$InstructionSet/Age/Age13/Label.hide()
	$InstructionSet/Age/Age13/LineEdit.show()

func _on_LineEdit_text_changed(new_text):
	$InstructionSet/Age/Age13/AgeNext.show()

func _on_AgeNext_pressed():
	Global.age = $InstructionSet/Age/Age13/LineEdit.get_text()
	age_pressed()

func _on_Boy_pressed():
	Global.gender = "boy"
	_gender_pressed()	

func _on_Girl_pressed():
	Global.gender = "other"
	_gender_pressed()	

func _on_Other_pressed():
	Global.gender = "other"
	_gender_pressed()	
	
func _survey_questions():
	qnum = qnum + 1
	$InstructionSet/Survey.show()
	if qnum ==2:
		$InstructionSet/Survey/Header4.set_text(question2)
	elif qnum ==3:
		$InstructionSet/Survey/Header4.set_text(question3)
	elif qnum==4:
		$InstructionSet/Survey.hide()
		$InstructionSet/Quest.show()

func _on_Yes_pressed():
	if qnum == 1:
		Global.surveyAnswer1 = "yes"
	elif qnum == 2:
		Global.surveyAnswer2 = "yes"
	elif qnum == 3:
		Global.surveyAnswer3 = "yes"
	_survey_questions()

func _on_No_pressed():
	if qnum == 1:
		Global.surveyAnswer1 = "no"
	elif qnum == 2:
		Global.surveyAnswer2 = "no"
	elif qnum == 3:
		Global.surveyAnswer3 = "no"
	_survey_questions()

func _on_Maybe_pressed():
	if qnum == 1:
		Global.surveyAnswer1 = "maybe"
	elif qnum == 2:
		Global.surveyAnswer2 = "maybe"
	elif qnum == 3:
		Global.surveyAnswer3 = "maybe"
	_survey_questions()
