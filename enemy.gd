extends RigidBody3D


@export var target_node: NavigationTarget
@export var speed: float= 1.0

@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D
@onready var ground_check: RayCast3D = $"Ground Check RayCast3D"



func _ready() -> void:
	target_node.position_changed.connect(update_target)
	update_target()


func _physics_process(_delta: float) -> void:
	if ground_check.is_colliding():
		gravity_scale= 0
		linear_velocity.y= 0
		
		var destination: Vector3= navigation_agent.get_next_path_position()
		destination.y= global_position.y
		var dir: Vector3= destination - global_position
		linear_velocity= dir.normalized() * min(dir.length(), 1.0) * speed
		print(linear_velocity)


func update_target():
	navigation_agent.target_position= target_node.global_position
