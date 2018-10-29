extends TextureProgress

var sospecha = 0

export var step_sospecha = 1
export var baja_sospecha = 0.25

func _process(delta):
	sospecha -= baja_sospecha
	sospecha = clamp(sospecha, 0, max_value)
	value = sospecha

func detectado():
	sospecha += step_sospecha
	if sospecha == max_value:
		end_game()
		
func end_game():
	get_tree().quit()