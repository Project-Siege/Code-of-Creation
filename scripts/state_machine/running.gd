extends NodeState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D
@export var speed: int = 100




func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	var direction: Vector2 = GameInputEvents.movement_input()
	
	if direction == Vector2.UP:
		animated_sprite_2d.play("run_up")
	elif direction == Vector2.DOWN:
		animated_sprite_2d.play("run_down")
	elif direction == Vector2.LEFT:
		animated_sprite_2d.play("run_side")
		animated_sprite_2d.flip_h = true
	elif direction == Vector2.RIGHT:
		animated_sprite_2d.play("run_side")
		animated_sprite_2d.flip_h = false
		
	if direction != Vector2.ZERO:
		player.player_direction = direction
	
	player.velocity = direction * speed
	player.move_and_slide()

func _on_next_transitions() -> void:
	if !GameInputEvents.is_movement_input():
		transition.emit("Idle")
	if GameInputEvents.is_movement_input() && Input.is_action_just_released("run"):
		transition.emit("Walk")


func _on_enter() -> void:
	pass


func _on_exit() -> void:
	animated_sprite_2d.stop()
