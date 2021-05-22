extends Control

onready var menu_tutorial = get_node("Menu_tutorial")

func _on_Btn_comecar_pressed():
	menu_tutorial.visible = true
	get_tree().paused = true


func _on_Btn_voltar_pressed():
	# get_tree().change_scene("res://menus/Menu_principal.tscn")
	ComandosGerais.carregar_nova_cena("res://menus/Menu_principal.tscn", self)
