extends CanvasLayer



func _on_btnTutorial_pressed():
	get_tree().change_scene("res://Escenas/Niveles/Tutorial.tscn")


func _on_btnEmpezar_pressed():
	get_tree().change_scene("res://Escenas/Niveles/Nivel1.tscn")


func _on_btnSalir_pressed():
	get_tree().quit()
