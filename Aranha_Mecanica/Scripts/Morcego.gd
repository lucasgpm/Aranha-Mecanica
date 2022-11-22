extends KinematicBody2D

export var speed = 32;
export var health = 2;
var velocity = Vector2();
var move_direction = -1;
var gravity = 5000;
var hitted = false;

func _physics_process(delta):
	velocity.x = speed * move_direction;
	velocity.y = gravity * delta;
	velocity = move_and_slide(velocity);
		
	if(move_direction == 1):
		$Sprite.flip_h = false;
	else:
		$Sprite.flip_h = true;
		
	_set_animation();
		
	pass;

func _on_Animation_animation_finished(anim_name):
	if(anim_name == "Idle"):
		$Sprite.flip_h != $Sprite.flip_h;
		$WallDetect.scale.x *= -1;
		move_direction *= -1;
		$Animation.play("Run");


func _on_Hitbox_body_entered(body):
	hitted = true;
	health -= 1;
	body.velocity.y -= 200;
	yield(get_tree().create_timer(0.2), "timeout");
	hitted = false;
	if(health < 1):
		queue_free();
		get_node("Collision").set_deferred("disabled", true);
			
func _set_animation():
	var animacao = "Idle";
	
	if(velocity.x != 0):
		animacao = "Run";
		
	if(hitted == true):
		animacao = "Idle";
	
	if($Animation.assigned_animation != animacao):
		$Animation.play(animacao);
	
