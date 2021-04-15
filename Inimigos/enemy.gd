extends "res://Inimigos/enemy_root.gd"

func on_ready():
	Tiro_inimigo = preload('res://Inimigos/enemy_bullet.tscn')

func movimentation():
	vetor_velocidade = -Player.vetor_velocidade * VELOCIDADE_MAX * GameStats.multiplicador_vel * mult_esteira
	move_and_slide(vetor_velocidade)
