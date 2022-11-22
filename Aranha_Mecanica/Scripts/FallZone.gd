extends Area2D


func _ready():
	pass


func _on_FallZone_body_entered(body):
	$audio_go.play();
	get_tree().reload_current_scene();
