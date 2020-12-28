extends ProgressBar

func _process(_delta):
	if ReloadTimer.time_left == 0:
		self.visible = false
	else:
		self.value = 1.5 - ReloadTimer.time_left
		self.visible = true
