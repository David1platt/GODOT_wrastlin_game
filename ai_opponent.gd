extends KinematicBody2D

#var rand_num
var speed
var velocity = Vector2()
var plyr
var collision
var move_check
var plyr_hits
var my_hits
enum status_type {ATTACK, FLEE, FLANK, REST}
var ring_back
var ring_floor 
var status


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
	
	
func choose_direct(direction, velocity):
	match direction:
		1, 2:
			velocity.x -= 1
			return velocity	
		3, 4: 
			velocity.x += 1
			return velocity
		5:
			velocity.y += 1
			return velocity
		6:
			velocity.y -= 1
			return velocity
		!1, !2, !3, !4:
			pass		
	
	
func ai_move():	
	if position.distance_to(plyr.position) > 128:
		velocity = (plyr.position - position) * speed


#warning-ignore:unused_argument
func _physics_process(delta):
	if move_check:
		match status:
			status_type.ATTACK:
				movement()
			status_type.FLEE:
				flee()
			status_type.FLANK:
				flank()
			status_type.REST:
				flee()
			_:
				print("ai status is null!")
	else:
		ai_move()
		$Melee.paused = false
	if $Action.time_left > 1.9:
		move_check = true

		
func state_choice():
	var chance = randi() % 100 + 1
	if plyr_hits > 1:
		status = status_type.FLEE
		flee()
	if chance < 20:
		pass
	if chance > 20 and chance < 50:
		print("punch")
		my_hits += 1
	if my_hits > 2:
		print("grapple")
		my_hits = 0
	if chance > 85 and chance < 100:
		status = status_type.FLANK
		print("flank")


func movement():		
	if position.distance_to(plyr.position) > 128:
		$Melee.paused = true
		collision = move_and_collide(velocity.normalized())	
	elif position.distance_to(plyr.position) <= 128 and position.y <= plyr.position.y:
		velocity.y += 1
		velocity.x = 0
		if position.y <= plyr.position.y - 2:
			collision = move_and_collide(velocity.normalized())
	elif position.distance_to(plyr.position) <= 128 and position.y >= plyr.position.y:
		velocity.y -= 1
		velocity.x = 0
		if position.y >= plyr.position.y + 2:
			collision = move_and_collide(velocity.normalized())
		if collision != null:
			print(collision.collider.get_name())
	else:
		move_check = false
		$Action.paused = true		

		
func flee():
	velocity.x += 1 
	velocity = (plyr.position - position) * -1
	if position.distance_to(plyr.position) <= 220:
		move_check = true
		move_and_collide(velocity.normalized())
	if position.distance_to(plyr.position) >= 220:
		status = status_type.ATTACK
		plyr_hits = 0


func flank():
	if position.distance_to(plyr.position) < 200:
		move_check = true
		if position.y <= plyr.position.y:
			velocity.y += 1
			velocity.x = 0
		if position.y >= plyr.position.y:
			velocity.y -= 1
			velocity.x = 0
		if position.y == plyr.position.y:
			if position.distance_to(ring_floor.position) < 250:
				velocity.y += 1
				velocity.x = 0
			if position.distance_to(ring_back.position) < 250:
				velocity.y -= 1
				velocity.x = 0
		if position.y <= plyr.position.y + 60:
			velocity.y = 0
			velocity.x += 1
		if position.y >= plyr.position.y - 60:
			velocity.y = 0
			velocity.x -= 1
		$Melee.paused = true
		move_and_collide(velocity.normalized())	
	
	
func _on_Action_timeout():
	move_check = false
	velocity.x = 0
	velocity.y = 0
	ai_move()

func _on_Moving_By():
	var player = get_parent().get_node("Player")
	add_collision_exception_with(player)

	
func _on_Block():
	var player = get_parent().get_node("Player")
	remove_collision_exception_with(player)	

	
func _on_Struck():
		plyr_hits += 1

func _on_Grabbed():
	pass

	
func _on_Melee_timeout():
	state_choice()
	


func _on_Rest_timeout():
	status = status_type.ATTACK
	pass # Replace with function body.
