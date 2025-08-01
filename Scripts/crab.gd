extends Node2D

@onready var main = get_tree().get_first_node_in_group("Main")

@export var move_speed := 5  # Pixels per second
@onready var way = $Way

@onready var crab = $Crab

var hunger = 30
var nutrition = 60

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
	$Timer.wait_time = randf_range(3, 10)
	$Timer.start()

func _on_size_body_entered(body):
	way.rotation += deg_to_rad(180)
	
func cycle():
	hunger -= 1
	if hunger == 0:
		$Timer.stop()
		crab.play("eat")
		walk = false
		hunger = 30
		main.eat_small_animal()
		if main.found_food:
			main.fertilizer += nutrition
		else:
			main.big_animal_present = null
			queue_free()


func _on_crab_animation_finished():
	if crab.animation == "eat":
		$Timer.start()
		crab.play("stay")
