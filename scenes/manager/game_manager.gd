extends Node2D

var is_restart : bool

func _process(delta):
	if is_restart:
		return
	
	if Input.is_action_pressed("restart"):
		is_restart = true
		get_tree().reload_current_scene()
		
