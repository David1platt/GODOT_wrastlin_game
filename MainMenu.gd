extends Control

func _on_QuickMatchButton_pressed():
	get_tree().change_scene("Main.tscn")


func _on_TournamentButton_pressed():
	print("Tournament")


func _on_CreateAWrestlerButton_pressed():
	print("Create A Wrestler")


func _on_QuitButton_pressed():
	get_tree().quit()
