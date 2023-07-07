extends CenterContainer

var inventory = preload("res://Inventory.tres")

onready var itemTextureRect = $ItemTextureRect

func display_item(item):
	if item is Item:
		itemTextureRect.texture = item.texture
	else:
		itemTextureRect.texture = load("res://art/dices/EmptyInventorySlot.png")

func get_drag_data(_position):
	var item_index = get_index()
	var item = inventory.items[item_index]
	if item is Item:
		var data = {}
		data.item = item
		data.item_index = item_index
		var dragPreview = TextureRect.new()
		dragPreview.texture = (item.texture)
		var c = Control.new()
		dragPreview.rect_position = -0.5 * item.texture.get_size()
		c.add_child(dragPreview)
#		itemTextureRect.modulate='22ffffff'
		set_drag_preview(c)


		return data
		
	
func can_drop_data(position, data):
	return data is Dictionary and data.has("item")
	
func drop_data(_position, data):
	var my_item_index = get_index()
	var my_item = inventory.items[my_item_index]
#	if my_item is Item and my_item.name == data.item.name:
#		inventory.emit_signal("items_changed", [my_item_index])
#	else:
	inventory.swap_items(my_item_index, data.item_index)
	inventory.set_item(my_item_index, data.item)
	inventory.drag_data = null
	
