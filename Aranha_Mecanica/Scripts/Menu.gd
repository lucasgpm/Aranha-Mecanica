extends Control


func _ready():
	$container/iniciar.grab_focus();
	pass;


func _on_iniciar_pressed():
	get_tree().change_scene("res://Scenes/level01.tscn");


func _on_como_jogar_pressed():
	get_tree().change_scene("res://Scenes/tutorial.tscn");
	pass;


func _on_creditos_pressed():
	get_tree().change_scene("res://Scenes/Creditos.tscn");
	pass;
