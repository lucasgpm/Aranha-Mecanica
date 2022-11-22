extends KinematicBody2D

var velocity = Vector2();
var movespeed = 5;

func _physics_process(delta):
	$Animacao.play("Idle");
	velocity = move_and_slide(velocity);
	pass;

#func _on_Animacao_animation_started(anim_name):
#	velocity.y += movespeed;
#	movespeed = -(movespeed);
#	print(velocity.y);
#	pass # Replace with function body.
