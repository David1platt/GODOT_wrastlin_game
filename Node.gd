extends Node


#this script connects signals going from game objects to methods in other objects
func _ready():
	$Player.connect("jump", $ring, "_on_Player_Jump")
	$Player.connect("fall", $ring, "on_Player_Fall")
	$Player.connect("move_past", $Opponent, "_on_Moving_By")
	$Player.connect("block", $Opponent, "_on_Block")
	$"Opponent/Fist/".connect("e_strike", $Player, "on_Player_Struck")
	$"Player/Fist/".connect("p_strike", $Opponent, "on_Enemy_Struck")
	$Player.connect("health_changed", $GUI_player, "on_health_changed")
	$Opponent.connect("health_changed", $GUI_comp, "on_health_changed")


