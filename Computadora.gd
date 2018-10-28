extends Area2D

var combinacion
var en_rango = false
export var long_combinacion = 4

signal combinacion

func _ready():
	luz_prendida(false)
	generar_combinacion()
	emit_signal("combinacion", combinacion)
	
func generar_combinacion():
	var generador_combinacion = get_tree().get_root().find_node("GeneradorCombinaciones", true, false)
	combinacion = generador_combinacion.generar_combinacion(long_combinacion)
	$CanvasLayer/PopComputadora.set_text(combinacion)

func _on_Computadora_body_entered(body):
	en_rango = true
	luz_prendida(true)


func _on_Computadora_body_exited(body):
	en_rango = false
	luz_prendida(false)
	$CanvasLayer/PopComputadora.hide()


func _input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and en_rango:
		$CanvasLayer/PopComputadora.popup_centered()
		luz_prendida(true)

func luz_prendida(valor):
	$Light2D.enabled = valor