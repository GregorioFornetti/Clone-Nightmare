extends TileMap

onready var Area_esteira_direita = preload("res://Esteiras/Area_esteira_direita.tscn")
onready var Area_esteira_esquerda = preload("res://Esteiras/Area_esteira_esquerda.tscn")
onready var Area_esteira_cima = preload("res://Esteiras/Area_esteira_cima.tscn")
onready var Area_esteira_baixo = preload("res://Esteiras/Area_esteira_baixo.tscn")
var area_esteira

enum {ESTEIRA_PARA_DIREITA,
	  ESTEIRA_PARA_BAIXO,
	  ESTEIRA_PARA_ESQUERDA,
	  ESTEIRA_PARA_CIMA}


func _ready():
	var vetor_posics_esteiras = get_used_cells()
	for posic_esteira in vetor_posics_esteiras:
		var id_esteira_atual = get_cell(posic_esteira.x, posic_esteira.y)
		match id_esteira_atual:
			ESTEIRA_PARA_DIREITA:
				area_esteira = Area_esteira_direita.instance()
			ESTEIRA_PARA_BAIXO:
				area_esteira = Area_esteira_baixo.instance()
			ESTEIRA_PARA_ESQUERDA:
				area_esteira = Area_esteira_esquerda.instance()
			ESTEIRA_PARA_CIMA:
				area_esteira = Area_esteira_cima.instance()
		area_esteira.global_position = Vector2(posic_esteira.x * cell_size.x, posic_esteira.y * cell_size.y)
		get_parent().call_deferred("add_child", area_esteira)
