class_name HurtComponent
extends Area2D

@export var tool : DataTypes.Tools = DataTypes.Tools.None
@export var audio_stream_player_2d_2: AudioStreamPlayer2D
@export var wood_chips: CPUParticles2D
@export var rock: Sprite2D 


signal hurt


func _on_area_entered(area: Area2D) -> void:
	var hit_component = area as HitComponent
	
	if tool == hit_component.current_tool:
		hurt.emit(hit_component.hit_damage)
		if get_parent() != rock:		
			audio_stream_player_2d_2.play()
			wood_chips.emitting = true
