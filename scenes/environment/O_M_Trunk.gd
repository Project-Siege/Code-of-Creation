extends Node2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var hurt_component: HurtComponent = $HurtComponent
@onready var damage_component: DamageComponent = $DamageComponent
@onready var tree_trunk: Sprite2D = $TreeTrunk
var log_scene = preload("res://scenes/environment/mid_log.tscn")
var trunk_scene = preload("res://scenes/environment/O_M_Trunk.tscn")
var sap_scene = preload("res://scenes/environment/sap.tscn")

func _ready() -> void:
	hurt_component.hurt.connect(on_hurt)
	damage_component.max_damage_reached.connect(on_max_damage_reached)
	
func on_hurt(hit_damage: int) -> void:
	damage_component.apply_damage(hit_damage)
	tree_trunk.material.set_shader_parameter("shake_intensity", 0.5)

	await get_tree().create_timer(0.50).timeout
	tree_trunk.material.set_shader_parameter("shake_intensity", 0.0)


func on_max_damage_reached() -> void:
	print("max damage reached")
	#animation_player.play("bigFall")
	await get_tree().create_timer(0.50).timeout
	audio_stream_player_2d.play()
	add_sap_scene()
	queue_free()
	#
	
	
	
	

func add_log_scene() -> void:
	var log_instance = log_scene.instantiate() as Node2D
	log_instance.global_position = global_position
	get_parent().add_child(log_instance)
	

	
func add_sap_scene() -> void:
	var sap_instance = sap_scene.instantiate() as Node2D
	sap_instance.global_position = global_position
	get_parent().add_child(sap_instance)
