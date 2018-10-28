extends Popup

onready var label = $RichTextLabel

func _ready():
	pass

func set_text(combinacion):
	label.bbcode_text = ("Deja de olvidarte la combinacion, es " 
			+ PoolStringArray(combinacion).join(""))