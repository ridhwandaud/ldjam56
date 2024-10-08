extends Node2D
@onready var animation_player = $AnimationPlayer
@onready var game_manager = $"../GameManager"
@onready var area_2d: Area2D = $Area2D

func show_spike():	
	animation_player.play("spike_show")
	add_to_group("spike")

func hide_spike():
	animation_player.play("spike_hide")
	remove_from_group("spike")
