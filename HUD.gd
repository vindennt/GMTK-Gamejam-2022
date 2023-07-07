extends CanvasLayer

signal start_game
signal update_enemyhp
signal check_tip_on
signal check_tip_off

var message_position = Vector2(0, 0)


func update_enemyhp(enemy_hp):
	$EnemyHealthLabel.text = str(enemy_hp)
	
func update_damage(dmg):
	$DamageLabel.text = "DMG: " + str(dmg)
	
func update_phase(phase):
	$PhaseLabel.text = str(phase)

func _on_StartButton_pressed():
#	$StartButton.hide()
	emit_signal("start_game")
	hide_message()

func show_message(text):
	$MessageLabel.text = str(text)
	$MessageLabel.show()
	
func hide_message():
	$MessageLabel.hide()
	
func _on_RollButton_mouse_entered():
	$MessageLabel.set_position(get_viewport().get_mouse_position())
	$MessageLabel.align = Label.ALIGN_LEFT
	show_message("sensed")

func _on_RollButton_mouse_exited():
	$MessageLabel.align = Label.ALIGN_CENTER
	hide_message()
	
