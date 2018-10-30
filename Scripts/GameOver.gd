extends CanvasLayer

var nivelActual
var proxNivel

func _on_Intentar_pressed():
	get_tree().change_scene(Global.nivelActual)


func _on_Salir_pressed():
	get_tree().quit()