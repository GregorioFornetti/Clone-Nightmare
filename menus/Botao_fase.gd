extends Button

onready var background = $Background


func _ready():
	pass # Replace with function body.


func desabilitar():
	$Trancar.visible = true
	disabled = true


func _on_Btn_fase_mouse_entered():
	background.frame = 1

func _on_Btn_fase_mouse_exited():
	background.frame = 0
