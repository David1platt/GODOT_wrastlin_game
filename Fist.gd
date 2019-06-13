extends Area2D
signal p_strike

func _on_Fist_body_entered(body):
	 
	if body.hitable && body.get_name() != self.get_parent().get_name(): #Fist Collison works now
		print(body.get_name() + " hit!")
		emit_signal("p_strike")
 # Replace with function body.