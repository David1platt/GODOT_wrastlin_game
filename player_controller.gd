extends KinematicBody2D

var speed
var jump_speed
var orig_y
var velocity

signal jump
signal fall
signal move_past
signal block
signal strike
signal grapple

var jump_state
var linear_vel = Vector2()
var opponent
var collision

func _ready():
	velocity = 0
	speed = 7
	jump_speed = 11
	jump_state = true
	orig_y = position.y
	opponent = get_node("/root/Main/opponent")
	$Timer.stop()

func _physics_process(delta):
	linear_vel = move()
	linear_vel *= speed
	#linear_vel = lerp(linear_vel, speed_direction, 0.3)
	if Input.is_action_just_pressed("jump"):
		orig_y = position.y
	if Input.is_action_pressed("jump") && jump_state:
		linear_vel = jump(linear_vel)
	linear_vel = _on_Timer_timeout()
	collision = move_and_collide(linear_vel)
	if collision and collision.collider.get_name() == "opponent":
		if position.y >= collision.collider.position.y + 30 or position.y <= collision.collider.position.y - 30:
			emit_signal("move_past")
	elif position.y <= opponent.position.y + 30 and position.y >= opponent.position.y - 30:
			emit_signal("block")	
			linear_vel *= -1 + 2
	attack()

func attack():
	if Input.is_key_pressed(KEY_A):
		if collision != null and collision.collider.get_name() == "opponent":
			emit_signal("strike")
			print("player punch")
	if Input.is_key_pressed(KEY_S):
		emit_signal("strike")	
		print("player kick")
	if Input.is_key_pressed(KEY_D):
		emit_signal("grapple")
		print("player grab")
	
func move():
	#jump_state = true
	var velocity = Vector2()
	#velocity = gravity
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		orig_y = position.y
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
			velocity.x -= 1
	#velocity *= speed
	return velocity.normalized()

func jump(linear_vel):
	$Timer.paused = false
	$Timer.start()
	emit_signal("jump") 
	#while $Timer.time_left > 0:	
	linear_vel.y -= 1
	linear_vel.y *= jump_speed 
	linear_vel.x = linear_vel.x / 5
	return linear_vel
			
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
