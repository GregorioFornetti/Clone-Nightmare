extends Node2D

enum {
	ESPERANDO_MOVIMENTACAO,
	ESPERANDO_MOVIMENTACAO_CAMERA,
	ESPERANDO_ZOOM,
	ESPERANDO_MARCA,
	ESPERANDO_TIRO,
	ESPERANDO_VITORIA_INIMIGO_PARADO
}
var estado_atual

var posicao_antiga_camera
var quant_camera_movimentada = 0
onready var camera = $camera

onready var Player = $Player

var zoom_in_alcancado = false
var zoom_out_alcancado = false

var inimigo
var esperando_inimigo_nascer = true
onready var Inimigo_parado_sem_atirar = preload("res://Tutorial/Inimigo_estatico.tscn")
onready var Inimigo_parado_atirando = preload("res://Tutorial/Inimigo_estatico_atira.tscn")
onready var Inimigo_comum = preload("res://Inimigos/enemy.tscn")


onready var label_tutorial = $CanvasTutorialMecanica/Control/Label
onready var label_bg = $CanvasTutorialMecanica/Control/Label_bg

func _process(_delta):
	match estado_atual:
		ESPERANDO_MOVIMENTACAO:
			if Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right") or Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_down"):
				label_tutorial.text = "Muito bem ! Agora vamos movimentar a câmera. Segure o botão esquerdo do mouse e arraste para direção oposta a qual você quer mover a câmera."
				estado_atual = ESPERANDO_MOVIMENTACAO_CAMERA
		
		ESPERANDO_MOVIMENTACAO_CAMERA:
			if camera.antiga_pos_mouse:
				if posicao_antiga_camera:
					quant_camera_movimentada += abs(camera.antiga_pos_mouse.x - posicao_antiga_camera.x) + abs(camera.antiga_pos_mouse.y - posicao_antiga_camera.y)
				posicao_antiga_camera = camera.antiga_pos_mouse
			else:
				posicao_antiga_camera = null
			
			if quant_camera_movimentada >= 500:
				label_tutorial.text = "Vamos utilizar o zoom da camera. Use Ctrl + scroll do mouse para cima para diminuir o zoom, ou use Ctrl + scroll do mouse para baixo para aumentar o zoom. Dê o maximo e o mínimo de zoom possível para continuar."
				estado_atual = ESPERANDO_ZOOM
		
		ESPERANDO_ZOOM:
			if camera.camera_node.zoom.x <= 0.4:
				zoom_in_alcancado = true
			elif camera.camera_node.zoom.x >= 1.5:
				zoom_out_alcancado = true
			
			if zoom_in_alcancado and zoom_out_alcancado:
				label_tutorial.text = "Um clone acabou de aparecer no centro do mapa, vamos eliminá-lo ! Primeiro, clique com o botão direito em cima dele para marcá-lo. Observação: os inimigos possuem contorno em vermelho"
				criar_inimigo(Inimigo_parado_sem_atirar)
				estado_atual = ESPERANDO_MARCA
		
		ESPERANDO_MARCA:
			if Player.alvo:
				label_tutorial.text = "Muito bem, agora aperte ESPAÇO para atirar no inimigo marcado. OBS: é possível marcar apenas um inimigo por vez."
				estado_atual = ESPERANDO_TIRO
		
		ESPERANDO_TIRO:
			if not is_instance_valid(inimigo):
				label_tutorial.text = "Parabéns, você derrotou o seu primeiro inimigo ! Mais um clone aparecerá no centro do mapa, dessa vez ele também irá atirar, então desvie do tiro dele, se não você perde !"
				$TimerSpawnInimigoParado.start()
				estado_atual = ESPERANDO_VITORIA_INIMIGO_PARADO
				
		ESPERANDO_VITORIA_INIMIGO_PARADO:
			if not is_instance_valid(inimigo) and not esperando_inimigo_nascer:
				label_tutorial.text = "Incrível ! Agora vamos para o seu desafio final, mais um clone aparecerá no centro do mapa, só que dessa vez ele irá replicar seus movimentos. Dica: procure bloquear ele nas mesas estão no canto superior esquerdo do mapa."
				$TimerSpawnInimigoComum.start()
				estado_atual = null


func criar_inimigo(node_inimigo):
	inimigo = node_inimigo.instance()
	inimigo.global_position = Vector2(0, 0)
	add_child(inimigo)

func _ready():
	get_tree().paused = true
	$GameStats.quant_balas_em_jogo = -5

func _on_Timer_comecar_timeout():
	label_tutorial.text = "Vamos nos movimentar. Para se mover utilize as teclas WASD."
	estado_atual = ESPERANDO_MOVIMENTACAO

func _on_Tut_interface_acabou_tutorial_interface():
	label_tutorial.text = "Agora vamos ver as mecânicas do jogo ! Siga os passos dos próximos tutoriais para continuar."
	label_bg.visible = true
	$Timer_comecar.start()


func _on_TimerSpawnInimigoParado_timeout():
	criar_inimigo(Inimigo_parado_atirando)
	esperando_inimigo_nascer = false

func _on_TimerSpawnInimigoComum_timeout():
	criar_inimigo(Inimigo_comum)

