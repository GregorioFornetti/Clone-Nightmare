extends Node2D

enum {
	ESPERANDO_MOVIMENTACAO,
	ESPERANDO_MOVIMENTACAO_CAMERA,
	ESPERANDO_ZOOM,
	ESPERANDO_MARCA,
	ESPERANDO_TIRO,
	ESPERANDO_VITORIA_INIMIGO_PARADO,
	ESPERANDO_VITORIA_INIMIGO_ANDANDO
}
var estado_atual

var posicao_antiga_camera
var quant_camera_movimentada = 0
onready var camera = $camera

onready var Player = $Player

var zoom_in_alcancado = false
var zoom_out_alcancado = false

onready var label_tutorial = $CanvasTutorialMecanica/Control/Label

func _process(_delta):
	match estado_atual:
		ESPERANDO_MOVIMENTACAO:
			if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_up") or Input.is_action_just_pressed("ui_down"):
				label_tutorial.text = "Muito bem ! Agora vamos movimentar a câmera. Segure o botão esquerdo do mouse e arraste para direção que você quer mover a câmera. Não se esqueça de que você pode desprender a câmera do personagem utilizando a tecla C ou apertando o botão no canto inferior direito do jogo."
				estado_atual = ESPERANDO_MOVIMENTACAO_CAMERA
		ESPERANDO_MOVIMENTACAO_CAMERA:
			if camera.antiga_pos_mouse:
				if posicao_antiga_camera:
					quant_camera_movimentada += abs(camera.antiga_pos_mouse.x - posicao_antiga_camera.x) + abs(camera.antiga_pos_mouse.y - posicao_antiga_camera.y)
				posicao_antiga_camera = camera.antiga_pos_mouse
			else:
				posicao_antiga_camera = null
			
			if quant_camera_movimentada >= 500:
				label_tutorial.text = "Vamos utilizar o zoom da camera. Use Ctrl + scroll do mouse para cima para diminuir o zoom ou use Ctrl + scroll do mouse para baixo para aumentar o zoom. Dê o maximo de zoom in e out possível para continuar."
				estado_atual = ESPERANDO_ZOOM
		ESPERANDO_ZOOM:
			if camera.camera_node.zoom.x <= 0.5:
				zoom_in_alcancado = true
			elif camera.camera_node.zoom.x >= 1.5:
				zoom_out_alcancado = true
			
			if zoom_in_alcancado and zoom_out_alcancado:
				label_tutorial.text = "Um inimigo acabou de aparecer do seu lado, vamos elimina-lo ! Primeiro, clique com o botão direito em cima do inimigo para marca-lo."
				estado_atual = ESPERANDO_MARCA
		ESPERANDO_MARCA:
			if Player.alvo:
				label_tutorial.text = "Muito bem, agora aperte ESPAÇO para atirar no inimigo marcado. OBS: é possível marcar apenas um inimigo por vez."
				estado_atual = ESPERANDO_TIRO
		ESPERANDO_TIRO:
			pass
		ESPERANDO_VITORIA_INIMIGO_PARADO:
			pass
		ESPERANDO_VITORIA_INIMIGO_ANDANDO:
			pass

func _ready():
	get_tree().paused = true


func _on_Timer_comecar_timeout():
	label_tutorial.text = "Vamos nos movimentar. Para se mover utilize as teclas WASD."
	estado_atual = ESPERANDO_MOVIMENTACAO

func _on_Tut_interface_acabou_tutorial_interface():
	label_tutorial.text = "Agora vamos ver as mecânicas do jogo ! Siga os passos dos próximos tutoriais para continuar."
	$Timer_comecar.start()
