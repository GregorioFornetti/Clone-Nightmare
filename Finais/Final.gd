extends Node2D

onready var final_selecionado = null
onready var transicao_color_rect = $CanvasLayer/Transicao
var final_iniciado = null
var nome_funcao_transicao
var opacidade = 0
var velocidade_transicao = 0.004
var possivel_fechar = true

enum {FINAL_SUICIDIO = 1, FINAL_BOM, FINAL_IGNORAR, FINAL_SECRETO}
# FINAL_SUICIDIO : final em que o jogador se mata.
# FINAL_REVELACAO : final em que o jogador se entrega e revela o rastreador da maquina e ajuda a policia
# FINAL_IGNORAR : final em que o jogador ignora tudo e continua a vida, acaba ficando louco no final devido ao sentimento de culpa.
const dic_final = {
	"Player" : FINAL_SUICIDIO,
	"Maquina de clones" : FINAL_BOM,
	"Saida" : FINAL_IGNORAR,
	
	FINAL_SUICIDIO : "transicao_final_suicidio",
	FINAL_BOM : "transicao_final_bom",
	FINAL_IGNORAR : "transicao_final_ignorar",
	FINAL_SECRETO : "transicao_final_secreto"
}

func _process(_delta):
	if final_iniciado:
		call(nome_funcao_transicao)


func _input(event):
	if event.get_action_strength("ui_accept") and not final_iniciado:
		match final_selecionado:
			FINAL_SUICIDIO:
				SaveStats.liberar_final_suicidio()
			FINAL_BOM:
				SaveStats.liberar_final_bom()
			FINAL_IGNORAR:
				SaveStats.liberar_final_ignorar()
		
		if final_selecionado:
			iniciar_final()
	
	if event.get_action_strength("ui_cancel") and possivel_fechar:
		ComandosGerais.carregar_nova_cena("res://menus/Menu_geral.tscn", self)


func _on_Player_alvo_marcado(nome_alvo):
	final_selecionado = dic_final[nome_alvo]

func _on_Player_alvo_desmarcado():
	final_selecionado = null


func iniciar_final():
	transicao_color_rect.visible = true
	final_iniciado = final_selecionado
	nome_funcao_transicao = dic_final[final_selecionado]
	$Fase/Player.desmarcar_alvo()

func selecionar_cena_final():
	match final_iniciado:
		FINAL_SUICIDIO:
			ComandosGerais.carregar_nova_cena("res://Finais/Cutscenes/Cutscene_final_suicidio.tscn", self)
			# get_tree().change_scene("res://Finais/Cutscenes/Cutscene_final_suicidio.tscn")
		FINAL_BOM:
			ComandosGerais.carregar_nova_cena("res://Finais/Cutscenes/Cutscene_final_bom.tscn", self)
			# get_tree().change_scene("res://Finais/Cutscenes/Cutscene_final_bom.tscn")
		FINAL_IGNORAR:
			ComandosGerais.carregar_nova_cena("res://Finais/Cutscenes/Cutscene_final_ignorar.tscn", self)
			# get_tree().change_scene("res://Finais/Cutscenes/Cutscene_final_ignorar.tscn")
		FINAL_SECRETO:
			ComandosGerais.carregar_nova_cena("res://Finais/Cutscenes/Cutscene_final_secreto.tscn", self)
			# get_tree().change_scene("res://Finais/Cutscenes/Cutscene_final_secreto.tscn")

func transicao_padrao():
	opacidade += velocidade_transicao
	transicao_color_rect.color = Color(0, 0, 0, opacidade)
	if opacidade >= 1:
		selecionar_cena_final()

# As funções abaixo estarão no process, então serão executadas várias vezes...
func transicao_final_suicidio():
	transicao_padrao()

func transicao_final_bom():
	transicao_padrao()

func transicao_final_ignorar():
	transicao_padrao()

func transicao_final_secreto():
	transicao_padrao()


func _on_Range_pc_body_entered(_body):
	final_selecionado = null

