extends "res://Scripts/Personaje.gd"

var mov = Vector2()
var modo_vision_enfriamiento = false
enum modo_vision {OSCURO, VISION_NOCTURNA}

func _ready():
	Global.PlayerOne = self
	modo_vision = OSCURO

func _process(delta):
	update_mov(delta)
	move_and_slide(mov)
	#print($VisionTimer.time_left)

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
		if modo_vision == OSCURO:
			cambiar_modo_vision()


func _on_VisionTimer_timeout():
	cambiar_modo_vision()

func cambiar_modo_vision():
	if modo_vision == OSCURO:
		#print("start")
		$VisionTimer.start()
		get_tree().call_group("interfaz", "Vision_Nocturna")
		modo_vision = VISION_NOCTURNA
	elif modo_vision == VISION_NOCTURNA:
		#print("stop")
		$VisionTimer.stop()
		get_tree().call_group("interfaz", "Oscuro")
		modo_vision = OSCURO