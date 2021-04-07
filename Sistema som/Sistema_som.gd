extends Node

var lista_sons

func play(nome_som):
	if has_node(nome_som):
		lista_sons = get_node(nome_som).get_children()
		lista_sons.shuffle()
		lista_sons[0].play()

func stop(nome_som):
	if has_node(nome_som):
		get_node(nome_som).get_child(0).stop()
