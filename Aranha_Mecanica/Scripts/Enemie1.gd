extends KinematicBody2D

func _physics_process(delta):
	$Animacao.play("Idle");

func _ready():
	pass
