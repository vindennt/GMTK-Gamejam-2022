extends TextureRect
#
#var id: int
#var roll: int = 0
#var label: String
## set true when dropped on target area
#var dropped_on_target: bool = false

var type: String setget set_type

func _ready() -> void:
	add_to_group("DRAGGABLE")

func get_drag_data(_position: Vector2):
	set_drag_preview(_get_preview_control())
	return self

func _get_preview_control() -> Control:
	var drag_preview = TextureRect.new()
	drag_preview.rect_size = Vector2(texture.get_width(),texture.get_height())
	drag_preview.texture = texture
	# Center on mouse trick learned from "Game Development Center"
	#   https://youtu.be/dZYlwmBCziM?t=199
	var center_on_mouse_control = Control.new()
	center_on_mouse_control.add_child(drag_preview)
	drag_preview.rect_position = -0.5 * drag_preview.rect_size

	return center_on_mouse_control
#
#	var preview = ColorRect.new()
#	preview.rect_size = rect_size
#	preview.color = "#51b56c"
#	preview.set_rotation(.1) # in readians
#	var center_on_mouse_control = Control.new()
#	center_on_mouse_control.add_child(preview)
#	preview.rect_position = -0.5 * preview.rect_size
#	return center_on_mouse_control

func set_type(x_or_o: String):
	type = x_or_o
#	texture = load("res://art/game_piece_%s.png" % x_or_o.to_lower())

