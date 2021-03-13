extends StaticBody2D

onready var portal_oposto = get_parent().get_node("Portal2")

func retorna_portal_posic_oposto():
	return portal_oposto.global_position
