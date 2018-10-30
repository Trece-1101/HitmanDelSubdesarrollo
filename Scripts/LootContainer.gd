extends NinePatchRect

func _ready():
	visible = false

func tomar_loot():
	visible = true
	$LootList.add_icon_item(load(Global.portafolio_sprite), false)