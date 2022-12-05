extends KinematicBody2D
class_name enemyBase

export var speed = 32;
export var health = 2;
var velocity = Vector2();
var move_direction = -1;
var gravity = 5000;
var hitted = false;
var animacao = "Idle";

func _physics_process(delta):
	velocity.x = speed * move_direction;
	if(animacao == "Death"):
		velocity.x = 0;
	velocity = move_and_slide(velocity);
		
	if(move_direction == 1):
		$Sprite.flip_h = false;
	else:
		$Sprite.flip_h = true;
		
	_set_animation(animacao);
		
	pass;

func gravidade(delta):
	velocity.y = gravity * delta;

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
		animacao = "Death";
		_set_animation(animacao);
		get_node("Hitbox").set_deferred("disabled", true);
		yield(get_tree().create_timer(1.0), "timeout");
		queue_free();
			
func _set_animation(animacao):
	
	if(velocity.x != 0 && animacao != "Death"):
		animacao = "Run";
		
	if(hitted == true):
		animacao = "Hurt";
	
	if($Animation.assigned_animation != animacao):
		$Animation.play(animacao);
	
