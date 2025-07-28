extends CharacterBody2D

# === CONFIG ===
@export var platformer_speed := 600.0
@export var jump_force := -1000.0
@export var gravity := 1800.0
@export var run_multiplier := 1.5
@export var topdown_speed := 600.0
@export var acceleration := 2000.0
@export var friction := 1500.0
var is_platformer := true
var topdown_jump_height := 0.0
var topdown_jump_speed := 0.0
var topdown_is_jumping := false


# === Called every physics frame ===
func _physics_process(delta):
	if Input.is_action_just_pressed("tab"):
		is_platformer = !is_platformer
		if is_platformer:
			print("Switched Mode: Platformer")
		else:
			print("Switched Mode: Top-Down")
 
	if is_platformer:
		platformer_move(delta)
	else:
		topdown_move(delta)

	move_and_slide()

	play_animation()
	flip_sprite()

# === PLATFORMER MOVEMENT ===
func platformer_move(delta):
	var speed = platformer_speed
	if Input.is_action_pressed("ui_run"):
		speed *= run_multiplier

	# Horizontal input
	var input_dir = 0
	if Input.is_action_pressed("ui_left"):
		input_dir -= 1
	if Input.is_action_pressed("ui_right"):
		input_dir += 1

	velocity.x = input_dir * speed

	# Apply gravity
	velocity.y += gravity * delta

	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force

# === TOP-DOWN MOVEMENT ===
func topdown_move(delta):
	var input_vector = Vector2.ZERO

	if Input.is_action_pressed("ui_left"):
		input_vector.x -= 1
	if Input.is_action_pressed("ui_right"):
		input_vector.x += 1
	if Input.is_action_pressed("ui_up"):
		input_vector.y -= 1
	if Input.is_action_pressed("ui_down"):
		input_vector.y += 1

	input_vector = input_vector.normalized()
	var speed = topdown_speed

	if Input.is_action_pressed("ui_run"):
		speed *= run_multiplier

	velocity.x = input_vector.x * speed
	velocity.y = input_vector.y * speed

	# --- Top-down jump logic ---
	if Input.is_action_just_pressed("jump") and not topdown_is_jumping:
		topdown_is_jumping = true
		topdown_jump_speed = 400.0 # jump strength

	if topdown_is_jumping:
		topdown_jump_height += topdown_jump_speed * delta
		topdown_jump_speed -= 1200.0 * delta # gravity for jump
		if topdown_jump_height <= 0.0:
			topdown_jump_height = 0.0
			topdown_is_jumping = false
			
			# === PLAY ANIMATION ===
func play_animation():
	var sprite = $AnimatedSprite2D
	var variable = 1
	if is_platformer:
		if  not is_on_floor():
			sprite.play("jump")
			variable = variable + 1 
		elif abs(velocity.x) > 10:
			if Input.is_action_pressed("ui_run"):
				sprite.play("run")
			else:
				sprite.play("walk")
		else:
			sprite.play("idle")
	else:
		if velocity.length() > 10:
			if Input.is_action_pressed("ui_run"):
				sprite.play("run")
			else:
				sprite.play("walk")
		else:
			sprite.play("idle") 
			# Show idle when not moving in top-down mode


# === FLIP SPRITE BASED ON DIRECTION ===
func flip_sprite():
	var sprite = $AnimatedSprite2D
	if is_platformer:
		if abs(velocity.x) > 10:
			sprite.flip_h = velocity.x < 0
	else:
		if velocity.length() > 10:
			# Flip only if moving horizontally in top-down
			if abs(velocity.x) > abs(velocity.y):
				sprite.flip_h = velocity.x < 0
