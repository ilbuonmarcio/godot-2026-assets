extends Node

@onready var background = %Background
@onready var player = %Player

var enemy_template = preload("res://scenes/enemy.tscn")

const WIDTH = 960
const HEIGHT = 960

var mouse_coords = Vector2(0, 0)
var player_coords = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	mouse_coords = get_viewport().get_mouse_position()
	player_coords = %Player.position
	# print(player_coords)

func _on_timer_timeout() -> void:
	var random_x = [randi_range(-32, 0), randi_range(WIDTH, WIDTH + 32)].pick_random()
	var random_y = [randi_range(-32, 0), randi_range(HEIGHT, HEIGHT + 32)].pick_random()
	
	var enemy = enemy_template.instantiate()
	enemy.position = Vector2(random_x, random_y)
	add_child(enemy)
	print("Enemy spawned")
