extends Node2D

var is_restart : bool

@export var state: String = "A"

signal state_changed(new_state)

func _process(delta):
	if is_restart:
		return
	
	if Input.is_action_pressed("restart"):
		is_restart = true
		get_tree().reload_current_scene()
	
func changeState(changeState: String):
	print("changeState", changeState)
	state = changeState
	emit_signal("state_changed", state)
