extends Control

onready var animation_player = $AnimationPlayer
onready var timer = $Timer_animacao
onready var background = $Background
const FRAME_BACKGROUND_PLAYER = 0
const FRAME_BACKGROUND_CONSCIENCIA = 3

func _ready():
	randomize()

func _on_Btn_jogar_pressed():
	get_tree().change_scene("res://menus/Menu_saves.tscn")

func _on_Btn_sair_pressed():
	get_tree().quit()

func _on_Timer_animacao_timeout():
	if background.frame == FRAME_BACKGROUND_PLAYER:
		if rand_range(1, 100) <= 75:
			animation_player.play("TransicaoParaPlayer")
			timer.start(animation_player.current_animation_length + rand_range(5, 35))
		else:
			animation_player.play("TransicaoParaConsciencia")
			timer.start(animation_player.current_animation_length + rand_range(2, 6))
	else:
		animation_player.play("TransicaoParaPlayer")
		timer.start(animation_player.current_animation_length + rand_range(5, 35))
	
