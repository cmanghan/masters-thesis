extends CharacterBody2D

@export var flipped = false

var velocity = Vector2(1,0)
var active = false
var speed = -60
var gravity = 10


func _ready():
	if flipped:
		$BirdSprite.flip_h = false
		speed = speed * -1
	
func _physics_process(delta):
	if active:
		velocity.x= speed
		velocity.y= gravity
		set_velocity(velocity)
		set_up_direction(Vector2.UP)
		move_and_slide()
		velocity = velocity
		velocity.x = lerp (velocity.x,0,0.2)
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	
func _on_VisibilityNotifier2D_screen_entered():
	active = true
