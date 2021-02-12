extends Control


func _on_Btn_jogar_pressed():
	get_tree().change_scene("res://menus/Menu_saves.tscn")

func _on_Btn_sair_pressed():
	get_tree().quit()
