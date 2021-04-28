extends Control

onready var animation_player = $AnimationPlayer
onready var timer = $Timer_animacao

func _on_Btn_jogar_pressed():
	get_tree().change_scene("res://menus/Menu_saves.tscn")

func _on_Btn_sair_pressed():
	get_tree().quit()

func _on_Timer_animacao_timeout():
	animation_player.play("BackgroundAnim")
	timer.start(animation_player.current_animation_length + rand_range(5, 35))
