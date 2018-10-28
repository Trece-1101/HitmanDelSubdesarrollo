extends Area2D

var en_rango = false

func _on_Puerta_body_entered(body):
	if not body == Global.PlayerOne and not $AnimationPlayer.is_playing():
		abrir()
		#print(body.get_parent().get_parent().name)
	else:
		en_rango = true

func _on_Puerta_body_exited(body):
	if body == Global.PlayerOne:
		en_rango = false

func abrir():
	if not $AnimationPlayer.is_playing():
		$AnimationPlayer.play("abrir")

func _input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and en_rango:
		abrir()

func _on_Timer_timeout():
	pass