extends "res://Scripts/Detecccion.gd"

const RANGO_DETECCION_LINTERNA = 320
const COLOR = Color(2, 0.50, 0.50)
const CDV_TOL_LINTERNA = (35 * 0.5)

var mov = Vector2()
var destino_posible = []
var camino = []
var destino = Vector2()

export var caminar_despacio = 0.50
export var parar_navegacion = 5

onready var navegacion = Global.navegacion
onready var destinos_disponibles = Global.destinos

func _ready():
	destino_posible = destinos_disponibles.get_children()
	crear_camino()

func detectar():
	if PlayerOne_en_CDV_TOL(CDV_TOL_LINTERNA) and PlayerOne_en_LDV(RANGO_DETECCION_LINTERNA):
		$HazLuz.color = COLOR
		get_tree().call_group("Sospechometro", "detectado")
	else:
		$HazLuz.color = BLANCO

func _process(delta):
	navegar()
	detectar()

func navegar():
	var distancia_destino = position.distance_to(camino[0])
	destino = camino[0]
	
	if distancia_destino > parar_navegacion:
		moverse()
	else:
		update_camino()

func moverse():
	look_at(destino)
	mov = (destino - position).normalized() * (VEL_MAX * caminar_despacio)
	
	if is_on_wall():
		crear_camino()

	move_and_slide(mov)

func crear_camino():
	randomize()
	var prox_destino = destino_posible[randi() % destino_posible.size()]
	
	camino = navegacion.get_simple_path(position, prox_destino.global_position, false)

func update_camino():
	if camino.size() == 1:
		if $Timer.is_stopped():
			$Timer.start()
	else:
		camino.remove(0)

func _on_Timer_timeout():
	crear_camino()
