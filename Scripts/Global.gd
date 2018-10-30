extends Node

var PlayerOne
var navegacion
var destinos
var nivelActual
var proxNivel

var mensajes_tutorial = "res://Escenas/Niveles/TutorialM.json"

var sonido_vision_on = "res://SFX/nightvision.wav"
var sonido_vision_off = "res://SFX/nightvision_off.wav"

var luz_roja = "res://GFX/Interface/PNG/dotRed.png"
var luz_verde = "res://GFX/Interface/PNG/dotGreen.png"

var box_sprite = "res://GFX/PNG/Tiles/tile_129.png"
var player_sprite = "res://GFX/PNG/Hitman 1/hitman1_stand.png"
var box_oclusion = "res://Escenas/Personajes/BoxOcluder.tres"
var player_oculder = "res://Escenas/Personajes/PersonajeOclusionador.tres"
var portafolio_sprite = "res://GFX/Loot/suitcase.png"