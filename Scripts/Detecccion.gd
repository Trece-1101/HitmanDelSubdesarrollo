extends "res://Scripts/Personaje.gd"

const CDV_TOL_CAMARA = (38 * 0.5)
const RANGO_DETECCION_CAMARA = 345
const ROJO = Color(1, 0.25, 0.25)
const BLANCO = Color(1, 1, 1)

onready var Personaje = Global.PlayerOne

func _ready():
	add_to_group("npc")

func _process(delta):
	detectar()

func detectar():
	if PlayerOne_en_CDV_TOL(CDV_TOL_CAMARA) and PlayerOne_en_LDV(RANGO_DETECCION_CAMARA):
		$HazLuz.color = ROJO
		get_tree().call_group("Sospechometro", "detectado")
	else:
		$HazLuz.color = BLANCO

func PlayerOne_en_CDV_TOL(cdv_tol):
	var direccion = Vector2(1, 0).rotated(global_rotation)
	var distancia = (Personaje.position - global_position).normalized()
	
	if abs(distancia.angle_to(direccion)) < deg2rad(cdv_tol):
		return true
	else:
		return false


func PlayerOne_en_LDV(rango_deteccion):
	var espacio = get_world_2d().direct_space_state
	var LDV_obstaculo = espacio.intersect_ray(global_position, Personaje.global_position, [self], collision_mask)
	var distancia_a_jugador = Personaje.global_position.distance_to(global_position)
	var PlayerOne_en_rango = distancia_a_jugador < rango_deteccion
	
	if not LDV_obstaculo:
		return false
	
	if LDV_obstaculo.collider == Personaje and PlayerOne_en_rango:
		return true
	else:
		return false

func Vision_Nocturna():
	$HazLuz.enabled = false

func Oscuro():
	$HazLuz.enabled = true