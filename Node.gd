extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	$Player.connect("jump", $ring, "_on_Player_Jump")
	$Player.connect("fall", $ring, "on_Player_Fall")
	$Player.connect("move_past", $opponent, "_on_Moving_By")
	$Player.connect("block", $opponent, "_on_Block")

	# Called when the node is added to the scene for the first time.
	# Initialization here


#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
