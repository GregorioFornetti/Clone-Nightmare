extends StaticBody2D

signal inimigo_morreu

func _ready():
	connect("inimigo_morreu", get_parent().get_node("Player"), '_on_Enemy_death', [self])
	connect("inimigo_morreu", get_parent().get_node('GameStats'), '_on_Enemy_die')

func _on_Hurtbox_area_entered(area):
	Sist_som.play("Morte_inimigo")
	emit_signal("inimigo_morreu")
	queue_free()
