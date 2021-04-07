extends Control

onready var label_principal = $Label
onready var elemento_anterior = $Label
onready var lista_tutorial = [
	"Olá, seja bem vindo ao tutorial ! Aperte ESPAÇO ou clique no botão PRÓXIMO para continuar",
	"Iremos começar vendo um pouco sobre a interface do jogo.",
	$Tut_municao,
	$Tut_inimigos,
	$Tut_botao
]
var indice_elemento_atual = 0
signal acabou_tutorial_interface


func _ready():
	prox_tutorial()

func _input(event):
	if event.get_action_strength("ui_accept"):
		prox_tutorial()
	if event.get_action_strength("ui_cancel"):
		get_tree().paused = true

func prox_tutorial():
	if indice_elemento_atual >= len(lista_tutorial):
		get_tree().paused = false
		emit_signal("acabou_tutorial_interface")
		get_parent().queue_free()
		return
		
	var elemento_atual = lista_tutorial[indice_elemento_atual]
	if typeof(elemento_atual) == TYPE_STRING:
		label_principal.text = elemento_atual
	else:
		elemento_anterior.visible = false
		elemento_atual.visible = true
		elemento_anterior = elemento_atual
	indice_elemento_atual += 1


func _on_Btn_proximo_pressed():
	prox_tutorial()
