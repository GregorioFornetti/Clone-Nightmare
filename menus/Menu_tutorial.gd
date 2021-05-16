extends Control


func _on_Btn_sim_pressed():
	# Iniciar tutorial
	get_tree().change_scene("res://Tutorial/Tutorial.tscn")

func _on_Btn_nao_pressed():
	# Ir para o menu de fases
	get_tree().paused = false
	get_tree().change_scene("res://menus/Menu_geral.tscn")
