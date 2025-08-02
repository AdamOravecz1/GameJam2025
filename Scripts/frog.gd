extends Node2D

@onready var main = get_tree().get_first_node_in_group("Main")

@onready var frog_animation = $FrogAnimation
@onready var way = $Way
@export var move_speed := 100

var hunger = 20
var nutrition = 40

var direction = 1
var jump = false
var stay = true

func _ready():
	randomize()
	_set_random_angle()
	$Timer.start()

func _process(delta):
	if way.is_colliding():
		move_speed = 0
	else:
		move_speed = 100
	if jump:
		

		# This is the correct direction — global, rotated from the frog
		var dir = (way.to_global(way.target_position) - global_position).normalized()
		var movement = dir * move_speed * delta

		# Move by whole pixels
		position += movement.round()

func _on_timer_timeout():
	stay = !stay
	if stay:
		direction *= -1
		scale.x = direction
		_set_random_angle()
	else:
		jump = true
		frog_animation.play("jump")

	$Timer.wait_time = randf_range(3, 10)
	$Timer.start()

func _on_frog_animation_animation_finished():
	if frog_animation.animation == "eat":
		$Timer.start()
		frog_animation.play("stay")
	jump = false
	frog_animation.play("stay")

func _set_random_angle():
	var angle_deg = randi_range(45, 135)
	way.rotation = deg_to_rad(angle_deg)


func _on_area_2d_area_entered(area):
	z_index = 2


func _on_area_2d_area_exited(area):
	z_index = 0
	
func cycle():
	hunger -= 1
	if hunger == 0:
		$Timer.stop()
		jump = false
		frog_animation.play("eat")
		hunger = 20
		main.eat_small_animal()
		if not main.found_food:
			main.big_animal_present = null
			queue_free()
		
