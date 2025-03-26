extends Node3D

@onready var camera: Camera3D = $Camera3D
@onready var target: NavigationTarget = $Target

var mouse_position: Vector2


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouse_position= event.position
	elif event is InputEventMouseButton and event.is_pressed():
		var origin: Vector3= camera.project_ray_origin(mouse_position)
		var normal: Vector3= camera.project_ray_normal(mouse_position)
		var ray_query:= PhysicsRayQueryParameters3D.create(origin, origin + normal * 100)
		var result: Dictionary= get_world_3d().direct_space_state.intersect_ray(ray_query)
		if result:
			target.update_position(result.position)
