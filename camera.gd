extends KinematicBody2D

onready var antiga_pos_mouse
onready var tamanho_colision_inicial = $Camera2D.get_viewport_rect().size / 2
onready var Player = get_parent().get_node('Player')

export (float)var limite_zoom = 1
const LIMITE_ZOOM_IN = Vector2(0.5, 0.5)
var LIMITE_ZOOM_OUT

var focalizar_player = true
signal atualizar_botao_cam

func _ready():
	LIMITE_ZOOM_OUT = Vector2(limite_zoom, limite_zoom)
	$CollisionShape2D.shape.extents = tamanho_colision_inicial


func _physics_process(_delta):
	movimentacao_camera()
	zoom_camera()
	focalizar_player = centralizacao_de_camera()
	
	
func movimentacao_camera():
	if Input.is_action_pressed("mouse_left_click"):
		if not antiga_pos_mouse:
			antiga_pos_mouse = get_viewport().get_mouse_position()
		else:
			move_and_slide((antiga_pos_mouse - get_viewport().get_mouse_position()) * 60)
			antiga_pos_mouse = get_viewport().get_mouse_position()
		return
	elif focalizar_player:
		global_position = Player.global_position
	antiga_pos_mouse = null


func zoom_camera():
	if Input.is_action_pressed("ctrl") and Input.is_action_just_released("zoom_in"):
		if $Camera2D.zoom > LIMITE_ZOOM_IN:
			$Camera2D.zoom -= Vector2(0.1, 0.1)
	elif Input.is_action_pressed("ctrl") and Input.is_action_just_released("zoom_out"):
		if $Camera2D.zoom < LIMITE_ZOOM_OUT:
			$Camera2D.zoom += Vector2(0.1, 0.1)
	$CollisionShape2D.shape.extents = tamanho_colision_inicial * $Camera2D.zoom
	move_and_collide(Vector2.ZERO)


func centralizacao_de_camera():
	# Inverte o valor booleano de focalizar player se a tecla "C" for clicada.
	if Input.is_action_just_pressed("camera_center"):
		emit_signal("atualizar_botao_cam")
		return not focalizar_player
	return focalizar_player


func _on_BotaoCentralizarCam_pressed():
	print('oi')
	focalizar_player = not focalizar_player
