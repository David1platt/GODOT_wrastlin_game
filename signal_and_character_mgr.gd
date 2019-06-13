extends Node

const BEN = preload("res://art/characters/Ben.tscn")
const DAVE = preload("res://art/characters/Dave.tscn")
const GEORGE = preload("res://art/characters/George.tscn")
const JOHN = preload("res://art/characters/John.tscn")
const MERLIN = preload("res://art/characters/Merlin.tscn")
const MIAH = preload("res://art/characters/Miah.tscn")
const MR_T = preload("res://art/characters/Mr_T.tscn")
const RODNEY = preload("res://art/characters/Rodney.tscn")
const START_POINT = Vector2(805, 340)
const E_START_POINT = Vector2(170, 330)
var player
var computer
signal set_target


#this script connects signals going from game objects to methods in other objects
func _ready():
	computer = spawn_character(game_manager.cpu_player, "comp") #Instance the Computer first
	player = spawn_character(game_manager.human_player, "hum")
	player_interaction_setup()
	self.connect("set_target", computer, "on_set_target")
	emit_signal("set_target", player)
	
func spawn_character(name, player_type):
	var timer = Timer.new()
	timer.wait_time = 2.0
	match name:
		"Ben":
			var ben = BEN.instance()
			setting_character_components(ben, player_type)
			return ben
		"Dave":
			var dave = DAVE.instance()
			setting_character_components(dave, player_type)
			return dave
		"George":
			var george = GEORGE.instance()
			setting_character_components(george, player_type)
			return george
		"John":
			var john = JOHN.instance()
			setting_character_components(john, player_type)
			return john
		"Merlin":
			var merlin = MERLIN.instance()
			setting_character_components(merlin, player_type)
			return merlin
		"Miah":
			var miah = MIAH.instance()
			setting_character_components(miah, player_type)
			return miah
		"Mr_T":
			var mr_t = MR_T.instance()
			setting_character_components(mr_t, player_type)
			return mr_t
		"Rodney":
			var rodney = RODNEY.instance()
			setting_character_components(rodney, player_type)
			return rodney
		_:
			print("character not available")
			
			
func setting_character_components(player, player_type):
	if player_type == "hum":
		player.set_script(load("res://player_controller.gd"))
		player.position = START_POINT
		add_child(player, true) #Add the Script first, then add as Child
	if player_type == "comp":
		computer = player
		var action = Timer.new()
		action.set_wait_time(1.0)
		var melee = Timer.new()
		melee.set_wait_time(0.15)
		var rest = Timer.new()
		rest.set_wait_time(2)
		computer.add_child(action, true)
		computer.add_child(melee, true)
		computer.add_child(rest, true)
		computer.set_script(load("res://ai_opponent.gd"))
		add_child(computer, true)
		#computer.connect("health_changed", $GUI_comp, "on_health_changed")
		computer.position = E_START_POINT
		
		

func player_interaction_setup():
	pass
		#player.connect("move_past", computer, "_on_Moving_By")
		#player.connect("block", computer, "_on_Block")
		#player.get_child(2).connect("p_strike", computer, "on_Enemy_Struck")
		#computer.get_child(2).connect("e_strike", player, "on_Player_Struck")

