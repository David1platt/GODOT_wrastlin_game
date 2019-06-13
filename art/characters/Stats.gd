extends Node

const POWER = 10
const SPEED = 15
const TOUGHNESS = 7
const CHARISMA = 8
const SIZE = 8
const MOVE_LIST = ["blah", "blech", "blargh"]
signal send_stats
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_Character_Ready():
	emit_signal("send_stats", POWER, SPEED, TOUGHNESS, CHARISMA, SIZE, MOVE_LIST)