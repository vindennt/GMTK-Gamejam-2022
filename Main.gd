extends Node

onready var enemy_health: float = 0.0
onready var damage: float = 0.0
var inventory = preload("res://Inventory.tres")

var max_elements: int = 4 # 5 known elements

var max_dice_value: int = 6
var new_rolls: Dictionary = {}
var phases: Array = [
	"roll", 
	"apply", 
	"enemy_damage", 
	"weakness?", 
	"loot_check", 
	"new_enemy"]
var phase_index = 5 # sets so next phase is roll



func _ready():
	randomize()
	$HUD/EnemyHealthLabel.hide()
	$HUD/PhaseLabel.hide()
	$HUD/AttackButton.hide()
	$HUD/DamageLabel.hide()
	$InventoryContainer.hide()

func new_game():
	enemy_health = 0
	$HUD.update_enemyhp("HP: " + str(enemy_health))
	$HUD.update_phase(str(phases[phase_index]))
	$HUD.update_damage(stepify(damage, 0.1))
	$HUD/EnemyHealthLabel.show()
	$HUD/PhaseLabel.show()
	$HUD/AttackButton.show()
	$HUD/DamageLabel.show()
	$InventoryContainer.show()
	next_phase()
	
func next_phase():
	phase_index += 1
	phase_index %= 6
	process_phase()
	
func get_dice_roll():
	return randi() % max_dice_value + 1
	
func get_dice_element():
	var random_element: int = randi() % max_elements + 1
	# adjust these values and max_elements roll to adjust probability!
	if random_element == 0:
		return "sweet"
	if random_element == 1:
		return "salty"
	if random_element == 2:
		return "savoury"
	if random_element == 3:
		return "sour"
	if random_element == 4:
		return "umami"
	else:
		print("no element could be rolled")
	

func get_dice_item(value: int, _element: String):
	return "res://art/dices/Dice" + str(value) + ".tres"

func get_new_rolls():
#	new_rolls = {"roll1": [0, ""], "roll2": [0, ""], "roll3": [0, ""]}
#	for roll in new_rolls.keys():
	var new_roll_indexes: Array = [8, 7, 6]
	for target_index in new_roll_indexes:
		var current_roll: Array = [0, "", ""] 
		current_roll[0] = get_dice_roll() # dice value
		current_roll[1] = get_dice_element() # dice element
		current_roll[2] = get_dice_item(current_roll[0], current_roll[1]) # dice item matching value
#		print(current_roll[0])
#		print(current_roll[1])
#		print(current_roll[2])
		var matching_dice_data = load(current_roll[2])
		inventory.set_item(target_index, matching_dice_data)
		print(current_roll[0], current_roll[1], current_roll[2])


### ####### BIG NOTE: TRY TO MAKLE EACH PAHSE ONE FUNCTION TO MAKE IT READABLE
# possibly move phase handling to different scnes?
func process_phase():
	var queued_phase = (phases[phase_index])
	$HUD.update_phase(queued_phase)
	if queued_phase == (phases[0]): # roll
		get_new_rolls()
		next_phase()
	if queued_phase == (phases[1]): # apply, player applies buffs and rolls until ATK
		#yield(attack button pressed)
		#add comand to update damage calc when inventory updated
		pass
	if queued_phase == (phases[2]): # enemy damage
		pass
	if queued_phase == (phases[3]): # weakness, check if weakness was hit
		pass
	if queued_phase == (phases[4]): # loot check, gives rewards if weakness/enemy beat
		pass
	if queued_phase == (phases[5]): # new enemy, adds a new enemy based on RNG
		pass
