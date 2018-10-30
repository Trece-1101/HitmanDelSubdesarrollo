extends CanvasLayer



func _on_Intentar_pressed():
	get_tree().change_scene("res://Escenas/Niveles/Nivel1.tscn")


func _on_Salir_pressed():
	get_tree().quit()
