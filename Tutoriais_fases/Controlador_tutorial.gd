extends Control

onready var pause = get_parent().get_parent().get_node("CanvasLayer").get_node("Pause")
onready var lista_tutoriais
onready var btn_voltar = $Btn_voltar
onready var btn_proximo = $Btn_proximo
var indice_tutorial = 0

func _ready():
	lista_tutoriais = get_node("Lista_tutoriais").get_children()
	pause.desabilitado = true
	get_tree().paused = true


func _input(event):
	if event.get_action_strength("ui_accept"):
		finalizar_tutorial()
	elif event.get_action_strength("ui_right"):
		proximo_tutorial()
	elif event.get_action_strength("ui_left"):
		voltar_tutorial()


func finalizar_tutorial():
	get_tree().paused = false
	pause.desabilitado = false
	get_parent().queue_free()

func proximo_tutorial():
	if indice_tutorial == len(lista_tutoriais) - 1:
		finalizar_tutorial()
	else:
		lista_tutoriais[indice_tutorial].visible = false
		indice_tutorial += 1
		lista_tutoriais[indice_tutorial].visible = true
		
		if indice_tutorial == len(lista_tutoriais) - 1:
			btn_proximo.text = "Começar fase"
		
		btn_voltar.disabled = false

func voltar_tutorial():
	if indice_tutorial != 0:
		lista_tutoriais[indice_tutorial].visible = false
		indice_tutorial -= 1
		lista_tutoriais[indice_tutorial].visible = true
		
		if indice_tutorial == 0:
			btn_voltar.disabled = true
			
		btn_proximo.text = "Próximo"


func _on_Btn_exit_pressed():
	finalizar_tutorial()

func _on_Btn_proximo_pressed():
	proximo_tutorial()

func _on_Btn_voltar_pressed():
	voltar_tutorial()
