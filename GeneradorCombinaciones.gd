extends Node

func generar_combinacion(longitud):
	var combinacion = []
	for num in range(longitud):
		randomize()
		combinacion.append(randi() % 10)
	return combinacion