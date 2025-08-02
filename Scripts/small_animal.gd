extends Node2D

var rng = RandomNumberGenerator.new()

var health = 0
var hunger = 0
var nutrition = 0
var alive = true
var compost_counter = 5
var hunger_sensitive = 0

@export var move_speed := 5  # Pixels per second

@onready var dwarf_white_isopod = $DwarfWhiteIsopod
@onready var greenhouse_millipede = $GreenhouseMillipede
@onready var micro_land_snail = $MicroLandSnail
@onready var way = $Way

@onready var main = get_tree().get_first_node_in_group("Main")

@export_enum("dwarf_white_isopod", "greenhouse_millipede", "micro_land_snail")
var selected_creature: String = "dwarf_white_isopod":
	set(value):
		selected_creature = value
		if Engine.is_editor_hint():
			call_deferred("_update_visibility")
		else:
			_update_visibility()

func _ready():
	rng.randomize()
	_update_visibility()
	var angle_deg = randi_range(0, 359)
	var angle_rad = deg_to_rad(angle_deg)
	way.rotation = angle_rad
	
func _process(delta):
	if alive:
		if way.is_colliding():
			way.rotation += deg_to_rad(180)
		var global_target_pos = way.global_position + way.transform.x * way.target_position.length()
		
		var direction = (global_target_pos - global_position).normalized()
		var movement = direction * move_speed * delta
		if movement.x < 0:
			dwarf_white_isopod.flip_h = true
			greenhouse_millipede.flip_h = true
			micro_land_snail.flip_h = true
		else:
			dwarf_white_isopod.flip_h = false
			greenhouse_millipede.flip_h = false
			micro_land_snail.flip_h = false
		if movement.y > 0:
			greenhouse_millipede.flip_v = true
			dwarf_white_isopod.flip_v = true
		else:
			greenhouse_millipede.flip_v = false
			dwarf_white_isopod.flip_v = false
		
		position += movement

func _update_visibility():
	# Make sure nodes are ready
	if not is_node_ready():
		await ready

	dwarf_white_isopod.visible = (selected_creature == "dwarf_white_isopod")
	greenhouse_millipede.visible = (selected_creature == "greenhouse_millipede")
	micro_land_snail.visible = (selected_creature == "micro_land_snail")
	
	if selected_creature == "dwarf_white_isopod":
		move_speed = 15
	elif selected_creature == "greenhouse_millipede":
		move_speed = 10

func _on_timer_timeout():
	var angle_deg = randi_range(0, 359)
	var angle_rad = deg_to_rad(angle_deg)
	way.rotation = angle_rad

	# Create a new one-shot timer (avoids shared reference)
	var new_timer = get_tree().create_timer(rng.randf_range(3, 10))
	await new_timer.timeout

	$Timer.start()  # Restarts the original Timer (if needed)


func _on_area_2d_area_entered(area):
	z_index = 1

func _on_area_2d_area_exited(area):
	z_index = 0
	
func cycle():
	if health > 0:
		health -= 1
		if main.plant_material >= hunger:
			main.plant_material -= hunger
			main.add_small_animal(selected_creature)
		else:
			health -= hunger_sensitive
	else:
		if compost_counter == 0:
			queue_free()
		compost_counter -= 1
		triger_death()

	
func triger_death():
	alive = false
	dwarf_white_isopod.play("dead")
	greenhouse_millipede.play("dead")
	micro_land_snail.play("dead")
