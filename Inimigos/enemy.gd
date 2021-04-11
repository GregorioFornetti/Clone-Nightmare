extends "res://Inimigos/enemy_root.gd"

func movimentation():
	vetor_velocidade = -Player.vetor_velocidade * VELOCIDADE_MAX * GameStats.multiplicador_vel
	move_and_slide(vetor_velocidade)
