extends Popup

var combinacion = []
var ingreso = []

signal combinacion_correcta()

onready var display = $VSplitContainer/DisplayC/Display
onready var botones = $VSplitContainer/BotonC/Botones
onready var luz = $VSplitContainer/BotonC/Botones/TextureRect

func _ready():
	reset()
	conectar_botones()

func conectar_botones():
	for boton in botones.get_children():
		if boton is Button:
			boton.connect("pressed", self, "_on_Button_pressed", [boton.text])
			#print(boton.text)
			
func _on_Button_pressed(boton):
	if boton == "OK":
		chequear()
	else:
		enter(int(boton))

func chequear():
	if ingreso == combinacion:
		$AudioStreamPlayer.stream = load("res://SFX/threeTone1.ogg")
		$AudioStreamPlayer.play()
		luz.texture = load(Global.luz_verde)
		$Timer.start()
	else:
		reset()

func enter(boton):
	$AudioStreamPlayer.stream = load("res://SFX/twoTone1.ogg")
	$AudioStreamPlayer.play()
	ingreso.append(boton)
	update_display()

func reset():
	luz.texture = load(Global.luz_roja)
	display.clear()
	ingreso.clear()

func update_display():
	display.bbcode_text = "[center]" + PoolStringArray(ingreso).join("") + "[/center]"
	if ingreso.size() == combinacion.size():
		chequear()

func _on_Timer_timeout():
	emit_signal("combinacion_correcta")
	hide()
	reset()
