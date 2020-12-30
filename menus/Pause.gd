extends Control

var pausado = false
var fase_acabou = false

func _input(event):
	if event.is_action_pressed("ui_cancel") and not fase_acabou:
		pausado = not pausado
		get_tree().paused = pausado
		visible = pausado


func _on_GameStats_acabou_inimigos():
	if not fase_acabou:
		prender_no_menu()
		$Btn_Prox.visible = true
		$TituloPause.text = 'Você ganhou !'

func _on_GameStats_acabou_municao():
	prender_no_menu()
	adicionar_elementos_derrota('Acabou a sua munição !')


func _on_Player_player_morreu():
	prender_no_menu()
	adicionar_elementos_derrota('Você tomou um tiro !')


func prender_no_menu():
	# Pausa o jogo e não deixa o botão de pause funcionar mais. Fica preso no menu de pause até selecionar uma opção...
	fase_acabou = true
	get_tree().paused = true
	visible = true

func adicionar_elementos_derrota(motivo_derrota):
	$MotivoMorte.visible = true
	$MotivoMorte.text = motivo_derrota
	$TituloPause.text = 'Você perdeu'



func _on_Btn_Prox_pressed():
	print('prox fase')


func _on_Btn_Reiniciar_pressed():
	print('reiniciar')


func _on_Btn_Voltar_pressed():
	print('Voltar')
