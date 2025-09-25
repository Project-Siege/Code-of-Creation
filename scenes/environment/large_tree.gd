extends Node2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var hurt_component: HurtComponent = $HurtComponent
@onready var damage_component: DamageComponent = $DamageComponent
@onready var tree_trunk: Sprite2D = $TreeTrunk
@onready var tree_leave: Sprite2D = $TreeTrunk/TreeLeaves
var log_scene = preload("res://scenes/environment/large_log.tscn")
var trunk_scene = preload("res://scenes/environment/O_L_Trunk.tscn")
var branch_scene = preload("res://scenes/environment/small_log.tscn")

func _ready() -> void:
	hurt_component.hurt.connect(on_hurt)
	damage_component.max_damage_reached.connect(on_max_damage_reached)
	
func on_hurt(hit_damage: int) -> void:
	damage_component.apply_damage(hit_damage)
	tree_trunk.material.set_shader_parameter("shake_intensity", 0.5)
	tree_leave.material.set_shader_parameter("shake_intensity", 0.5)
	await get_tree().create_timer(1.0).timeout
	tree_trunk.material.set_shader_parameter("shake_intensity", 0.0)
	tree_leave.material.set_shader_parameter("shake_intensity", 0.0)

func on_max_damage_reached() -> void:
	print("max damage reached")
	await get_tree().create_timer(0.32).timeout
	animation_player.play("bigFall")
	audio_stream_player_2d.play()
	add_trunk_scene()
	await get_tree().create_timer(1.00).timeout
	queue_free()
	add_log_scene()

	add_branch_scene()

func add_log_scene() -> void:
	var log_instance = log_scene.instantiate() as Node2D
	log_instance.global_position = global_position - Vector2(50, 0)
	get_parent().add_child(log_instance)
	
func add_trunk_scene() -> void:
	var trunk_instance = trunk_scene.instantiate() as Node2D
	trunk_instance.global_position = global_position
	get_parent().add_child(trunk_instance)
	
func add_branch_scene() -> void:
	var branch_instance = branch_scene.instantiate() as Node2D
	branch_instance.global_position = global_position - Vector2(25,15)
	get_parent().add_child(branch_instance)
