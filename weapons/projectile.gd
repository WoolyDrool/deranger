extends Area3D

@export var speed = 100


func _physics_process(delta):
	position += global_transform.basis * speed
	
