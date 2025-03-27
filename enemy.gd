class_name Enemy
extends RigidBody3D


@export var target_node: NavigationTarget
@export var speed: float= 1.0

@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D
@onready var ground_check: RayCast3D = $"Ground Check RayCast3D"
@onready var model: MeshInstance3D = $Model



func _ready() -> void:
	target_node.position_changed.connect(update_target)
	update_target()


func _physics_process(delta: float) -> void:
	if ground_check.is_colliding():
		gravity_scale= 0
		linear_velocity.y= 0
		
		var destination: Vector3= navigation_agent.get_next_path_position()
		destination.y= global_position.y
		var vec: Vector3= destination - global_position
		var new_velocity: Vector3= vec.normalized() * min(vec.length(), 1.0) * speed
		linear_velocity= lerp(linear_velocity, new_velocity, 1.0 * delta)
		
		if vec.length() > 0.1:
			model.look_at(destination)
	else:
		gravity_scale= 1.0
		
		if global_position.y < -10:
			queue_free()


func update_target():
	navigation_agent.target_position= target_node.global_position
