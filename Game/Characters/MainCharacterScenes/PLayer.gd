extends CharacterBody2D

var velocity = Vector2(0,0)
var coins = 0
@export var playing = true
var flying = false
var game_over = false

const SPEED = 180
const JUMP_FORCE = -900
const GRAVITY = 30

signal life_lost
signal hurt
signal fall


var vector_array_x =[0,-293, 1789, 3297, 6633, 8196]
var vector_array_y = [0,94, 333, 148, 135, 97]
var num= 0

func _ready():
	connect("life_lost", Callable(Global.level1, "_life_lost"))
	connect("hurt", Callable(Global.enemy, "_hurt"))
	connect("fall", Callable(Global.level1, "_fall_reset"))
	
func _on_Fall_Zone_body_entered(body): 
	$SoundFall.play()
	await $SoundFall.finished 
	if Global.lives > 1:
		var x = vector_array_x[num]
		var y = vector_array_y[num]
		self.position = Vector2(x,y)
	emit_signal("fall")

func _save_point():
	num = num + 1

func _physics_process(delta):
	#game loop - any code in this function will get run 60 times per second 
	if playing:
		if Input.is_action_pressed("right"):
			velocity.x=SPEED
			$Sprite2D.play("walk")
			$Sprite2D.flip_h = false
		elif Input.is_action_pressed("left"):
			velocity.x=-SPEED
			$Sprite2D.play("walk")
			$Sprite2D.flip_h = true
		else:
			$Sprite2D.play("idle")
		velocity.y = velocity.y + GRAVITY
	
		if not is_on_floor():
			$Sprite2D.play("air")
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_FORCE
			$SoundJump.play()
		
		set_velocity(velocity)
		set_up_direction(Vector2.UP)
		move_and_slide()
		velocity = velocity #tells the character to move, set to velocity to return the new speed, Vector2.UP is (0-1)
	
		velocity.x = lerp (velocity.x,0,0.2) #linear interperlation (make small changes over time)
	if flying:
		velocity.y = -150
		velocity.x = 0
		set_velocity(velocity)
		set_up_direction(Vector2.UP)
		move_and_slide()
		velocity = velocity #tells the character to move, set to velocity to return the new speed, Vector2.UP is (0-1)

func bounce():
	velocity.y = JUMP_FORCE * .6

func hurt (enemyposx):
	emit_signal("hurt")
	set_modulate(Color(1,.3,.3))
	velocity.y = JUMP_FORCE * .3
	
	if position.x < enemyposx:
		velocity.x = -800
	elif position.x > enemyposx:
		velocity.x = 800
	#need to disable input so it doesn't override
	Input.action_release("left")
	Input.action_release("right")
	$HitTimer.start()
	$SoundHurt.play()

func _on_HitTimer_timeout():
	$HitTimer.stop()
	emit_signal("life_lost")
	set_modulate(Color(1,1,1))
	
func _bullying():
	$Sprite2D.play("idle")
	playing = false

func _carry_on():
	#set playing back to true after user answers correctly
	playing = true
	
func _flying():
	$Sprite2D.play("fly")
	playing = false
	flying = true

func _stop_flying():
	flying = false
	$Sprite2D.play("idle")
	
func _reset_camera():
	$Camera2D.current = true

func _game_over():
	game_over = true

func _bounce_back():
	Input.action_release("left")
	Input.action_release("right")
	velocity.x = -800
	
