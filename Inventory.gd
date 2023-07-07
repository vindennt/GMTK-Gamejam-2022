extends Resource
class_name Inventory

var drag_data = null

signal items_changed(indexes)

export(Array, Resource) var items = [
	null, null, null, 
	null, null, null, 
	null, null, null
]

func set_item(item_index, item):
	var previous_item = items[item_index]
	items[item_index] = item
	emit_signal("items_changed", [item_index])
	return previous_item
	
func swap_items(item_index, target_item_index):
	var targetItem = items[target_item_index]
	var item = items[item_index]
	items[target_item_index] = item
	items[item_index] = targetItem
	emit_signal("items_changed", [item_index, target_item_index])
	
func remove_item(item_index):
	var previous_item = items[item_index]
	items[item_index] = null
	emit_signal("items_changed", [item_index])
	return previous_item
