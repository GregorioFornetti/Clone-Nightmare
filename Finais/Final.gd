extends Node2D

onready var final_selecionado = null
onready var transicao_color_rect = $CanvasLayer/Transicao
var final_iniciado = null
var nome_funcao_transicao
var opacidade = 0
var velocidade_transicao = 0.004

enum {FINAL_SUICIDIO = 1, FINAL_BOM, FINAL_IGNORAR}
# FINAL_SUICIDIO : final em que o jogador se mata.
# FINAL_REVELACAO : final em que o jogador se entrega e revela o rastreador da maquina e ajuda a policia
# FINAL_IGNORAR : final em que o jogador ignora tudo e continua a vida, acaba ficando louco no final devido ao sentimento de culpa.
var dic_final = {
	"Player" : FINAL_SUICIDIO,
	"Maquina de clones" : FINAL_BOM,
	"Saida" : FINAL_IGNORAR,
	
	FINAL_SUICIDIO : "transicao_final_suicidio",
	FINAL_BOM : "transicao_final_bom",
	FINAL_IGNORAR : "transicao_final_ignorar"
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
			# Transição para o final está começando...
			transicao_color_rect.visible = true
			final_iniciado = final_selecionado
			nome_funcao_transicao = dic_final[final_selecionado]
			$Player.desmarcar_alvo()


func _on_Player_alvo_marcado(nome_alvo):
	final_selecionado = dic_final[nome_alvo]

func _on_Player_alvo_desmarcado():
	final_selecionado = null


func selecionar_cena_final():
	match final_iniciado:
		FINAL_SUICIDIO:
			get_tree().change_scene("res://Finais/Cutscenes/Cutscene_final_suicidio.tscn")
		FINAL_BOM:
			get_tree().change_scene("res://Finais/Cutscenes/Cutscene_final_bom.tscn")
		FINAL_IGNORAR:
			get_tree().change_scene("res://Finais/Cutscenes/Cutscene_final_ignorar.tscn")

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
