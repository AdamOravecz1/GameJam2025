extends  Node2D

@onready var main = get_tree().get_first_node_in_group("Main")

@export var move_speed := 25
@onready var way = $Way
@onready var gecko_animation = $GeckoAnimation

var hunger = 10
var nutrition = 20

var walk = false

func _ready():
	var angle_deg = randi_range(0, 359)
	var angle_rad = deg_to_rad(angle_deg)
	way.rotation = angle_rad
	
func _process(delta):
	if way.is_colliding():
		var angle_deg = randi_range(0, 359)
		var angle_rad = deg_to_rad(angle_deg)
		way.rotation = angle_rad
		
	if walk:
		var global_target_pos = way.global_position + way.transform.x * way.target_position.length()
		
		var direction = (global_target_pos - global_position).normalized()
		var movement = direction * move_speed * delta
		
		position += movement

func _on_timer_timeout():
	walk = !walk
	if walk:
		gecko_animation.play("walk")
	else:
		gecko_animation.play("stay")
	var angle_deg = randi_range(0, 359)
	var angle_rad = deg_to_rad(angle_deg)
	way.rotation = angle_rad
	$Timer.wait_time = randf_range(3, 5)
	$Timer.start()


func _on_size_body_entered(body):
	var angle_deg = randi_range(0, 359)
	var angle_rad = deg_to_rad(angle_deg)
	way.rotation = angle_rad
	
func _on_area_2d_area_entered(area):
	z_index = 2

func _on_area_2d_area_exited(area):
	z_index = 0

func cycle():
	hunger -= 1
	if hunger == 0:
		$Timer.stop()
		walk = false
		gecko_animation.play("eat")
		hunger = 10
		main.eat_small_animal()
		if not main.found_food:
			main.big_animal_present = null
			queue_free()
		



func _on_gecko_animation_animation_finished():
	if gecko_animation.animation == "eat":
		$Timer.start()
		gecko_animation.play("stay")
