extends Control
signal player_select
#signal char_choice
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var char_names = ["Dave", "Miah", "John", "Merlin", "Mr_T", "Ben", "Rodney", "George"]

# Called when the node enters the scene tree for the first time.
func _ready():
	$ChangeScene.start()
	$ChangeScene.paused = true
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Dave_pressed():
	$ChangeScene.paused = false
	game_manager.human_player = "Dave"
	select_cpu_player()
	emit_signal("player_select", game_manager.human_player)


func _on_Miah_pressed():
	$ChangeScene.paused = false
	game_manager.human_player = "Miah"
	select_cpu_player()
	emit_signal("player_select", game_manager.human_player)


func _on_John_pressed():
	$ChangeScene.paused = false
	game_manager.human_player = "John"
	select_cpu_player()
	emit_signal("player_select", game_manager.human_player)


func _on_Merlin_pressed():
	$ChangeScene.paused = false
	game_manager.human_player = "Merlin"
	select_cpu_player()
	emit_signal("player_select", game_manager.human_player)


func _on_Mr_T_pressed():
	$ChangeScene.paused = false
	game_manager.human_player = "Mr_T"
	select_cpu_player()
	emit_signal("player_select", game_manager.human_player)

	
func _on_Ben_pressed():
	$ChangeScene.paused = false
	game_manager.human_player = "Ben"
	select_cpu_player()
	emit_signal("player_select", game_manager.human_player)
	
func _on_Rodney_pressed():
	$ChangeScene.paused = false
	game_manager.human_player = "Rodney"
	select_cpu_player()
	emit_signal("player_select", game_manager.human_player)

func _on_Burns_pressed():
	$ChangeScene.paused = false
	game_manager.human_player = "George"
	select_cpu_player()
	emit_signal("player_select", game_manager.human_player)
	
func _on_ChangeScene_timeout():
	get_tree().change_scene("Main.tscn")
	select_cpu_player()	
	emit_signal("player_select", game_manager.human_player)
	
func select_cpu_player():
	randomize()
	var char_choice = randi() % 7
	if char_names[char_choice] != game_manager.human_player: 
		game_manager.cpu_player = char_names[char_choice]
		emit_signal("player_select", game_manager.cpu_player)
	else:
		select_cpu_player()
	
