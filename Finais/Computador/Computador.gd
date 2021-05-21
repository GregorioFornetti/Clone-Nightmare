extends Control

onready var dentro = $Dentro
onready var Senha_registros = preload("res://Finais/Computador/Senha_registros.tscn")
onready var Txt_enigma_senha = preload("res://Finais/Computador/Txt_enigma_senha.tscn")
onready var Novo_jogo = preload("res://menus/Menu_principal.tscn")


func _on_Btn_desligar_pressed():
	visible = false
	get_tree().paused = false

func _on_Btn_registros_pressed():
	var senha_registros = Senha_registros.instance()
	dentro.add_child(senha_registros)

func _on_Btn_senha_pressed():
	var txt_senha = Txt_enigma_senha.instance()
	dentro.add_child(txt_senha)

func _on_Btn_jogo_clone_pressed():
	var novo_jogo = Novo_jogo.instance()
	dentro.add_child(novo_jogo)
