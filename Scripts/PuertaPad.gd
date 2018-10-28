extends "res://Scripts/Puerta.gd"

#var combinacion = [4, 1, 5]
var combinacion

func _ready():
	pass
	
func _input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and en_rango:
		$CanvasLayer/NumPad.popup_centered()

func _on_Puerta_body_exited(body):
	if body == Global.PlayerOne:
		en_rango = false
		$CanvasLayer/NumPad.hide()
		$CanvasLayer/NumPad.reset()

func _on_NumPad_combinacion_correcta():
	abrir()


func _on_Computadora_combinacion(numeros):
	combinacion = numeros
	$CanvasLayer/NumPad.combinacion = combinacion


func _on_Salida_body_entered(body):
	if body == Global.PlayerOne:
		abrir()
