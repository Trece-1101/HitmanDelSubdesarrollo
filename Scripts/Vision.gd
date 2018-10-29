extends CanvasModulate

const OSCURO = Color("050b6f")
const VISION_NOCTURNA = Color("45f550")

func _ready():
	add_to_group("interfaz")
	color = OSCURO

func Vision_Nocturna():
	inform_npcs("Vision_Nocturna")
	color = VISION_NOCTURNA
	$AudioStreamPlayer.stream = load(Global.sonido_vision_on)
	play_sonido()
	get_tree().call_group("labels", "show")

func Oscuro():
	inform_npcs("Oscuro")
	color = OSCURO
	$AudioStreamPlayer.stream = load(Global.sonido_vision_off)
	play_sonido()
	get_tree().call_group("labels", "hide")

func play_sonido():
	$AudioStreamPlayer.play()

func inform_npcs(modo_vision):
	get_tree().call_group("npc", modo_vision)