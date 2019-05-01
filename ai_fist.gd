extends Area2D
signal e_strike

func _on_Fist_body_entered(body):
	if body.get_name() == "Player":
		print(body.get_name() + " hit!")
		emit_signal("e_strike")