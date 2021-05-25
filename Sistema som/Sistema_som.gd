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
		play("Musica_fases_1-5")
	elif fase_atual <= 10:
		play("Musica_fases_6-10")
	elif fase_atual <= 15:
		play("Musica_fases_11-15")
	else:
		play("Musica_fases_16-20")

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

func coletar_obj_audio_fase(fase_atual):
	if fase_atual <= 5:
		return $"Musica_fases_1-5/AudioStreamPlayer"
	elif fase_atual <= 10:
		return $"Musica_fases_6-10/AudioStreamPlayer"
	elif fase_atual <= 15:
		return $"Musica_fases_11-15/AudioStreamPlayer"
	else:
		# return $"Musica_fases_16-20/AudioStreamPlayer"
		return $"Musica_fases_11-15/AudioStreamPlayer"
