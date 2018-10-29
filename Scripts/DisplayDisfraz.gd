extends ItemList

func update_disfraces(num_disfraces):
	clear()
	for i in range(num_disfraces):
		add_icon_item(load(Global.box_sprite), false)