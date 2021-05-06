extends Node

var lista_sons

func _ready():
	play("Musica_menu")


func play(nome_som):
	if has_node(nome_som):
		lista_sons = get_node(nome_som).get_children()
		lista_sons.shuffle()
		lista_sons[0].play()

func stop(nome_som):
	if has_node(nome_som):
		get_node(nome_som).get_child(0).stop()

func comecar_musica_fase(fase_atual):
	if fase_atual <= 5:
		Sist_som.play("Musica_fases_1-5")
	elif fase_atual <= 10:
		Sist_som.play("Musica_fases_6-10")
	elif fase_atual <= 15:
		Sist_som.play("Musica_fases_11-15")
	else:
		# Sist_som.play("Musica_fases_16-20")
		Sist_som.play("Musica_fases_11-15")

func parar_musicas_fase():
	stop("Musica_fases_1-5")
	stop("Musica_fases_6-10")
	stop("Musica_fases_11-15")
	stop("Musica_fases_16-20")

func parar_sons_cutscene():
	stop("Musica_cutscene_normal")
	stop("Musica_cutscene_raiva")
	stop("Dialogo_normal")
	stop("Dialogo_raiva")
