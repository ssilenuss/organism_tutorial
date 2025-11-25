extends Node2D
class_name Organism

@export var species_id : Color
@export_enum("Vegetarian", "Omnivore", "Carnivore") var diet: int
@export var lifespan: int = 100
@export var max_health: int = 100
var grid : WorldGrid

# current status info
var grid_pos : Vector2
var age: int = 0
var health : int 
var fertile : bool = false
var size: float = 5.0

# Called when the node enters the scene tree for the first time.
func _ready()->void:
	health = max_health
	
func move_randomly()->void:
	var x_move : int = randi_range(-1,1) #returns -1, 0, or 1
	var y_move : int = randi()%2
	grid_pos += Vector2(x_move, y_move)
	position = Vector2(grid_pos.x * grid.grid_space, grid_pos.y * grid.grid_space)
	
	
func on_tick()->void:
	move_randomly()
	
	if check_neighbors_for_mates():
		spawn_child()
	
	#update age and die
	age += 1
	if age >= lifespan:
		queue_free()
		
func check_neighbors_for_mates()->bool:
	var mate_found : bool = false
	for o in grid.organisms.get_children():
		if o == self:
			return mate_found
		else:
			if o.grid_pos == grid_pos:
				mate_found = true
	return mate_found
	
func spawn_child()->void:
	var o := Organism.new()
	o.position = self.position
	o.grid_pos = self.grid_pos
	o.species_id = self.species_id
	o.grid = self.grid
	o.diet = self.diet
	grid.organisms.add_child(o)

	
func _draw()->void:
	draw_circle(Vector2.ZERO,size,species_id)
