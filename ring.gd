extends StaticBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _on_Player_Jump():
	var player = get_parent().get_node("Player")
	$"ring-back".add_collision_exception_with(player)
		

func on_Player_Fall():
	var player = get_parent().get_node("Player")
	$"ring-back".remove_collision_exception_with(player)

	
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
