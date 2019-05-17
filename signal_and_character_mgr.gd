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
var player
signal set_target


#this script connects signals going from game objects to methods in other objects
func _ready():
	player = spawn_character(game_manager.human_player)
	self.connect("set_target", $Opponent, "on_set_target")
	#player.connect("set_target", $GUI_player, "_ready")
	emit_signal("set_target", player)
	$Opponent.connect("health_changed", $GUI_comp, "on_health_changed")
	
	
func spawn_character(name):
	var timer = Timer.new()
	timer.wait_time = 2.0
	match name:
		"Ben":
			var ben = BEN.instance()
			setting_character_components(ben, timer)
			return ben
		"Dave":
			var dave = DAVE.instance()
			setting_character_components(dave, timer)
			return dave
		"George":
			var george = GEORGE.instance()
			setting_character_components(george, timer)
			return george
		"John":
			var john = JOHN.instance()
			setting_character_components(john, timer)
			return john
		"Merlin":
			var merlin = MERLIN.instance()
			setting_character_components(merlin, timer)
			return merlin
		"Miah":
			var miah = MIAH.instance()
			setting_character_components(miah, timer)
			return miah
		"Mr_T":
			var mr_t = MR_T.instance()
			mr_t.add_child(timer)
			setting_character_components(mr_t, timer)
			return mr_t
		"Rodney":
			var rodney = RODNEY.instance()
			setting_character_components(rodney, timer)
			return rodney
		_:
			print("character not available")
			
			
func setting_character_components(player, timer):
	player.add_child(timer)
	timer.connect("timeout", player, "_on_Timer_timeout")
	player.set_script(load("res://player_controller.gd"))
	add_child(player)
	player.connect("jump", $"ring", "_on_Player_Jump")
	player.connect("fall", $"ring", "on_Player_Fall")
	player.connect("move_past", $Opponent, "_on_Moving_By")
	player.connect("block", $Opponent, "_on_Block")
	$"Opponent/Fist/".connect("e_strike", player, "on_Player_Struck")
	player.get_child(2).connect("p_strike", $Opponent, "on_Enemy_Struck")
	player.connect("health_changed", $GUI_player, "on_health_changed")
	player.connect("set_health", $GUI_player, "on_health_set")
	player.position = START_POINT



