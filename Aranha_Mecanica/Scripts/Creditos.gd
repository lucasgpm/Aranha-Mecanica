extends Control


func _ready():
	$voltar.grab_focus();
	pass;

func _on_voltar_pressed():
	get_tree().change_scene("res://Scenes/Menu.tscn");
	pass;
