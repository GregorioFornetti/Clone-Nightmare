extends Control

var pausado = false
var player_perdeu = false
var desabilitado = false
onready var GameStats = get_parent().get_parent().get_node("GameStats")
onready var FASE_ATUAL = get_parent().get_parent().get_node("GameStats").FASE_ATUAL
onready var background_transicao = get_parent().get_node("Transicao")
onready var Menu_opcoes = preload("res://menus/Menu_opcoes.tscn")
var acabou_inimigos = false
var opacidade = 0
var volume_atual = 0
var audio_fase

func _process(_delta):
	if acabou_inimigos and not player_perdeu and GameStats.quant_balas_em_jogo == 0:
		# Fazer uma transição para cutscene
		if not desabilitado:
			desabilitado = true
			SaveStats.passar_fase()
			background_transicao.visible = true
			audio_fase = Sist_som.coletar_obj_audio_fase(FASE_ATUAL)
			Sist_som.play("Alarme")
		opacidade += 0.004
		background_transicao.color = Color(0.08, 0.08, 0.08, opacidade)
		audio_fase.volume_db -= 0.1
		if opacidade >= 1:
			Sist_som.parar_musicas_fase()
			audio_fase.volume_db = 0
			if FASE_ATUAL == 0:
				Sist_som.play("Musica_menu")
				get_tree().change_scene("res://Tutorial/Menu_final_tutorial.tscn")
			else:
				get_tree().change_scene("res://Dialogos/Dialogo-root.tscn")

func _input(event):
	if event.is_action_pressed("ui_cancel") and not desabilitado and not has_node("Menu_opcoes"):
		pausado = not pausado
		get_tree().paused = pausado
		visible = pausado


func _on_GameStats_acabou_inimigos():
	acabou_inimigos = true

func _on_GameStats_acabou_municao():
	if not acabou_inimigos:
		prender_no_menu()
		adicionar_elementos_derrota('Acabou a sua munição !')


func _on_Player_player_morreu():
	player_perdeu = true
	prender_no_menu()
	adicionar_elementos_derrota('Você tomou um tiro !')


func prender_no_menu():
	# Pausa o jogo e não deixa o botão de pause funcionar mais. Fica preso no menu de pause até selecionar uma opção...
	desabilitado = true
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
	Sist_som.parar_musicas_fase()
	Sist_som.play("Musica_menu")
	get_tree().change_scene("res://menus/Menu_fases.tscn")

func _on_Btn_Opcoes_pressed():
	var menu_opcoes = Menu_opcoes.instance()
	add_child(menu_opcoes)
