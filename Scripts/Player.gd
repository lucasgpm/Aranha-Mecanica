extends KinematicBody2D

onready var timer = $Timer;
var velocity = Vector2(); #variavel para movimentacao no eixo x e y
var movespeed = 400;
var gravity = 1000;
var jump_force = -720;
var side = 1.25;
var cooldown = 1;
var tempo = 0;
var life = 3;
var knockback_dir;
var hurted = false;
onready var raycasts = $Raycasts;

func _physics_process(delta):
	velocity = move_and_slide(velocity);
	velocity.y += gravity * delta;	
	_get_input();
	_set_animation();
	
	pass;
	
func _get_input():
	velocity.x = 0;
	var move_direction = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"));
	velocity.x = lerp(velocity.x, movespeed * move_direction, 0.2);
	
	if(move_direction != 0):
		side = move_direction / 4.0;
		$Sprite.scale.x = side;
		knockback_dir = move_direction;
		
	pass;

func _input(event):
	if(event.is_action_pressed("jump") && is_grounded()):
		velocity.y = jump_force / 2.8;
		$jumpfx.play();
	
	if(event.is_action_pressed("teleport") && cooldown == 1):
			
		if(velocity.y < 0):
			velocity.y -= 200;
		
		if(velocity.x > 0):
			velocity.x += 2250;
		
		elif(velocity.x < 0):
			velocity.x -= 2250;

		if(velocity.x == 0 && $Sprite.scale.x > 0):
			velocity.x += 2250;
	
		if(velocity.x == 0 && $Sprite.scale.x < 0):
			velocity.x -= 2250;
			
		$telepfx.play();
		cooldown *= -1;
		timer.set_wait_time(1);
		timer.start();
		_on_Timer_timeout();
		pass;
	
	pass;
	
func _on_Timer_timeout():
	tempo += 1;
	if(tempo == 2):
		tempo = 0;
		cooldown *= -1;
		timer.stop();
	
	pass;
		
func is_grounded():
	for raycast in raycasts.get_children():
		if(raycast.is_colliding()):
			return true;
	return false;

func _knockback():
	velocity.y -= 180;
	velocity.x -= 1000 * knockback_dir;
	pass;

func _on_hurtbox_body_entered(body):
	hurted = true;
	life -= 1;
	_knockback();
	get_node("Hurtbox").set_deferred("disabled", true);	
	yield(get_tree().create_timer(0.3), "timeout");
	get_node("Hurtbox").set_deferred("disabled", false)
	hurted = false;
	
	if(life < 1):
		yield(get_tree().create_timer(1.0), "timeout");
		get_tree().reload_current_scene();
	pass;

func _set_animation():
	var animacao = "Idle";
	
	if(!is_grounded()):
		animacao = "Jump";
		
	elif(velocity.x != 0):
		animacao = "Run";
	
	if(hurted):
		animacao = "Dano";
		
	if(animacao == "Idle"):
		$runfx.play()
		
	if(life < 1):
		animacao = "Death";
		velocity.x = 0;
		velocity.y = 0;
		$Sprite.scale.x = 0.25;
	
	else:
		$runfx.stop();
		
	if($Animacao.assigned_animation != animacao):
		$Animacao.play(animacao);


func _on_Tunel_body_entered(body):
	$tunelfx.play();
	pass # Replace with function body.


func _on_final_body_entered(body):
	$coracaofx.play();
	pass # Replace with function body.
