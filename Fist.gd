extends Area2D
signal p_strike

func _on_Fist_body_entered(body):
	if body.get_name() == "Opponent":
		print(body.get_name() + " hit!")
		emit_signal("p_strike")
 # Replace with function body.
