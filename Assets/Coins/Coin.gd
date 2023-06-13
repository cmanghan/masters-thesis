extends Area2D

signal coin_collected 

func _on_Coin_body_entered(body):
	$AnimationPlayer.play("Bounce")
	emit_signal("coin_collected")
	set_collision_mask_value(0, false)
	$SoundCoinCollect.play()

func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
