extends Control

var pausado = false
var fase_acabou = false
onready var FASE_ATUAL = get_parent().get_parent().get_node("GameStats").FASE_ATUAL
onready var background_transicao = get_parent().get_node("Transicao")
var player_ganhou = false
var opacidade = 0

func _process(_delta):
	if player_ganhou:
		# Fazer uma transição para cutscene
		opacidade += 0.03
		background_transicao.color = Color(0.08, 0.08, 0.08, opacidade)
		if opacidade >= 1:
			get_tree().change_scene("res://Cutscenes/Dialogo" + str(FASE_ATUAL) + ".tscn")

func _input(event):
	if event.is_action_pressed("ui_cancel") and not fase_acabou:
		pausado = not pausado
		get_tree().paused = pausado
		visible = pausado


func _on_GameStats_acabou_inimigos():
	if not fase_acabou:   # Player ganhou !
		SaveStats.passar_fase()
		player_ganhou = true
		background_transicao.visible = true

func _on_GameStats_acabou_municao():
	if not player_ganhou:
		prender_no_menu()
		adicionar_elementos_derrota('Acabou a sua munição !')


func _on_Player_player_morreu():
	if not player_ganhou:
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


func _on_Btn_Reiniciar_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_Btn_Voltar_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://menus/Menu_fases.tscn")
