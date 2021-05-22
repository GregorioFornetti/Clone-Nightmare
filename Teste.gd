extends Node2D

func _ready():
	var teste = load("res://Fases/fase1.tscn").instance()
	add_child(teste)
