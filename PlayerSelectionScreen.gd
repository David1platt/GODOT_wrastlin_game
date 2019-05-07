extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

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


func _on_Miah_pressed():
	$ChangeScene.paused = false


func _on_John_pressed():
	$ChangeScene.paused = false


func _on_Merlin_pressed():
	$ChangeScene.paused = false


func _on_Mr_T_pressed():
	$ChangeScene.paused = false


func _on_Ben_pressed():
	$ChangeScene.paused = false


func _on_Rodney_pressed():
	$ChangeScene.paused = false


func _on_Burns_pressed():
	$ChangeScene.paused = false


func _on_ChangeScene_timeout():
	get_tree().change_scene("Main.tscn")
