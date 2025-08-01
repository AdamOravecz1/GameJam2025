extends Node2D

var small_animal_scene := preload("res://Scenes/small_animal.tscn")
var frog := preload("res://Scenes/frog.tscn")
var crab := preload("res://Scenes/crab.tscn")
var gecko := preload("res://Scenes/gecko.tscn")

var life = {
	"moss" = 0,
	"fern" = 0,
	"pilea_glauca" = 0,
	"orchid" = 0,
	"pothos" = 0,
	"dwarf_snake_plant" = 0,
	"dwarf_white_isopod" = 0,
	"greenhouse_millipede" = 0,
	"micro_land_snail" = 0,
	"frog" = 0,
	"crab" = 0,
	"geckko" = 0
}

func _on_moss_button_pressed():
	if life["moss"] < 4:
		life["moss"] += 1
		$Moss.get_children()[life["moss"] - 1].show()

func _on_fern_button_pressed():
	if life["fern"] < 4:
		life["fern"] += 1
		$Fern.get_children()[life["fern"] - 1].show()

func _on_pilea_glauca_button_pressed():
	if life["pilea_glauca"] < 4:
		life["pilea_glauca"] += 1
		$PileaGlauca.get_children()[life["pilea_glauca"] - 1].show()

func _on_orchid_button_pressed():
	if life["orchid"] < 2:
		life["orchid"] += 1
		$Orchid.get_children()[life["orchid"] - 1].show()

func _on_pothos_button_pressed():
	if life["pothos"] < 2:
		life["pothos"] += 1
		$Pothos.get_children()[life["pothos"] - 1].show()

func _on_dwarf_snake_plant_button_pressed():
	if life["dwarf_snake_plant"] < 2:
		life["dwarf_snake_plant"] += 1
		$DwarfSnakePlant.get_children()[life["dwarf_snake_plant"] - 1].show()

func _on_isopod_pressed():
	add_small_animal("dwarf_white_isopod")

func _on_millipede_pressed():
	add_small_animal("greenhouse_millipede")

func _on_snail_pressed():
	add_small_animal("micro_land_snail")

func _on_frog_pressed():
	var animal := frog.instantiate()
	var rand_x = randi_range(-40, 70)
	var rand_y = randi_range(25, 100)
	animal.position = Vector2(rand_x, rand_y)
	$Animals/Frog.add_child(animal)
	life["frog"] += 1


func _on_crab_pressed():
	var animal := crab.instantiate()
	var rand_x = randi_range(-40, 70)
	var rand_y = randi_range(25, 100)
	animal.position = Vector2(rand_x, rand_y)
	$Animals/Crab.add_child(animal)
	life["crab"] += 1


func _on_gecko_pressed():
	var animal := gecko.instantiate()
	var rand_x = randi_range(-40, 70)
	var rand_y = randi_range(25, 100)
	animal.position = Vector2(rand_x, rand_y)
	$Animals/Gecko.add_child(animal)
	life["gecko"] += 1
	
func add_small_animal(name):
	var small_animal := small_animal_scene.instantiate()
	small_animal.selected_creature = name
	var rand_x = randi_range(-50, 50)
	var rand_y = randi_range(0, 100)
	small_animal.position = Vector2(rand_x, rand_y)
	var parts = name.split("_")
	var category = parts[-1].capitalize()
	
	var parent_node = $Animals.get_node_or_null(category)
	if parent_node:
		parent_node.add_child(small_animal)
	else:
		push_error("No such category node: %s" % category)

	life[name] += 1

