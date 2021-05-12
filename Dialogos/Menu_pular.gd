extends Control

onready var dialogo_node = get_parent()

func _on_Btn_sim_pressed():
	get_tree().paused = false
	get_parent().mudar_menu()


func _on_Btn_nao_pressed():
	if dialogo_node.lb_dialogo.percent_visible != 1:
		Sist_som.play(dialogo_node.dic_humor.som)
	get_tree().paused = false
	visible = false
