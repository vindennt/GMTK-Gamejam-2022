extends GridContainer

var inventory = preload("res://Inventory.tres")

func _ready():
	inventory.connect("items_changed", self, "_on_items_changed")
	update_inventory_display()
	print(inventory.items)
	
func update_inventory_display():
	for item_index in inventory.items.size():
		update_inventory_slot_display(item_index)
	
func update_inventory_slot_display(item_index):
	var inventorySlotDisplay = get_child(item_index)
	var item = inventory.items[item_index]
	inventorySlotDisplay.display_item(item)
#	inventorySlotDisplay.itemTextureRect.modulate='ffffffff'
	
func _on_items_changed(indexes):
	for item_index in indexes:
		update_inventory_slot_display(item_index)

func _unhandled_input(event):
	if event.is_action_released("ui_left_mouse"):
		if inventory.drag_data is Dictionary:
			var unhandledItem = inventory.drag_data
			inventory.set_item(inventory.drag_data.item_index, inventory.drag_data.item)
			
			
