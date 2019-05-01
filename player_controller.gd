extends KinematicBody2D

var speed
var jump_speed
var orig_y
var velocity
var min_health
var max_health
var jump_state
var linear_vel = Vector2()
var opponent
var collision
var fist_g
signal jump
signal fall
signal move_past
signal block
signal strike
signal grapple
signal health_changed

#ready() allows us to initialize variables when the object is created in the game world
func _ready():
	velocity = 0 
	speed = 7
	jump_speed = 11
	jump_state = true
	orig_y = position.y
	opponent = get_node("/root/Main/Opponent")
	$Timer.stop()
	max_health = 100
	min_health = 0
	fist_g = false

#physics_process runs on a loop that updates every frame, which should be 60 fps
func _physics_process(delta):
	linear_vel = move()# linear_vel is the movement vector for the player
	linear_vel *= speed
	if Input.is_action_just_pressed("jump"):# sets the initial y coordinate of the player sprite
		orig_y = position.y
	if Input.is_action_pressed("jump") && jump_state:#jump boolean checks if player sprite is on the ground
		linear_vel = jump(linear_vel)#jump() changes the vertical y-axis of the movement vector 
	linear_vel = _on_Timer_timeout()# when the timer times out the player falls back to their original vertical position and can jump again
	collision = move_and_collide(linear_vel) #built in move method that checks for collisions
	if collision and collision.collider.get_name() == "Opponent": #checks if collider is the computer player
		if position.y >= collision.collider.position.y + 30 or position.y <= collision.collider.position.y - 30:
			emit_signal("move_past")
	elif position.y <= opponent.position.y + 30 and position.y >= opponent.position.y - 30:
			emit_signal("block")	
			linear_vel *= -1 + 2
	attack()

func attack():
	if Input.is_action_just_pressed("attack"):
		hit()
	if Input.is_action_just_pressed("kick"):
		hit()
	if Input.is_key_pressed(KEY_D):
		emit_signal("grapple")
		print("player grab")
	 
func hit():
		get_node("Fist/fist/AnimationPlayer").play("punch")
		fist_g = true
	
#updates health when player is hit and sends a signal to the life bar GUI
func on_Player_Struck():
	max_health -= 5
	emit_signal("health_changed", max_health)
	print(max_health)
	
#changes to velocity x and y values change the movement vector each frame
func move():
	var velocity = Vector2()
	#velocity = gravity
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		orig_y = position.y #sets vertical origin for jumping
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
			velocity.x -= 1
	#velocity *= speed
	return velocity.normalized()

#while the timer is still running the movement vector is changed applying and up and fwd force to simulate
#a jumping motion updated move vector is returned
func jump(linear_vel): 
	$Timer.paused = false
	$Timer.start()
	emit_signal("jump") 	
	linear_vel.y -= 1
	linear_vel.y *= jump_speed 
	linear_vel.x = linear_vel.x / 5
	return linear_vel
			
#when the timer runs out the move vector is changed to make the player fall, player can jump again
func _on_Timer_timeout():
	if position.y < orig_y:
		jump_state = false
		linear_vel.y += 1
		linear_vel *= jump_speed
		linear_vel.x = linear_vel.x / 4
	if position.y == orig_y:
		$Timer.paused = true
		emit_signal("fall")
		jump_state = true
	return linear_vel



