extends Area2D

func _on_Portafolio_body_entered(body):
	Global.PlayerOne.tomar_portafolio()
	queue_free()