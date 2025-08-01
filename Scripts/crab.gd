extends Node2D

@export var move_speed := 5  # Pixels per second
@onready var way = $Way

@onready var crab = $Crab

var walk = true

func _ready():
	var angle_deg = randi_range(0, 359)
	var angle_rad = deg_to_rad(angle_deg)
	way.rotation = angle_rad
	
func _process(delta):
	if way.is_colliding():
		way.rotation += deg_to_rad(180)
		
	if walk:
		var global_target_pos = way.global_position + way.transform.x * way.target_position.length()
		
		var direction = (global_target_pos - global_position).normalized()
		var movement = direction * move_speed * delta
		
		position += movement

func _on_area_2d_area_entered(area):
	z_index = 2

func _on_area_2d_area_exited(area):
	z_index = 0

func _on_timer_timeout():
	walk = !walk
	if walk:
		crab.play("walk")
	else:
		crab.play("stay")
	var angle_deg = randi_range(0, 359)
	var angle_rad = deg_to_rad(angle_deg)
	way.rotation = angle_rad
	await get_tree().create_timer(randf_range(3, 10))
	$Timer.start()

func _on_size_body_entered(body):
	way.rotation += deg_to_rad(180)
