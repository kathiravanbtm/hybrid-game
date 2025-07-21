extends CharacterBody2D

# === CONFIG ===
@export var platformer_speed := 600.0
@export var jump_force := -800.0
@export var gravity := 1200.0
@export var run_multiplier := 1.5
@export var topdown_speed := 200.0

var is_platformer := true

# === Called every physics frame ===
func _physics_process(delta):
	if Input.is_action_just_pressed("ui_tab"):
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

# === PLATFORMER MOVEMENT ===
func platformer_move(delta):
	var speed = platformer_speed
	if Input.is_action_pressed("ui_run"):
		speed *= run_multiplier

	# Horizontal input
	velocity.x = (
		-1.0 if Input.is_action_pressed("ui_left") else 0.0
	) + (
		1.0 if Input.is_action_pressed("ui_right") else 0.0
	)
	velocity.x *= speed

	# Apply gravity
	velocity.y += gravity * delta

	# Jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
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

	velocity = input_vector * speed

# === PLAY ANIMATION ===
func play_animation():
	var sprite = $AnimatedSprite2D

	if is_platformer:
		if not is_on_floor():
			sprite.play("jump")
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
			sprite.play("walk")
