extends Node2D

var player = load(Global.player).instantiate()
var right_answer_timer
var wrong_answer_timer
var options_timer
var disappear_timer
#var lives = 3
var readyset = 0
var time = 31

signal bullying
signal carry_on
signal player_flying
signal flying
signal flying2
signal flying3
signal flying4
signal flying5
signal flying6
signal flying7
signal flying8
signal stop_flying
signal dragon_stop_flying
signal reset_camera
signal save_point
signal falling
signal bounce_back
signal update_database
signal update_document
signal flydown4
signal flydown_classroom
signal flydown6
signal flydown7



var dialog =[]
var page = 0

var situation = ""
var option1_response =""
var option2_response =""
var option3_response = ""

var option1_button_text =""
var option2_button_text =""
var option3_button_text =""

var option1correct = false
var option2correct = false
var option3correct = false 

var questionArray = []
var arrayNum = -1
var rapid_correct1 : int  = 0
var rapid_correct2 : int  = 0
var correct : int  = 0

var endquestionArray = []
var endArrayNum = 0
var endexportArray = []
var endQuestionYes = false

#var instructions = "Read each case and say if it is bullying.  Answer as many as you can!"
var question1 = ""
var question2 = ""
var question3 = ""
var question4 = ""
var question5 = ""
var question6 = ""
var question7 = ""
var question8 = ""


var endQuestion1 = "Was this game fun?"
var endQuestion2 = "Did you like the dragons and fantasy theme?"
var endQuestion3 = "Did this game help you learn more about bullying?"
var endQuestion4 = "What was your favorite part of the game?"
var endQuestion5 = "What did you dislike about the game?"
var endThankYou = "Thanks for playing!"

var first_try = true
var life_won 
var bigger = true
var rapid = false
var count = 0

var q1_redo_needed = false
var q2_redo_needed = false
var q3_redo_needed = false
var q4_redo_needed = false
var q3_and_q4_redo_needed = false
var rapid_move = false
var game_over_move_needed = false
var final_rapid_complete = false
var rapid_first_time = true
var q1_first_time= true
var q2_first_time = true
var q3_first_time = true
var q4_first_time = true

var current_question = 0

var rand = 9


var music_clip : AudioStream = load("res://Assets/Music/RetroBeat.ogg")


func _ready():
	emit_signal("update_database")
	
	Global.level1 = self
	
	var music = AudioStreamPlayer.new()
	add_child(music)
	var stream = music_clip
	music.set_stream(stream)
	music.play()
	
	#Connect instanced scene to signal emitted by FallZone
	$FallZone.connect("body_entered", Callable(player, "_on_Fall_Zone_body_entered"))
	$FallZone2.connect("body_entered", Callable(player, "_on_Fall_Zone_body_entered"))
	$FallZone3.connect("body_entered", Callable(player, "_on_Fall_Zone_body_entered"))
	$FallZone4.connect("body_entered", Callable(player, "_on_Fall_Zone_body_entered"))
	$FallZone5.connect("body_entered", Callable(player, "_on_Fall_Zone_body_entered"))
	
	
	connect("player_flying", Callable(player, "_flying"))
	connect("stop_flying", Callable(player, "_stop_flying"))
	connect("bounce_back", Callable(player, "_bounce_back"))
	connect("flying", Callable(Global.dragon, "_flying"))
	connect("flying2", Callable(Global.dragon2, "_flying2"))
	connect("flying3", Callable(Global.dragon3, "_flying3"))
	connect("flying4", Callable(Global.dragon4, "_flying4"))
	connect("flying5", Callable(Global.dragon5, "_flying5"))
	connect("flying6", Callable(Global.dragon6, "_flying6"))
	connect("flying7", Callable(Global.dragon7, "_flying7"))
	connect("flying8", Callable(Global.dragon8, "_flying8"))
	connect("dragon_stop_flying", Callable(Global.dragon, "_stop_flying"))
	connect("dragon_stop_flying", Callable(Global.dragon2, "_stop_flying"))
	connect("dragon_stop_flying", Callable(Global.dragon3, "_stop_flying"))
	connect("dragon_stop_flying", Callable(Global.dragon4, "_stop_flying"))
	connect("dragon_stop_flying", Callable(Global.dragon5, "_stop_flying"))
	connect("dragon_stop_flying", Callable(Global.dragon6, "_stop_flying"))
	connect("dragon_stop_flying", Callable(Global.dragon7, "_stop_flying"))
	connect("dragon_stop_flying", Callable(Global.dragon8, "_stop_flying"))
	
	connect("flydown4", Callable(Global.dragon4, "_flying_down"))
	connect("flydown_classroom", Callable(Global.dragon3, "_flying_down"))
	connect("flydown6", Callable(Global.dragon6, "_flying_down"))
	connect("flydown7", Callable(Global.dragon7, "_flying_down"))
	
	connect("reset_camera", Callable(player, "_reset_camera"))
	connect ("save_point", player, "_save_point")
	
	connect("update_database", Callable(Global.firebaseLogin, "_update_database"))
	connect("update_document", Callable(Global.firebaseLogin, "_update_document"))
	
	
	
	player.position = Vector2(-367,403)
	self.add_child(player)
	$HUD/Prompt.hide()
	$HUD/LearnMore.hide()
	$HallwayHolder.hide()
	$BedroomHolder.hide()
	$ClassroomHolder.hide()
	$LockerRoomHolder.hide()
	$RapidHolder.hide()
	$Hint.hide()
	$HUD/WinHolder.hide()
	$HUD/ResourcesHolder.hide()
	$HUD/RightAnswer.hide()
	$HUD/WhiteYoureRight.hide()
	
	$HUD/heart4.hide()
	$HUD/heart5.hide()
	$HUD/heart6.hide()
	$HUD/heart7.hide()
	$HUD/heart8.hide()
	$HUD/heart9.hide()
	$HUD/LivesPanel4.hide()
	$HUD/LivesPanel5.hide()
	$HUD/LivesPanel6.hide()
	$HUD/LivesPanel7.hide()
	$HUD/LivesPanel8.hide()
	$HUD/LivesPanel9.hide()
	$DragonHolder/YouWinDragon.hide()
	
	endquestionArray.append(endQuestion1)
	endquestionArray.append(endQuestion2)
	endquestionArray.append(endQuestion3)
	endquestionArray.append(endQuestion4)
	endquestionArray.append(endQuestion5)
	endquestionArray.append(endThankYou)
	
	question1 = "Lisa keeps touching Bri's hair after Bri asked her to stop"
	question2 = "Mike won't ever let Todd play tag because Todd is in a wheelchair"
	question3 = "Jen posted a picture online that calls Mea ugly"
	question4 = "Ken acidentally fell and knocked over your lunch"
	question5 = "Nick pranks Annie every day by putting her book too high to reach"
	question6 = "Ben took your pencil because he thought it was his"
	question7 = "Lea sent you a snapchat with a funny picture of her pets"
	question8 = "Alex told the whole class that Drew picks his nose, even though its not true"
		
	
	_add_Situations()
	
func _bullying():
	$HUD/Prompt/NextButton.hide()
	$HUD/Prompt/NextButton/NextLabel.hide()
	$HUD/Prompt/Option1Button.hide()
	$HUD/Prompt/Option2Button.hide()
	$HUD/Prompt/Option3Button.hide()
	$HUD/Prompt/ContinueQuestButton.hide()
	$HUD/Prompt/TryAgainButton.hide()
	$HUD/Prompt/LearnWhyButton.hide()
	#make sure there are no previous elements in the array
	clear_array()
	
	
	#disable player movement
	$HUD/Prompt.show()
	connect("bullying", Callable(player, "_bullying"))
	emit_signal("bullying")
	#$HallwayHolder/BullyZone.set_collision_mask_bit(0, false)
	showMessage()
	$HUD/Prompt/PromptTextLabel/PromptTimer.start()

func showMessage():
	page=0
	dialog.append(situation)
	if first_try:
		$HUD/Prompt/PromptTextLabel.set_bbcode(dialog[page])
		$HUD/Prompt/PromptTextLabel.set_visible_characters(1)
	else:
		_on_Button_pressed()

func _on_PromptTimer_timeout():
	$HUD/Prompt/PromptTextLabel.set_visible_characters($HUD/Prompt/PromptTextLabel.get_visible_characters()+ 1)
	var length = dialog[page].length()
	if $HUD/Prompt/PromptTextLabel.get_visible_characters() == length && page ==0:
		$HUD/Prompt/NextButton.show()
		$HUD/Prompt/NextButton/NextLabel.show()
	elif $HUD/Prompt/PromptTextLabel.get_visible_characters() == length && page ==1:
	
		$HUD/Prompt/Option1Button/Option1ButtonLabel.set_text(option1_button_text)
		$HUD/Prompt/Option2Button/Option2ButtonLabel.set_text(option2_button_text)
		$HUD/Prompt/Option3Button/Option3ButtonLabel.set_text(option3_button_text)
	
		$HUD/Prompt/Option1Button.show()
		$HUD/Prompt/Option2Button.show()
		$HUD/Prompt/Option3Button.show()
		
func _on_Button_pressed():
	$HUD/Prompt/NextButton.hide()
	page = page + 1
	dialog.append("Whats the best way to solve this problem?")
	$HUD/Prompt/PromptTextLabel.set_bbcode(dialog[page])
	$HUD/Prompt/PromptTextLabel.set_visible_characters(1)
	
func _on_Option1Button_pressed():
	dialog.append(option1_response)
	_response_answer()
	if option1correct:
		_right_answer()
	else:
		_wrong_answer()

func _on_Option2Button_pressed():
	dialog.append(option2_response)
	_response_answer()
	if option2correct:
		_right_answer()
	else:
		_wrong_answer()
		
func _on_Option3Button_pressed():
	dialog.append(option3_response)
	_response_answer()
	if option3correct:
		_right_answer()
	else:
		_wrong_answer()

func _on_TryAgainTimer_timeout():
	$HUD/Prompt/TryAgainButton/TryAgainTimer.stop()
	first_try = false
	$HUD/Prompt/TryAgainButton.show()
	
	$HUD/Prompt/LearnWhyButton/LearnWhyButtonLabel.set_text("Learn Why")
	$HUD/Prompt/LearnWhyButton.show()
	
	if current_question ==1:
			q1_redo_needed = true
			print("set q1 redo needed to true")
	elif current_question == 2:
			q2_redo_needed = true
	elif current_question ==3:
		q3_redo_needed = true
		print("set q3 redo needed to true")
		rapid_move = true
	elif current_question ==4:
		q4_redo_needed = true
		$LockerRoomHolder/LockerRoomRedoSignal.set_collision_mask_value(0, true) #trying this
		rapid_move = true
		if q3_redo_needed:
			q3_and_q4_redo_needed = true

func _on_TryAgainButton_pressed():
	$HUD/Prompt/PromptTextLabel/PromptTimer.stop()
	
	clear_array()
	_bullying()
	
func clear_array():
	var size = dialog.size()
	for i in dialog.size():
		dialog.remove(i)
	dialog.remove(0)

func clear_rapid_array():
	questionArray.remove(0)
	questionArray.remove(1)
	questionArray.remove(2)
	questionArray.remove(3)
	questionArray.remove(4)
	questionArray.remove(5)
	questionArray.remove(6)
	questionArray.remove(7)
	questionArray.remove(8)
	
	print(str(questionArray))
	
func _response_answer():
	$HUD/Prompt/Option1Button.hide()
	$HUD/Prompt/Option2Button.hide()
	$HUD/Prompt/Option3Button.hide()
	
	page = page + 1
	$HUD/Prompt/PromptTextLabel.set_bbcode(dialog[page])
	$HUD/Prompt/PromptTextLabel.set_visible_characters(1)


func _right_answer():
	$HUD/Prompt/ContinueQuestButton/ContinueQuestTimer.start()
	if first_try:
		$HUD/RightAnswer/YoureRight.set_text("Great Answer!")
		$HUD/RightAnswer.show()
		$HUD/RightAnswer/YoureRight/minus.hide()
		$HUD/RightAnswer/YoureRight.show()
		$HUD/RightAnswer/YoureRight/plus.show()
		count = 0 
		$HUD/RightAnswer/heartwon.scale.x = 1.54
		$HUD/RightAnswer/heartwon.scale.y = 1.481
		$HUD/RightAnswer/heartwon/HeartTimer.start()
		$HUD/RightAnswer/LifeChangerTimer.start()
		life_won = true
		
	if current_question == 1 and q1_first_time:
		Global.q1_try_counter = Global.q1_try_counter + 1
	elif current_question == 1 and q1_first_time == false:
		Global.q1_try_counter_second_try = Global.q1_try_counter_second_try + 1
	elif current_question ==2 and q2_first_time:
		Global.q2_try_counter = Global.q2_try_counter + 1
	elif current_question == 2 and q2_first_time == false:
		Global.q2_try_counter_second_try = Global.q2_try_counter_second_try + 1
	elif current_question == 3 and q3_first_time:
		Global.q3_try_counter = Global.q3_try_counter + 1
	elif current_question == 3 and q3_first_time == false:
		Global.q3_try_counter_second_try = Global.q3_try_counter_second_try + 1
	elif current_question == 4 and q4_first_time:
		Global.q4_try_counter = Global.q4_try_counter + 1
	elif current_question == 4 and q4_first_time == false:
		Global.q4_try_counter_second_try = Global.q4_try_counter_second_try + 1
	emit_signal("update_document")

func _wrong_answer():
	
	$HUD/Prompt/TryAgainButton/TryAgainTimer.start()
	if first_try:
		$HUD/RightAnswer/YoureRight.set_text("Opps! Try Again")
		$HUD/RightAnswer.show()
		$HUD/RightAnswer/YoureRight/plus.hide()
		$HUD/RightAnswer/YoureRight.show()
		$HUD/RightAnswer/YoureRight/minus.show()
		count = 0
		$HUD/RightAnswer/heartwon.scale.x = 1.54
		$HUD/RightAnswer/heartwon.scale.y = 1.481
		$HUD/RightAnswer/heartwon/HeartTimer.start()
		$HUD/RightAnswer/LifeChangerTimer.start()
		life_won = false
		
	if current_question == 1 and q1_first_time:
		Global.q1_try_counter = Global.q1_try_counter + 1
	elif current_question == 1 and q1_first_time == false:
		Global.q1_try_counter_second_try = Global.q1_try_counter_second_try + 1
	elif current_question ==2 and q2_first_time:
		Global.q2_try_counter = Global.q2_try_counter + 1
	elif current_question == 2 and q2_first_time == false:
		Global.q2_try_counter_second_try = Global.q2_try_counter_second_try + 1
	elif current_question == 3 and q3_first_time:
		Global.q3_try_counter = Global.q3_try_counter + 1
	elif current_question == 3 and q3_first_time == false:
		Global.q3_try_counter_second_try = Global.q3_try_counter_second_try + 1
	elif current_question == 4 and q4_first_time:
		Global.q4_try_counter = Global.q4_try_counter + 1
	elif current_question == 4 and q4_first_time == false:
		Global.q4_try_counter_second_try = Global.q4_try_counter_second_try + 1
	emit_signal("update_document")

	
func _on_HeartTimer_timeout():
	
	if bigger and count < .6: 
		count = count + .1	
		if rapid == false:
			$HUD/RightAnswer/heartwon.scale.x = $HUD/RightAnswer/heartwon.scale.x + count
			$HUD/RightAnswer/heartwon.scale.y = $HUD/RightAnswer/heartwon.scale.y + count
		else:
			$HUD/WhiteYoureRight/heartwon2.scale.x = $HUD/WhiteYoureRight/heartwon2.scale.x + count
			$HUD/WhiteYoureRight/heartwon2.scale.y = $HUD/WhiteYoureRight/heartwon2.scale.y + count
		
	elif !bigger and count > 0: 
		count = count -.1
		if rapid == false:
			$HUD/RightAnswer/heartwon.scale.x = $HUD/RightAnswer/heartwon.scale.x - count
			$HUD/RightAnswer/heartwon.scale.y = $HUD/RightAnswer/heartwon.scale.y - count
		else:
			$HUD/WhiteYoureRight/heartwon2.scale.x = $HUD/WhiteYoureRight/heartwon2.scale.x - count
			$HUD/WhiteYoureRight/heartwon2.scale.y = $HUD/WhiteYoureRight/heartwon2.scale.y - count
		
	elif count == .6 or count == 0:
		if bigger: 
			count == count -.1
		else:
			count == count +.1
		bigger = !bigger

	
func _on_RightAnswerTimer_timeout():
	$HUD/RightAnswer/LifeChangerTimer.stop()
	$HUD/RightAnswer/heartwon/HeartTimer.stop()
	$HUD/RightAnswer.hide()
	$HUD/WhiteYoureRight.hide()
	if life_won:
		_life_won()
	else:
		_life_lost()

	
func _on_ContinueQuestTimer_timeout():
	$HUD/Prompt/ContinueQuestButton/ContinueQuestTimer.stop()
	
	$HUD/Prompt/ContinueQuestButton/ContinueQuestLabel.set_text("Continue Quest")
	$HUD/Prompt/ContinueQuestButton.show()
		
	$HUD/Prompt/LearnWhyButton/LearnWhyButtonLabel.set_text("Learn Why")
	$HUD/Prompt/LearnWhyButton.show()
	

func _on_ContinueQuestButton_pressed():
	$HUD/Prompt.hide()
	
	if current_question == 3 and q1_redo_needed and q3_first_time:
		_q1_wrong()
		_dragon_redo()	
	elif current_question == 4 and q2_redo_needed and q4_first_time:
		_q2_wrong()
		_dragon_redo()
	elif current_question == 3 and q3_and_q4_redo_needed == true:
		q3_and_q4_wrong()
		_dragon_redo()
	
	else:
		$HUD/Prompt/ContinueQuestButton/ContinueQuestHiderTimer.start()
		carry_on()
		emit_signal("reset_camera")

func _on_ContinueQuestHiderTimer_timeout():
	$HUD/Prompt/ContinueQuestButton/ContinueQuestHiderTimer.stop()
	$HallwayHolder.hide()
	$BedroomHolder.hide()
	$ClassroomHolder.hide()
	$LockerRoomHolder.hide()

func carry_on ():
	connect("carry_on", Callable(player, "_carry_on"))
	emit_signal("carry_on")

func _on_LearnWhyButton_pressed():
	$HUD/LearnMore.show()

func _on_OkayButton_pressed():
	$HUD/LearnMore.hide()

func _on_Area2D_body_entered(body):
	emit_signal("stop_flying")
	first_try = true
	#$HallwayHolder.show()
	
	current_question = 1
	if q1_first_time:
		situation = "It looks like there is bullying going on. \n\nDan just pushed Lee in the school hallway."
	else:
		situation = "It looks like there is bullying going on. \n\nDan just shoved Lee into the lockers"
	option1_button_text = "Tell A Teacher"
	option1correct = true
	option2_button_text = "Join the laughter"
	option2correct = false
	option3_button_text = "Say \"That's not nice!\""
	option3correct = true
	
	option1_response = "Great answer! \n\nTelling a teacher or trusted adult is a great way to stop bullying!"
	option2_response = "Opps! \n\nJoining in the laughter can encourage the bully and cause even more bullying. Let's try again!"
	option3_response = "Great answer! \n\nStanding up for a friend can put a stop to bullying!"
	
	var learn_more_1 = "Pushing is a form of physical voilence. Physical violence is never okay. Physical violence can happen at school in areas like the hallway, classroom, and recess and outside of school in places like the park and sports practice. If you see physical violence or if someone is physically violent to you, you should tell the bully to stop or tell a teacher or trusted adult."
	$HUD/LearnMore/LearnMoreLabel.set_text(learn_more_1)
	
	_bullying()


func _on_BullyZone2_body_entered(body):
	emit_signal("stop_flying")
	current_question = 2
	
	$BedroomHolder/BedroomCamera.current= true
	first_try = true
	if q2_first_time:
		situation = "It looks like there is bullying going on. \n\nMary and Meg are filming a TikTok with jokes about the way Joe walks."
	else:
		situation = "It looks like there is bullying going on. \n\nMary and Meg posted a Snapchat story of Joe falling over."
	option1_button_text = "Tell them to Stop"
	option1correct = true
	option2_button_text = "Like the video"
	option2correct = false
	option3_button_text = "Tell your Parents"
	option3correct = true
	
	option1_response = "Great answer! \n\nTelling a bully to stop encourages them to stop their behavior."
	option2_response = "Opps! \n\nLiking the video can encourage the bully and cause even more bullying. Let's try again!"
	option3_response = "You're right! Telling your parents, or another trusted adult can help to end bullying"
	
	var learn_more_2 = "This is an example of cyber bullying. Cyber bullying means the bullying happened online or using a phone, laptop, or tablet. This type of bullying can happen on apps like TikTok and Instagram. It can happen during school or after school. If this bullying happens it is important to tell a teacher or trusted adult or tell the bully or bullies to stop."
	$HUD/LearnMore/LearnMoreLabel.set_text(learn_more_2)
	
	_bullying()

func _on_ClassroomBullyZone_body_entered(body):
	emit_signal("stop_flying")
	
	current_question = 4
	if q4_redo_needed == false:
		$ClassroomHolder/ClassroomCamera.current= true
	elif q4_redo_needed == true and q3_redo_needed == false:
		$MovedCameraHolder/ClassroomCamera2Low.current = true
		q4_first_time = false
	elif q3_redo_needed == true and q4_redo_needed == true:
		print("Cameraaaa")
		$MovedCameraHolder/ClassroomCamera3High.current = true
		q4_first_time = false
	first_try = true
	
	if q4_first_time:
		situation = "It looks like there is bullying going on. \n\nHarry called James stupid. \n\nAll your friends are watching but no one is saying anything."
	else:
		situation = "It looks like there is bullying going on. \n\n Harry just called James a mean name. Your classmates are all laughing."
	option1_button_text = "Dont say anything, so Harry won't bully you next"
	option1correct = false
	option2_button_text = "Tell a Teacher"
	option2correct = true
	option3_button_text = "Call James a name so your friends will think you're funny"
	option3correct = false
	
	option1_response = "Opps! \n\nStaying quiet can cause the bullying to keep happening. Let's try again!"
	option2_response = "Great Answer! Telling the a teacher can help to end bullying!"
	option3_response = "Opps! \n\nJoining in the bullying is never okay! Let's try again"
	
	var learn_more_3 = "Calling someone mean names or saying mean things about them is bullying. When you see bullying happening it is important to tell a teacher or tell the bully to stop. Even if other people are not saying anything it is important to stand up for other."
	$HUD/LearnMore/LearnMoreLabel.set_text(learn_more_3)
	
	$ClassroomHolder/ClassroomBullyZone.set_collision_mask_value(0, true)
	_bullying()

func _on_LockerRoomBullyZone2_body_entered(body):
	
	emit_signal("stop_flying")
	
	current_question = 3
	if q3_redo_needed == false:
		$LockerRoomHolder/LockerRoomCamera.current = true
	else:
		$MovedCameraHolder/LockerRoomCamera2.current = true
		q3_first_time = false
	first_try = true
	emit_signal("bullying")
	
	if q3_first_time:
		situation = "It looks like there is bullying going on. \n\nYou just got a text from Manny calling Tom a loser and saying he should quit the team."
	else:
		situation = "It looks like there is bullying going on. \n\nYou just got a text from Manny making fun of Tom's looks."
	option1_button_text = "Remind Manny to be kind"
	option1correct = true
	option2_button_text = "Respond with a laughing emoji"
	option2correct = false
	option3_button_text = "Show your friends so everyone can laugh at Tom"
	option3correct = false
	
	option1_response = "Great choice! It's important to remind bullies to be kind."
	option2_response = "Opps! \n\nLuaghing, even using an emoji, isn't kind. Let's try again."
	option3_response = "Opps! \n\nShowing your friends would spread the bullying instead of stopping it. Let's try again."
	
	
	var learn_more_4 = "Bullying can happen over the phone and by text too. Even if the person isn't there it is still not okay to call someone a mean name. When this happens you should not join in the bullying by laughing or show your friends, even if your friends think it is funny. You should tell the bully to be nice or tell a coach or adult, so they can help stop the bullying."
	$HUD/LearnMore/LearnMoreLabel.set_text(learn_more_4)
	
	$LockerRoomHolder/LockerRoomBullyZone.set_collision_mask_value(0, true)
	_bullying()
	
	
	
func _on_RapidBullyZone_body_entered(body):
	
	emit_signal("stop_flying")
	
	#clear_rapid_array()
		

	
	var learn_more_rapid = "Bullying can be physical, using words, or online. Bullying is unking and hurts others. Bullying usually happens more than one time, and bullies are mean on purpose. This section gave a few examples of bullying. If you are not sure if something is bullying ask a teacher or trusted adult. "
	$HUD/LearnMore/LearnMoreLabel.set_text(learn_more_rapid)
	
		
	$RapidHolder/StartTimer.start()
	
func _add_Situations():
	
	#questionArray.append(instructions)
	
	questionArray.append(question1)
	questionArray.append(question2)
	questionArray.append(question3)
	questionArray.append(question4)
	questionArray.append(question5)
	questionArray.append(question6)
	questionArray.append(question7)
	questionArray.append(question8)
	
	print (str(questionArray))


func _on_StartTimer_timeout():
	print("in the start timer")
	$RapidHolder/StartTimer.stop()
	$RapidHolder/RapidUI.show()
	$RapidHolder/RapidUI/ReadyLabel.set_text("Ready")
	$RapidHolder/RapidUI/ReadyLabel.show()
	$RapidHolder/RapidUI/TimeLabel.hide()
	$RapidHolder/RapidUI/ReadyLabel/ReadySetTimer.start()

func _on_ReadySetTimer_timeout():
	print("ready set timer timeout")
	if readyset > 2:
		readyset = 0
	readyset = readyset +1
	if readyset == 1:
		$RapidHolder/RapidUI/ReadyLabel.set_text("Set")
	if readyset ==2:
		$RapidHolder/RapidUI/ReadyLabel.set_text("Go")
		time = 31
		$RapidHolder/RapidUI/ReadyLabel/ReadySetTimer.stop()
		$RapidHolder/RapidUI/ReadyLabel/ReadySetTimer/GoTimer.start()
		

func _on_GoTimer_timeout():
	$RapidHolder/RapidUI/ReadyLabel/ReadySetTimer/GoTimer.stop()
	$RapidHolder/RapidUI/ReadyLabel.hide()
	$RapidHolder/RapidUI/TimeLabel/TimeTimer.start()
	
	randomize()
	questionArray.shuffle()
	
	
	_set_Question()

func _set_Question():
	
	arrayNum = arrayNum + 1
	if arrayNum < questionArray.size():
		$RapidHolder/BodyRect/SituationsLabel.set_text(str(questionArray[arrayNum]))
	else:
		_rapid_quesitons_done()

func _on_TimeTimer_timeout():
	$RapidHolder/RapidUI/ReadyLabel.hide()
	$RapidHolder/RapidUI/TimeLabel.show()
	$RapidHolder/BodyRect.show()
	$RapidHolder/BodyRect/LaterHolder.show()
	$RapidHolder/DoneRect.hide()
	time = time -1
	$RapidHolder/RapidUI/TimeLabel.set_text(str(time))
	if time == 0:
		_rapid_quesitons_done()

func _rapid_quesitons_done():
	$RapidHolder/RapidUI/TimeLabel/TimeTimer.stop()
	$RapidHolder/BodyRect.hide()
	$RapidHolder/RapidUI.hide()
	if correct > 0 :
		$HUD/WhiteYoureRight.show()
		count = 0
		$HUD/WhiteYoureRight/heartwon2/HeartTimer2.start()
		$HUD/RightAnswer/LifeChangerTimer.start()
		$RapidHolder/DoneRect/WellDoneLabel.set_text("Well done! You got " + str(correct) + " answers correct!")
		rapid = true
		$HUD/WhiteYoureRight/heartwon2/RapidTimer.start()
		life_won = true
		if rapid_first_time:
			rapid_correct1 = correct
			print("in if statement")
			print(str(rapid_correct1))
			Global.rapid_correct1 = rapid_correct1
			rapid_first_time = false
		else:
			rapid_correct2 = correct
			Global.rapid_correct2 = rapid_correct2
		emit_signal("update_document")
	else:
		$RapidHolder/DoneRect/WellDoneLabel.set_text("Opps you didn't get any! Better luck next time!")
	$RapidHolder/DoneRect.show()
	
func _on_RapidTimer_timeout():
	rapid = false
	$HUD/WhiteYoureRight/heartwon2/RapidTimer.stop()

func _on_Yes_pressed():
	#1 2 3 5 8 are bullying - yes is correct
	if questionArray[arrayNum] == "Lisa keeps touching Bri's hair after Bri asked her to stop" or questionArray[arrayNum] == "Mike won't ever let Todd play tag because Todd is in a wheelchair" or questionArray[arrayNum] == "Jen posted a picture online that calls Mea ugly" or questionArray[arrayNum] == "Nick pranks Annie every day by putting her book too high to reach" or questionArray[arrayNum] == "Alex told the whole class that Drew picks his nose, even though its not true":
		correct = correct + 1
		_set_Question()

	else:
		$RapidHolder/BodyRect/SituationsLabel.set_text("Opps! Try Again.\n" + questionArray[arrayNum])

func _on_No_pressed():
	#4 6 7 are not bullying - no is correct
	if questionArray[arrayNum] == question4 or questionArray[arrayNum] == question6 or questionArray[arrayNum] == question7:
		correct = correct + 1
		_set_Question()
	else:
		$RapidHolder/BodyRect/SituationsLabel.set_text("Opps! Try Again.\n" + questionArray[arrayNum])


func _on_Vine_body_entered(body):
	emit_signal("flying")
	emit_signal("player_flying")
	$HallwayHolder.show()

func _on_Vine2_body_entered(body):
	emit_signal("player_flying")
	emit_signal("flying2")
	$BedroomHolder.show()

func _on_ClassroomVine_body_entered(body):
	emit_signal("player_flying")
	emit_signal("flying3")
	$ClassroomHolder.show()


func _on_LockerRoomVine_body_entered(body):
	emit_signal("player_flying")
	emit_signal("flying4")
	$LockerRoomHolder.show()

func _on_RapidVine_body_entered(body):
	emit_signal("player_flying")
	emit_signal("flying5")
	
	
	var instructions = "Answer as many questions as you can in 25 seconds!"
	
	$RapidHolder.show()
	$RapidHolder/BodyRect/LaterHolder.hide()
	$RapidHolder/RapidUI.hide()
	$RapidHolder/DoneRect.hide()
	
func _life_won():
	if Global.lives == 8:
		$HUD/heart9.show()
		$HUD/LivesPanel8.hide()
		$HUD/LivesPanel9.show()
	if Global.lives == 7:
		$HUD/heart8.show()
		$HUD/LivesPanel7.hide()
		$HUD/LivesPanel8.show()
	if Global.lives == 6:
		$HUD/heart7.show()
		$HUD/LivesPanel6.hide()
		$HUD/LivesPanel7.show()
	if Global.lives == 5:
		$HUD/heart6.show()
		$HUD/LivesPanel5.hide()
		$HUD/LivesPanel6.show()
	elif Global.lives == 4:
		$HUD/heart5.show()
		$HUD/LivesPanel5.show()
	elif Global.lives == 3:
		$HUD/heart4.show()
		$HUD/LivesPanel3.hide()
		$HUD/LivesPanel4.show()
	elif Global.lives == 2:
		$HUD/heart3.show()
		$HUD/LivesPanel3.show()
	elif Global.lives == 1:
		$HUD/heart2.show()
	Global.lives = Global.lives + 1
	
func _life_lost():
	Global.lives = Global.lives -1
	if Global.lives == 8:
		$HUD/heart9.hide()
		$HUD/LivesPanel9.hide()
		$Livespanel8.show()
	if Global.lives == 7:
		$HUD/heart8.hide()
		$HUD/LivesPanel8.hide()
		$HUD/LivesPanel7.show()
	if Global.lives == 6:
		$HUD/heart7.hide()
		$HUD/LivesPanel7.hide()
		$HUD/LivesPanel6.show()
	if Global.lives == 5:
		$HUD/heart6.hide()
		$HUD/LivesPanel6.hide()
		$HUD/LivesPanel5.show()
	elif Global.lives == 4:
		$HUD/heart5.hide()
		$HUD/LivesPanel5.hide()
		$HUD/LivesPanel4.show()
	elif Global.lives == 3:
		$HUD/heart4.hide()
		$HUD/LivesPanel4.hide()
		$HUD/LivesPanel3.show()
	elif Global.lives == 2:
		$HUD/heart3.hide()
	elif Global.lives == 1:
		$HUD/heart2.hide()
	elif Global.lives == 0:
		get_tree().change_scene_to_file("res://GameOver.tscn")


func _on_HintArea_body_entered(body):
	$Hint.show()
	$Hint/HintTimer.start()

func _on_HintTimer_timeout():
	$Hint.hide()

func _on_LearnMoreButton_pressed():
	_on_LearnWhyButton_pressed()

func _on_ContinueButton_pressed():
	emit_signal("reset_camera")
	carry_on()
	$RapidHolder/DoneRect/ContinueButton/ContinueTimer.start()

func _on_ContinueTimer_timeout():
	$RapidHolder/DoneRect/ContinueButton/ContinueTimer.stop()
	$RapidHolder.hide()
	
func _on_RapidCameraChangeZone_body_entered(body):	
	if rapid_first_time:
		$RapidHolder/RapidCamera.current= true
		$RapidHolder/RapidCameraChangeZone.set_collision_mask_value(0, false)
	else:
		correct = 0
		$MovedCameraHolder/RapidCamera2.current = true
		$RapidHolder/RapidCameraChangeZone.set_collision_mask_value(0, false)
func _on_EndVine_body_entered(body):
	emit_signal("player_flying")
	emit_signal("flying6")
	
func _on_USResourcesButton_pressed():
	OS.shell_open("https://www.stopbullying.gov/resources/kids")

func _on_IrishResourcesButton_pressed():
	OS.shell_open("https://tacklebullying.ie/about-tackle-bullying/")

func _game_over():
	#This had a collision shape 2D trigger
	emit_signal("stop_flying")
	Global.endTime = Time.get_unix_time_from_system()
	emit_signal("update_document")
	$HUD/WinHolder.show()
	$HUD/WinHolder/YouWin.hide()
	$HUD/WinHolder/LineEdit.hide()
	$HUD/WinHolder/LineEdit2.hide()

func _on_ResourcesButton_pressed():
	$HUD/WinHolder.hide()
	$HUD/ResourcesHolder.show()

func _on_MainMenuButton_pressed():
	get_tree().change_scene_to_file("res://TitleMenu.tscn")

func _on_CreditsButton_pressed():
	get_tree().change_scene_to_file("res://Credits.tscn")


func _fall_reset():
	
	if Global.lives > 1:
		$HUD/RightAnswer/YoureRight.set_text("Opps! Try again")
	
	else:
		$HUD/RightAnswer/YoureRight.set_text("Opps! Game Over")
	$HUD/RightAnswer.show()
	$HUD/RightAnswer/YoureRight/plus.hide()
	$HUD/RightAnswer/YoureRight.show()
	$HUD/RightAnswer/YoureRight/minus.show()
	count = 0
	$HUD/RightAnswer/heartwon.scale.x = 1.54
	$HUD/RightAnswer/heartwon.scale.y = 1.481
	$HUD/RightAnswer/heartwon/HeartTimer.start()
	$HUD/RightAnswer/LifeChangerTimer.start()
	life_won = false
	


func _on_SavePoint1_body_entered(body):
	emit_signal("save_point")
	$SavePoint1.set_collision_mask_value(0, false)

func _on_SavePoint2_body_entered(body):
	emit_signal("save_point")
	$SavePoint2.set_collision_mask_value(0, false)

func _on_SavePoint3_body_entered(body):
	emit_signal("save_point")
	$SavePoint3.set_collision_mask_value(0, false)

func _on_SavePoint4_body_entered(body):
	emit_signal("save_point")
	$SavePoint4.set_collision_mask_value(0, false)

func _on_Bounce_Back_body_entered(body):
	emit_signal("bounce_back")

func _on_Area2D_area_entered(area):
	emit_signal("stop_flying")
	emit_signal("dragon_stop_flying")
	
func _q1_wrong():
	$HallwayHolder.position.x = 4525
	$HallwayHolder.position.y = -589.8
	$LockerRoomHolder/LockerRoomBullyZone.set_collision_mask_value(0, false)

func _q2_wrong():
	$BedroomHolder.position.x = 5000
	$BedroomHolder.position.y = -1009
	$ClassroomHolder/ClassroomBullyZone.set_collision_mask_value(0, false)

func q3_and_q4_wrong():
	$ClassroomHolder.position.x = 9484.9
	$ClassroomHolder.position.y = -1447.8
	$ClassroomHolder.show()
	$LockerRoomHolder/LockerRoomBullyZone.set_collision_mask_value(0,false)


func _dragon_redo():
	if current_question == 3 and q1_redo_needed and q3_first_time:
		emit_signal("flydown4")
		q1_first_time = false
	elif current_question == 4:
		emit_signal("flydown_classroom")
		q2_first_time = false
	elif current_question == 3 and q3_and_q4_redo_needed == true:
		emit_signal("flydown6")
	elif game_over_move_needed == true:
		emit_signal("flydown7")
	
func _on_LockerRoomRedoSignal_body_entered(body):
	if q4_redo_needed == false:
		$HallwayHolder.show() 

	$LockerRoomHolder/LockerRoomRedoSignal.set_collision_mask_value(0, false)
	emit_signal("reset_camera")

func _on_ClassroomRedoSignal2_body_entered(body):
	$BedroomHolder.show()
	$ClassroomHolder/ClassroomRedoSignal2.set_collision_mask_value(0, false)
	emit_signal("reset_camera")

func _on_EndCollisionZone_body_entered(body):
	if q3_redo_needed == false and q4_redo_needed == false:
		print("q3 and q4 rigt")
		$RapidHolder/BodyRect/SituationsLabel.set_text("Read each case and say if it is bullying. Answer as many as you can!")
		$RapidHolder.position.x = 8430.2
		$RapidHolder.position.y = -654.41
		#clear_rapid_array()
		$RapidHolder.show()
		arrayNum = -1
		$RapidHolder/BodyRect.show()
		$RapidHolder/RapidCameraChangeZone.set_collision_mask_value(0, true)
		$RapidHolder/RapidUI/TimeLabel.hide()
		$RapidHolder/BodyRect/LaterHolder.hide()
		$RapidHolder/RapidUI.hide()
		$RapidHolder/DoneRect.hide()
	elif q3_redo_needed == true and q4_redo_needed == false:
		$LockerRoomHolder.position.x = 9410.6
		$LockerRoomHolder.position.y = -122.09
		$LockerRoomHolder.show()
	elif q3_redo_needed == false and q4_redo_needed == true:
		$ClassroomHolder.position.x = 9498.9
		$ClassroomHolder.position.y = -559.17
		$ClassroomHolder.show()
	elif q3_redo_needed == true and q4_redo_needed == true:
		$LockerRoomHolder.position.x = 9410.6
		$LockerRoomHolder.position.y = -122.09
		$LockerRoomHolder.show()
	$EndHolder/EndCollisionZone.set_collision_mask_value(0, false)

func _on_VeryEndCollisionShape_body_entered(body):
	print("entered")
	if q3_redo_needed or q4_redo_needed and final_rapid_complete == false:
		
		$RapidHolder.position.x = 9883.7
		$RapidHolder.position.y = -603.74
		readyset = 0
		time = 31
		correct = 0
		#clear_rapid_array()
		$RapidHolder.show()
		arrayNum = -1
		$RapidHolder/BodyRect/SituationsLabel.set_text("Read each case and say if it is bullying.  Answer as many as you can!")
		$RapidHolder/BodyRect.show()
		$RapidHolder/RapidUI/TimeLabel.hide()
		$RapidHolder/BodyRect/LaterHolder.hide()
		$RapidHolder/RapidUI.hide()
		$RapidHolder/DoneRect.hide()
		$MovedCameraHolder/RapidCamera3/RapidCamera3Timer.start()

		
		game_over_move_needed = true
		$DragonHolder/VeryEndDragon/EndMoveTimer.start()
		final_rapid_complete = true
		$DragonHolder/VeryEndDragon/VeryEndCollisionShape.set_collision_mask_value(0, false)
		$DragonHolder/TestArea.set_collision_mask_value(0, false)
	else:
		_game_over()
		print("else game over")

func _on_RapidCamera3Timer_timeout():
	$MovedCameraHolder/RapidCamera3/RapidCamera3Timer.stop()
	$MovedCameraHolder/RapidCamera3.current = true

func _on_EndMoveTimer_timeout():
	$DragonHolder/YouWinDragon.show()

func _on_VeryEndVine_body_entered(body):
	emit_signal("player_flying")
	emit_signal("flying7")
	#$DragonHolder/VeryEndDragon.set_collision_mask_bit(0, true)

func _on_WinTimer_timeout(): 
	_game_over()

func _on_TestArea_body_entered(body):
	print("in test area")
	_on_VeryEndCollisionShape_body_entered(body)

func _on_YouWinVine_body_entered(body):
	emit_signal("player_flying")
	emit_signal("flying8")
	$DragonHolder/YouWinDragon/WinTimer.start()

func _end_question_answered():
	endArrayNum = endArrayNum + 1
	$HUD/WinHolder/Questions.set_text(endquestionArray[endArrayNum])
	if endArrayNum == 3:
		$HUD/WinHolder/EndYes.hide()
		$HUD/WinHolder/EndNo.hide()
		$HUD/WinHolder/LineEdit.show()
	if endArrayNum == 5:
		$HUD/WinHolder/LineEdit2.hide()
		$HUD/WinHolder/YouWin.show()
		$HUD/WinHolder/ResourcesButton.show()
		$HUD/WinHolder/CreditsButton.show()
	
func _on_EndYes_pressed():
	if endArrayNum == 0:
		Global.endQuestion1Answer = "yes"
	elif endArrayNum == 1:
		Global.endQuestion2Answer = "yes"
	elif endArrayNum ==2:
		Global.endQuestion3Answer = "yes"
	emit_signal("update_document")
	_end_question_answered()
	

func _on_EndNo_pressed():
	if endArrayNum == 0:
		Global.endQuestion1Answer = "no"
	elif endArrayNum == 1:
		Global.endQuestion2Answer = "no"
	elif endArrayNum ==2:
		Global.endQuestion3Answer = "no"
	emit_signal("update_document")
	_end_question_answered()

func _on_EnterButton_pressed():
	if endArrayNum == 3:
		Global.endQuestion4Answer = $HUD/WinHolder/LineEdit.get_text()
		$HUD/WinHolder/LineEdit.hide()
		$HUD/WinHolder/LineEdit2.show()
	if endArrayNum == 4:
		Global.endQuestion5Answer = $HUD/WinHolder/LineEdit.get_text()
	emit_signal("update_document")
	_end_question_answered()




func _on_ResetCollision_body_entered(body):
	$LockerRoomHolder/LockerRoomBullyZone.set_collision_mask_value(0, true)
	$ClassroomHolder/ClassroomBullyZone.set_collision_mask_value(0, true)



