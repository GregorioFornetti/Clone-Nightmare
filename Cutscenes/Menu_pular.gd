extends Control


func _on_Btn_sim_pressed():
	get_tree().paused = false
	get_parent().mudar_menu()


func _on_Btn_nao_pressed():
	get_tree().paused = false
	visible = false
