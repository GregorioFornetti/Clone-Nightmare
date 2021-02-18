extends Control


func _on_Btn_prox_pressed():
	get_tree().change_scene("res://Fases/fase" + str(SaveStats.fase_atual + 1) + ".tscn")


func _on_Btn_reiniciar_pressed():
	get_tree().change_scene("res://Fases/fase" + str(SaveStats.fase_atual) + ".tscn")


func _on_Btn_voltar_pressed():
	get_tree().change_scene("res://menus/Menu_fases.tscn")
