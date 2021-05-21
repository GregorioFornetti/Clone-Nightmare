extends Control

onready var input_senha = $Input_senha
onready var label_senha_incorreta = $Label_senha_incocrreta
onready var timer_apagar_senha_incorreta = $Timer_apagar_senha_incorreta
const SENHA_CORRETA = "15012016"


func _on_Btn_acessar_pressed():
	if input_senha.text == SENHA_CORRETA:
		pass # Jogador conseguiu acessar o final secreto
	else:
		timer_apagar_senha_incorreta.start()
		label_senha_incorreta.visible = true

func _on_Btn_fechar_pressed():
	queue_free()

func _on_Timer_apagar_senha_incorreta_timeout():
	label_senha_incorreta.visible = false
