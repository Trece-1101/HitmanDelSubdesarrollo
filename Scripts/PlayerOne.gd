extends "res://Scripts/Personaje.gd"

var mov = Vector2()
var modo_vision_enfriamiento = false
var disfraz = false
export var num_disfraz = 3
export var duracion_disfraz = 5
export var lentitud_disfraz = 0.5
var vel_multi = 1
var modo_vision_actual

enum modo_vision {OSCURO, VISION_NOCTURNA}

func _ready():
	Global.PlayerOne = self
	modo_vision_actual = modo_vision.OSCURO
	$Timer.wait_time = duracion_disfraz
	update_disfraz_display()
	normal()

func _process(delta):
	update_mov(delta)
	move_and_slide(mov * vel_multi)
	if disfraz:
		$Label.rect_rotation = - rotation_degrees
		$Label.text = str($Timer.time_left).pad_decimals(2)


func update_mov(delta):
	look_at(get_global_mouse_position())	
	
	if Input.is_action_pressed("ui_sprint"):
		if Input.is_action_pressed("ui_up") and not Input.is_action_pressed("ui_down"):
			mov.y = clamp((mov.y - VEL), -VEL_SPRINT, 0)
			#print(mov.y)
		elif Input.is_action_pressed("ui_down") and not Input.is_action_pressed("ui_up"):
			mov.y = clamp((mov.y + VEL), 0, VEL_SPRINT)
			#print(mov.y)
		else:
			mov.y = lerp(mov.y, 0, FRICCION_SPRINT)
	
		if Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
			mov.x = clamp((mov.x + VEL), 0, VEL_SPRINT)
			#print(mov.x)
		elif Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
			mov.x = clamp((mov.x - VEL), -VEL_SPRINT, 0)
			#print(mov.x)
		else:
			mov.x = lerp(mov.x, 0, FRICCION_SPRINT)
	else:
		if Input.is_action_pressed("ui_up") and not Input.is_action_pressed("ui_down"):
			mov.y = clamp((mov.y - VEL), -VEL_MAX, 0)
			#print(mov.y)
		elif Input.is_action_pressed("ui_down") and not Input.is_action_pressed("ui_up"):
			mov.y = clamp((mov.y + VEL), 0, VEL_MAX)
			#print(mov.y)
		else:
			mov.y = lerp(mov.y, 0, FRICCION)
	
		if Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
			mov.x = clamp((mov.x + VEL), 0, VEL_MAX)
			#print(mov.x)
		elif Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
			mov.x = clamp((mov.x - VEL), -VEL_MAX, 0)
			#print(mov.x)
		else:
			mov.x = lerp(mov.x, 0, FRICCION)


func _input(event):
	if Input.is_action_pressed("ui_modo_vision"):
		if modo_vision_actual == modo_vision.OSCURO:
			cambiar_modo_vision()
	
	if Input.is_action_pressed("ui_disfraz"):
		cambiar_disfraz()


func _on_VisionTimer_timeout():
	cambiar_modo_vision()

func cambiar_modo_vision():
	if modo_vision_actual == modo_vision.OSCURO:
		#print("start")
		$VisionTimer.start()
		get_tree().call_group("interfaz", "Vision_Nocturna")
		modo_vision_actual = modo_vision.VISION_NOCTURNA
	elif modo_vision_actual == modo_vision.VISION_NOCTURNA:
		#print("stop")
		$VisionTimer.stop()
		get_tree().call_group("interfaz", "Oscuro")
		modo_vision_actual = modo_vision.OSCURO

func cambiar_disfraz():
	if disfraz:
		normal()
	elif num_disfraz > 0:
		disfraz()
	
func disfraz():
	$Label.visible = true
	$Sprite.texture = load(Global.box_sprite)
	$Light2D.texture = load(Global.box_sprite)
	$LightOccluder2D.occluder = load(Global.box_oclusion)
	vel_multi = lentitud_disfraz
	collision_layer = 16
	$Timer.start()
	num_disfraz -= 1
	update_disfraz_display()
	disfraz = true
	
func normal():
	$Label.visible = false
	$Sprite.texture = load(Global.player_sprite)
	$Light2D.texture = load(Global.player_sprite)
	$LightOccluder2D.occluder = load(Global.player_oculder)
	vel_multi = 1
	collision_layer = 1
	disfraz = false

func update_disfraz_display():
	get_tree().call_group("DisplayDisfraz", "update_disfraces", num_disfraz)

func tomar_portafolio():
	#print("tomar_portafolio en player one")
	var loot = Node.new()
	loot.set_name("portafolio")
	add_child(loot)
	get_tree().call_group("interfaz", "tomar_loot")
