extends Node

class_name Weapon

@export var is_melee : bool
@export var fire_speed : float
var next_fire
var can_fire : bool
@export var reload_speed : float
var next_reload
var can_reload : bool
@export var clip_size : int
@export var uses_projectiles:bool
@export var projectile:PackedScene
@export var infinite_ammo:bool
@export var base_damage : int
@onready var projectile_spawnpoint = $"spawn_pos"

func _ready():
	# Debug only
	can_fire = true
	pass

func _process(delta):
	#projectile_spawnpoint.look_at(0, 0, 0)
	pass

func _input(event):
	if can_fire:
		if Input.is_action_just_pressed("weapon_fire"):
			_fire_primary()
	
	if can_reload:
		if Input.is_action_just_pressed("weapon_reload"):
			_reload()

func _fire_primary():
	print("Fired")
	if uses_projectiles:
		var inst = projectile.instantiate()
		owner.add_child(inst)
		inst.global_transform = projectile_spawnpoint.global_transform

func _reload():
	print("Reloaded")
