extends Area2D;

onready var changer = get_parent().get_node("Transition_in");
export var path : String;

func _on_PassarFase_body_entered(body):
	changer.change_scene(path);
