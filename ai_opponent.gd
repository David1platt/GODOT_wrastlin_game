extends KinematicBody2D

#var rand_num
var speed
var velocity = Vector2()
var plyr
var collision
var move_check
var plyr_hits
var my_hits
var max_health = 100.0
enum status_type {ATTACK, FLEE, FLANK, REST}
signal health_changed
#signal died
#signal strike
var ring_back
var ring_floor 
var status

#variables are initialized here
func _ready():
	speed = 50
	plyr = get_node("/root/Main/Player")
	ring_back = get_node("/root/Main/ring/ring-back")
	ring_floor = get_node("/root/Main/ring/ring-floor")
	$Action.start()
	$Melee.start()
	move_check = false
	velocity.x = 0
	velocity.y = 0
	plyr_hits = 0
	my_hits = 0
	status = 0
	
#computer selects new direction to move and a new action to take depending on state_choice results
func _on_Action_timeout():
	move_check = false
	velocity.x = 0
	velocity.y = 0
	ai_move()
	state_choice()
	
#everytime the Melee timer times out a new ai action choice is made
func _on_Melee_timeout():
	state_choice()
# ndom number between 1 - 100 is select the action of the computer player
func state_choice():
	var chance = randi() % 100 + 1
	if plyr_hits > 1: #if computer is hit by the human player more than once flee method call
		status = status_type.FLEE
		flee()
		return
	if chance < 20:#no action here yet
		chance = 0
		pass
	if chance > 20 and chance < 50:#computer plays a punch animation, attacking the player
		print("punch")
		get_node("Fist/fist/AnimationPlayer").play("punch")#attacks player triggers fist event you'll find in the ai-fist script in the Fist sub-node of Opponent
		my_hits += 1
		chance = 0
		return
	if my_hits > 2:#if computer hits player more than twice computer engages a grapple move
		print("grapple")
		my_hits = 0
		chance = 0
		return
	if chance > 98 and chance < 100:#computer player flanks/moves around human player
		status = status_type.FLANK
		print("flank")
		chance = 0
		return
		
#unused function		
#func choose_direct(direction, velocity):
#	match direction:
#		1, 2:
#			velocity.x -= 1
#			return velocity	
#		3, 4: 
#			velocity.x += 1
#			return velocity
#		5:
#			velocity.y += 1
#			return velocity
#		6:
#			velocity.y -= 1
#			return velocity
#		!1, !2, !3, !4:
#			pass		
	
#computer player moves toward human player
func ai_move():	
	if position.distance_to(plyr.position) > 128:
		velocity = (plyr.position - position) * speed #sets vector going toward human player
		$Sprite.flip_h = velocity.x < 0 
		#if velocity.x < 0:
		#	$Fist.position.x -= 40
		#else:
		#	$Fist.position.x = 40
		
#warning-ignore:unused_argumen
#if the computer player can move the game loop checks what the ai state is, state is saved
#in status variable which selects from a list of enum values
func _physics_process(delta):
	if move_check:
		match status:
			status_type.ATTACK:
				movement(delta)
			status_type.FLEE:
				flee()
			status_type.FLANK:
				flank(delta)
			status_type.REST:
				flee()
			_:
				print("ai status is null!")
	else:#if move_check fails 
		ai_move()#set computer direction
		$Melee.paused = false#stops the attack action timer
	if $Action.time_left > 1.9:#when Action timer reset computer allowed to move
		move_check = true

#computer is over 128 pixels away from center of human player, move computer player
#toward the computer player
func movement(delta):		
	if position.distance_to(plyr.position) > 128:
		$Melee.paused = true
		velocity *= speed * delta
		collision = move_and_collide(velocity.normalized())	
	elif position.distance_to(plyr.position) <= 128 and position.y <= plyr.position.y:
		velocity.y += 1
		velocity.x = 0
		if position.y <= plyr.position.y - 2:
			velocity *= speed * delta
			collision = move_and_collide(velocity.normalized())
	elif position.distance_to(plyr.position) <= 128 and position.y >= plyr.position.y:
		velocity.y -= 1
		velocity.x = 0
		if position.y >= plyr.position.y + 2:
			velocity *= speed * delta
			collision = move_and_collide(velocity.normalized())
		if collision != null:
			print(collision.collider.get_name())
	else:#if computer distance to player <= 128 pixels center of computer, computer stops
		move_check = false
		$Action.paused = true		

#sets computer move vector away from player, allows computer to move 220 pixels away from player
#then moves the computer back to towards the player
func flee():
	velocity.x += 1 
	velocity = (plyr.position - position) * -1
	if position.distance_to(plyr.position) <= 220:#confirms computer moving away
		move_check = true
		velocity *= speed
		move_and_collide(velocity.normalized())
	if position.distance_to(plyr.position) >= 220:#resets computer to move too player
		status = status_type.ATTACK
		plyr_hits = 0

#puter circles around player then moves back in to attack player from opposite side
func flank(delta):
	if position.distance_to(plyr.position) < 160:
		move_check = true
		if position.y <= plyr.position.y:
			velocity.y -= 1
			velocity.x = 0
		if position.y >= plyr.position.y:
			velocity.y += 1
			velocity.x = 0
		if position.y == plyr.position.y:
			if position.distance_to(ring_floor.position) < 10:
				velocity.y -= 1
				velocity.x = 0
			if position.distance_to(ring_back.position) < 10:
				velocity.y += 1
				velocity.x = 0
		if position.y >= plyr.position.y + 30:
			velocity.y = 0
			velocity.x += 1
		elif position.y <= plyr.position.y - 30:
			velocity.y = 0
			velocity.x += 1
		$Melee.paused = true
		velocity *= speed * delta
		collision = move_and_collide(velocity.normalized())	
	else:
		status = status_type.ATTACK
		return

#allows player to pass by computer player
func _on_Moving_By():
	var player = $"../Player"
	add_collision_exception_with(player)

# stops player from entering computer player space	
func _on_Block():
	var player = $"../Player"
	remove_collision_exception_with(player)	

#updates computer player health and sends signal to lifebar GUI
func on_Enemy_Struck(): 
	plyr_hits += 1
	max_health -= 5
	emit_signal("health_changed", max_health)

#not active yet
func _on_Grabbed():
	pass

#not in use yet, I don't think
func _on_Rest_timeout():
	status = status_type.ATTACK
	pass # Replace with function body.
	

