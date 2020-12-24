extends KinematicBody2D

export var MAX_VELOCIDADE = 400
var alvo
var vetor_velocidade

func _ready():
	vetor_velocidade = global_position.direction_to(alvo).normalized()
	print(vetor_velocidade * MAX_VELOCIDADE)

func _physics_process(delta):
	move_and_collide(vetor_velocidade * MAX_VELOCIDADE * delta)


func _on_Area2D_body_entered(_body):
	queue_free()

