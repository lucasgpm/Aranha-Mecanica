extends KinematicBody2D

export var speed = 32;
export var health = 3;
var velocity = Vector2();
var move_direction = -1;

func _physics_process(delta):
	velocity.x = speed * move_direction;
	velocity = move_and_slide(velocity);
	
	if(move_direction == 1):
		$Sprite.flip_h = false;
	else:
		$Sprite.flip_h = true;
		
	if($WallDetect.is_colliding()):
		$Animation.play("Idle");



func _on_Animation_animation_finished(anim_name):
	if(anim_name == "Idle"):
		$Sprite.flip_h != $Sprite.flip_h;
		$WallDetect.scale.x *= -1;
		move_direction *= -1;
		$Animation.play("Run");
