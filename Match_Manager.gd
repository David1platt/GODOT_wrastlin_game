extends Node

enum character_stats {picture, speed, stamina, power, toughness, charisma, size, move_list}
var stats = ["picture", "speed", "stamina", "power", "toughness", "charisma", "size", "move_list"]#this script connects signals going from game objects to methods in other objects
func _ready():
	$Player.connect("jump", $ring, "_on_Player_Jump")
	$Player.connect("fall", $ring, "on_Player_Fall")
	$Player.connect("move_past", $Opponent, "_on_Moving_By")
	$Player.connect("block", $Opponent, "_on_Block")
	set_player(game_manager.human_player, "hum")
	$"Opponent/Fist/".connect("e_strike", $Player, "on_Player_Struck")
	$"Player/Fist/".connect("p_strike", $Opponent, "on_Enemy_Struck")
	$Player.connect("health_changed", $GUI_player, "on_health_changed")
	$Opponent.connect("health_changed", $GUI_comp, "on_health_changed")
	set_player(game_manager.cpu_player, "comp")
	#$"Opponent/Sprite".set_texture()
	#print("Player ")
	#print("speed ", $Player.speed)
	#print("stamina ", $Player.stamina)
	#print("power ", $Player.power)
	#print("toughness ", $Player.toughness)
	#print("charisma ", $Player.charisma)
	#print("size ", $Player.size)

func set_player(player_name, player_type):
	match player_name:
			"Dave":
				var dave = game_manager.get_player(player_name)	
				set_stats(dave, player_type)
			"Miah":
				var miah = game_manager.get_player(player_name)	
				set_stats(miah, player_type)
			"John":
				var john = game_manager.get_player(player_name)	
				set_stats(john, player_type)
			"Merlin":
				var merlin = game_manager.get_player(player_name)	
				set_stats(merlin, player_type)
			"Ben":
				var ben = game_manager.get_player(player_name)	
				set_stats(ben, player_type)
			"Mr_T":
				var mr_t = game_manager.get_player(player_name)	
				set_stats(mr_t, player_type)
			"Rodney":
				var rodney = game_manager.get_player(player_name)	
				set_stats(rodney, player_type)
			"George":
				var george = game_manager.get_player(player_name)	
				set_stats(george, player_type)
				
func set_stats(player, player_type):
	if player_type == "hum":
		$"Player/Sprite".set_texture(player[stats[character_stats.picture]])
		$Player.speed += player[stats[character_stats.speed]]
		$Player.stamina = player[stats[character_stats.stamina]]
		$Player.power = player[stats[character_stats.power]]
		$Player.toughness = player[stats[character_stats.toughness]]
		$Player.charisma = player[stats[character_stats.charisma]]
		$Player.size = player[stats[character_stats.size]]
	if player_type == "comp":
		$"Opponent/Sprite".set_texture(player[stats[character_stats.picture]])
		$Opponent.speed += player[stats[character_stats.speed]]
		$Opponent.stamina = player[stats[character_stats.stamina]]
		$Opponent.power = player[stats[character_stats.power]]
		$Opponent.toughness = player[stats[character_stats.toughness]]
		$Opponent.charisma = player[stats[character_stats.charisma]]
		$Opponent.size = player[stats[character_stats.size]]