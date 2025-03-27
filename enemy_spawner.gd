extends Node3D

@export var enemy_scene: PackedScene
@export var target: NavigationTarget



func _ready() -> void:
	spawn.call_deferred()


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_select"):
		spawn()


func spawn():
	var enemy: Enemy= enemy_scene.instantiate()
	enemy.position= global_position
	enemy.target_node= target
	get_tree().current_scene.add_child(enemy)
