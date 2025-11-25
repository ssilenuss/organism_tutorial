extends Node2D
class_name WorldGrid

@export var grid_size:= Vector2(50,50)
@export var num_organisms0 :int = 50
@export var grid_space : int = 10
@export var organisms : Node

func _ready()->void:
	
	var species0_color_id := Color (randf(), randf(), randf(), 1.0)
	for i in num_organisms0:
		var o := Organism.new()
		o.grid = self
		o.grid_pos.x = randi_range(0, grid_size.x)
		o.grid_pos.y = randi_range(0, grid_size.y)
		o.position = Vector2(o.grid_pos.x * grid_space, o.grid_pos.y*grid_space)
		organisms.add_child(o)
		
		

func _on_tick_timer_timeout()->void:
	for o in organisms.get_children():
		(o as Organism).on_tick()
