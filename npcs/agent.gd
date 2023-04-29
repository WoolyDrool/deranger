extends Node3D

var nav : NavigationMesh
var target : Node3D

var agent_speed = 10
var move_vec : Vector3

func _ready():
	pass

func _physics_process(delta):
	update_move_vec()

func update_move_vec():
	pass
