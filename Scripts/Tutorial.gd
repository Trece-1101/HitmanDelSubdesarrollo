extends Node2D

var num = 0

var texto

func _ready():
	texto = get_json()
	mover_pos_objetivo(num)
	$GUITutorial/Popup.show()
	Global.nivelActual = "res://Escenas/Niveles/Tutorial.tscn"
	Global.proxNivel = "res://Escenas/Niveles/Nivel1.tscn"

func mover_pos_objetivo(num):
	var puntero = $Objetivo
	var marcador = $Objetivos.get_child(num)
	#puntero.position = marcador.position
	$Tween.interpolate_property(puntero, "position", puntero.position, marcador.position,
			0.5, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	$Tween.start()
	$AudioStreamPlayer.play()
	$GUITutorial/AnimationPlayer.play("tranMensaje")
	$GUITutorial/Popup/Label.text = texto[str(num)]

func _on_ObjetivoMoverse_body_entered(body):
	mover_pos_objetivo(1)


func _on_ObjetivoPuerta_body_entered(body):
	mover_pos_objetivo(2)


func _on_ObjetivoVision_body_entered(body):
	mover_pos_objetivo(3)


func _on_ObjetivoLoot_body_entered(body):
	mover_pos_objetivo(4)

func get_json():
	var archivo = File.new()
	archivo.open(Global.mensajes_tutorial, archivo.READ)
	var contenido = archivo.get_as_text()
	archivo.close()
	return parse_json(contenido)