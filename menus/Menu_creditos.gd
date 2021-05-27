extends Control


func _on_Btn_voltar_pressed():
	ComandosGerais.carregar_nova_cena("res://menus/Menu_principal.tscn", self)
