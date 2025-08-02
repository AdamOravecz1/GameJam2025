extends Node2D

var small_animal_scene := preload("res://Scenes/small_animal.tscn")
var frog := preload("res://Scenes/frog.tscn")
var crab := preload("res://Scenes/crab.tscn")
var gecko := preload("res://Scenes/gecko.tscn")

@onready var plant_sound = $PlantSound
@onready var animal_sound = $AnimalSound

@export var sound_off = preload("res://Sprites/SoundOff.png")
@export var sound_on = preload("res://Sprites/SoundOn.png")

var sound = true

var found_food = false
var type_to_eat = 0
var big_animal_present = null
var plant_material = 0.0
var fertilizer = 30
var restart_game = true

var score = 0

var moss = {
	"name" = "Moss",
	"live" = 0,
	"dead" = 0,
	"status" = 0,
	"showing" = 0.0,
	"growing_strength" = 1.0,
	"rot_rate" = -10,
	"hunger" = 1.0,
	"number" = 4,
	"nutrition" = 5.0
}

var fern = {
	"name" = "Fern",
	"live" = 0,
	"dead" = 0,
	"status" = 0,
	"showing" = 0.0,
	"growing_strength" = 0.7,
	"rot_rate" = -8,
	"hunger" = 0.7,
	"number" = 4,
	"nutrition" = 7.0
}

var pilea_glauca = {
	"name" = "PileaGlauca",
	"live" = 0,
	"dead" = 0,
	"status" = 0,
	"showing" = 0.0,
	"growing_strength" = 0.5,
	"rot_rate" = -5,
	"hunger" = 0.5,
	"number" = 4,
	"nutrition" = 10.0
}

var orchid = {
	"name" = "Orchid",
	"live" = 0,
	"dead" = 0,
	"status" = 0,
	"showing" = 0.0,
	"growing_strength" = 0.5,
	"rot_rate" = -10,
	"hunger" = 1.0,
	"number" = 2,
	"nutrition" = 19.0
}
var pothos = {
	"name" = "Pothos",
	"live" = 0,
	"dead" = 0,
	"status" = 0,
	"showing" = 0.0,
	"growing_strength" = 0.8,
	"rot_rate" = -15,
	"hunger" = 1.5,
	"number" = 2,
	"nutrition" = 15.0
}

var dwarf_snake_plant = {
	"name" = "DwarfSnakePlant",
	"live" = 0,
	"dead" = 0,
	"status" = 0,
	"showing" = 0.0,
	"growing_strength" = 1.0,
	"rot_rate" = -20,
	"hunger" = 2.0,
	"number" = 2,
	"nutrition" = 12.0
}

var plants = [moss, fern, pilea_glauca, orchid, dwarf_snake_plant, pothos]

var isopod = {
	"name" = "Isopod",
	"health" = 20,
	"eats" = 30.0,
	"nutrition" = 1.0,
	"hunger_sensitivity" = 1
}

var millipede = {
	"name" = "Millipede",
	"health" = 30,
	"eats" = 40.0,
	"nutrition" = 1.5,
	"hunger_sensitivity" = 2
}

var snail = {
	"name" = "Snail",
	"health" = 40,
	"eats" = 50.0,
	"nutrition" = 2.0,
	"hunger_sensitivity" = 3
}

var small_animals = {
	"isopod" = isopod,
	"millipede" = millipede,
	"snail" = snail
}

func _ready():
	Engine.time_scale = 0
	$Sound.icon = sound_on

func _on_moss_button_pressed():
	if moss["live"] < 4:
		if moss["dead"] > 0:
			moss["dead"] -= 1
		moss["live"] += 1
		$Moss.get_children()[moss["showing"]].show()
		$Moss.get_children()[moss["showing"] + 4].hide()
		plant_sound.play()
		moss["showing"] += 1

func _on_fern_button_pressed():
	if fern["live"] < 4:
		if fern["dead"] > 0:
			fern["dead"] -= 1
		fern["live"] += 1
		$Fern.get_children()[fern["showing"]].show()
		$Fern.get_children()[fern["showing"] + 4].hide()
		plant_sound.play()
		fern["showing"] += 1

func _on_pilea_glauca_button_pressed():
	if pilea_glauca["live"] < 4:
		if pilea_glauca["dead"] > 0:
			pilea_glauca["dead"] -= 1
		pilea_glauca["live"] += 1
		$PileaGlauca.get_children()[pilea_glauca["showing"]].show()
		$PileaGlauca.get_children()[pilea_glauca["showing"] + 4].hide()
		plant_sound.play()
		pilea_glauca["showing"] += 1

func _on_orchid_button_pressed():
	if orchid["live"] < 2:
		if orchid["dead"] > 0:
			orchid["dead"] -= 1
		orchid["live"] += 1
		$Orchid.get_children()[orchid["showing"]].show()
		$Orchid.get_children()[orchid["showing"] + 2].hide()
		plant_sound.play()
		orchid["showing"] += 1

func _on_pothos_button_pressed():
	if pothos["live"] < 2:
		if pothos["dead"] > 0:
			pothos["dead"] -= 1
		pothos["live"] += 1
		$Pothos.get_children()[pothos["showing"]].show()
		$Pothos.get_children()[pothos["showing"] + 2].hide()
		plant_sound.play()
		pothos["showing"] += 1

func _on_dwarf_snake_plant_button_pressed():
	if dwarf_snake_plant["live"] < 2:
		if dwarf_snake_plant["dead"] > 0:
			dwarf_snake_plant["dead"] -= 1
		dwarf_snake_plant["live"] += 1
		$DwarfSnakePlant.get_children()[dwarf_snake_plant["showing"]].show()
		$DwarfSnakePlant.get_children()[dwarf_snake_plant["showing"] + 2].hide()
		plant_sound.play()
		dwarf_snake_plant["showing"] += 1

func _on_isopod_pressed():
	add_small_animal("dwarf_white_isopod")
	animal_sound.play()

func _on_millipede_pressed():
	add_small_animal("greenhouse_millipede")
	animal_sound.play()

func _on_snail_pressed():
	add_small_animal("micro_land_snail")
	animal_sound.play()

func _on_frog_pressed():
	if big_animal_present == null:
		animal_sound.play()
		var animal := frog.instantiate()
		var rand_x = randi_range(-40, 70)
		var rand_y = randi_range(25, 100)
		animal.position = Vector2(rand_x, rand_y)
		$Animals/Frog.add_child(animal)
		big_animal_present = animal

func _on_crab_pressed():
	if big_animal_present == null:
		animal_sound.play()
		var animal := crab.instantiate()
		var rand_x = randi_range(-40, 70)
		var rand_y = randi_range(25, 100)
		animal.position = Vector2(rand_x, rand_y)
		$Animals/Crab.add_child(animal)
		big_animal_present = animal

func _on_gecko_pressed():
	if big_animal_present == null:
		animal_sound.play()
		var animal := gecko.instantiate()
		var rand_x = randi_range(-40, 70)
		var rand_y = randi_range(25, 100)
		animal.position = Vector2(rand_x, rand_y)
		$Animals/Gecko.add_child(animal)
		big_animal_present = animal
	
func add_small_animal(name):
	var small_animal := small_animal_scene.instantiate()
	small_animal.selected_creature = name
	var rand_x = randi_range(-50, 50)
	var rand_y = randi_range(0, 100)
	small_animal.position = Vector2(rand_x, rand_y)

	var parts = name.split("_")
	small_animal.health = small_animals[parts[-1]]["health"]
	small_animal.hunger = small_animals[parts[-1]]["eats"]
	small_animal.nutrition = small_animals[parts[-1]]["nutrition"]
	small_animal.hunger_sensitive = small_animals[parts[-1]]["hunger_sensitivity"]
	
	var category = parts[-1].capitalize()
	
	var parent_node = $Animals.get_node_or_null(category)
	
	if parent_node:
		parent_node.add_child(small_animal)
	else:
		push_error("No such category node: %s" % category)


func _on_timer_timeout():
	score += 1
	
	restart_game = true
	plant_loop(pilea_glauca)
	plant_loop(fern)
	plant_loop(moss)
	plant_loop(orchid)
	plant_loop(pothos)
	plant_loop(dwarf_snake_plant)
	small_animal_cycle()
	big_animal_cycle()
	print("fertilizer: ", fertilizer)
	#print("plant_material: ", plant_material)
	if restart_game:
		plant_material = 0
		fertilizer = 30
		Engine.time_scale = 0
		score = 0
		
	$Score.text = str(score)

	
func plant_loop(plant):
	if plant["live"] > 0 or plant["dead"] > 0:
		restart_game = false
		plant_material += plant["live"] * plant["nutrition"]
		var hunger = plant["hunger"]*plant["live"] + plant["dead"]*(plant["hunger"]/4)
		var plant_node_name = plant["name"]
		var plant_node = get_node(plant_node_name)
		var children = plant_node.get_children()
		if fertilizer >= hunger:
			fertilizer -= hunger
		if fertilizer <= hunger:
			plant["status"] -= 1
		else:
			plant["status"] += plant["live"]*plant["growing_strength"] + plant["dead"]*(plant["growing_strength"]/2)
		if plant["status"] >= 5:
			if plant["live"] == plant["number"]:
				plant["status"] = 5
			else:
				plant["status"] = 0
			if plant["live"] < plant["number"]:
				if plant["dead"] > 0:
					plant["dead"] -= 1
				plant["live"] += 1
				children[plant["showing"]].show()
				children[plant["showing"] + plant["number"]].hide()
				plant["showing"] += 1
		elif plant["status"] <= plant["rot_rate"]/2 and plant["live"] > 0:
			if plant["dead"] != plant["number"]:
				plant["status"] = 0
			if plant["dead"] < plant["number"]:
				plant["dead"] += 1
				plant["live"] -= 1
				plant["showing"] -= 1
				children[plant["showing"]].hide()
				children[plant["showing"] + plant["number"]].show()
		if plant["status"] <= plant["rot_rate"]:
			plant["status"] = 0
			if plant["dead"] > 0:
				children[plant["dead"] + plant["number"]-1].hide()
				plant["dead"] -= 1
		
	#print(plant["name"])
	#print("live: ", plant["live"])
	#print("dead: ", plant["dead"])
	#print("showing: ", plant["showing"])
	#print("status: ", plant["status"])
	#print("--------------")
	
func small_animal_cycle():
	var isopods = $Animals/Isopod.get_children()
	var millipedes = $Animals/Millipede.get_children()
	var snails = $Animals/Snail.get_children()

	var max_len = max(isopods.size(), millipedes.size(), snails.size())

	for i in range(max_len):
		restart_game = false
		if i < snails.size():
			snails[i].cycle()
		if i < millipedes.size():
			millipedes[i].cycle()
		if i < isopods.size():
			isopods[i].cycle()
			
func big_animal_cycle():
	if big_animal_present:
		restart_game = false
		big_animal_present.cycle()
		
func eat_small_animal():
	var tried = 0
	found_food = false
	while tried < 3 and not found_food:
		var current_type = (type_to_eat + tried) % 3
		match current_type:
			0:
				if $Animals/Isopod.get_child_count() > 0:
					$Animals/Isopod.get_child(0).queue_free()
					fertilizer += big_animal_present.nutrition * isopod["nutrition"]
					print("iso")
					found_food = true
			1:
				if $Animals/Millipede.get_child_count() > 0:
					$Animals/Millipede.get_child(0).queue_free()
					fertilizer += big_animal_present.nutrition * millipede["nutrition"]
					print("milli")
					found_food = true
			2:
				if $Animals/Snail.get_child_count() > 0:
					$Animals/Snail.get_child(0).queue_free()
					fertilizer += big_animal_present.nutrition * snail["nutrition"]
					print("snail")
					found_food = true
		tried += 1

	type_to_eat += 1

func _on_sound_pressed():
	var bus_index = AudioServer.get_bus_index("SFX")
	var is_muted = $Sound.button_pressed
	
	AudioServer.set_bus_mute(bus_index, is_muted)
	$Sound.icon = sound_off if is_muted else sound_on


func _on_start_pressed():
	Engine.time_scale = 1
