extends Sprite2D
@onready var animation_player = $AnimationPlayer
@onready var game_manager = $"../GameManager"

func _process(delta):	
	if game_manager.state == "A":
		animation_player.play("spike_show")
	elif game_manager.state == "B":
		animation_player.play("spike_hide")
	elif game_manager.state == "C":
		animation_player.play("spike_show")
	elif game_manager.state == "D":
		animation_player.play("spike_hide")
