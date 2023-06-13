extends CharacterBody2D

var active = false
var speed = 0
var gravity = -150

func _ready():
	Global.dragon = self
	
func _physics_process(delta):
	if active:
		velocity.x= speed
		velocity.y= gravity
		set_velocity(velocity)
		set_up_direction(Vector2.UP)
		move_and_slide()
		velocity = velocity
		velocity.x = lerp (velocity.x,0,0.2)

func _flying():
	active = true
	
func _stop_flying():
	active = false
