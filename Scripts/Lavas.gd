extends Area2D


func _on_Lavas_body_entered(body):
	$audio_go.play();
	get_tree().reload_current_scene();
