extends CharacterBody2D

var speed = 50
@export var direction = -1 #export keyword puts the variable in the inpector
@export var detects_edge = true
var active

const GRAVITY = 20

func _ready():
	Global.enemy = self
	if direction == 1:
		$EnemySprite.flip_h = true
	$ground_checker.position.x = $EnemyCollisionShape2D.shape.get_area().x * direction
	$ground_checker.enabled = detects_edge
	if detects_edge:
		set_modulate(Color(1.2,0.5,1))

func _physics_process(delta):
	
	if active:
		if is_on_wall() or ! $ground_checker.is_colliding() && detects_edge == true && is_on_floor():
			direction = direction * -1
			$EnemySprite.flip_h = not $EnemySprite.flip_h
			$ground_checker.position.x = $EnemyCollisionShape2D.shape.get_extents().x * direction #raycasts take a lot to run, so best to have one
	
		velocity.y += GRAVITY
		velocity.x = speed * direction
	
		set_velocity(velocity)
		set_up_direction(Vector2.UP)
		move_and_slide()
		velocity = velocity
	
	


func _on_top_checker_body_entered(body):
	$EnemySprite.play("squashed")
	speed = 0
	set_collision_layer_value(4, false)
	set_collision_mask_value(0, false)
	$enemytop_checker.set_collision_layer_value(4, false)
	$enemytop_checker.set_collision_mask_value(0, false)
	$enemysides_checker.set_collision_layer_value(4, false)
	$enemysides_checker.set_collision_mask_value(0, false)

	$Timer.start()
	body.bounce()
	$SoundSquashed.play()

func _on_sides_checker_body_entered(body):
	body.hurt(position.x)
	
func _on_Timer_timeout():
	queue_free()
	
func _hurt():
	direction = direction * -1
	$EnemySprite.flip_h = not $EnemySprite.flip_h
	$ground_checker.position.x = $EnemyCollisionShape2D.shape.get_extents().x * direction #raycasts take a lot to run, so best to have one
	


func _on_VisibilityNotifier2D_viewport_entered(viewport):
	active = true	

func _on_VisibilityNotifier2D_viewport_exited(viewport):
	active = false
