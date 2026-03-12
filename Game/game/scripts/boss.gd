extends Area2D

const ENEMY_SPEED = 120

var game_state = null
var player = null
var near_bomb = false

var HEARTS = 5
var game_reset = false

@onready var sprite_2d = $Sprite2D
@onready var finished_game_timer = $FinishedGameTimer
var fireballs = null

var fireball_template = preload("res://scenes/fireball.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func set_game_state(g):
	game_state = g

func set_player(p):
	player = p
	
func set_fireballs(f):
	fireballs = f
	
func hit():
	HEARTS -= 1
	
	if HEARTS == 0:
		sprite_2d.texture = load("res://images/grave.png")
		
		if not game_reset:
			finished_game_timer.start()
			game_reset = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if HEARTS > 0:
		self.position += self.position.direction_to(player.position) * ENEMY_SPEED * delta

func throw_fireball(at: Vector2):
	var fireball = fireball_template.instantiate()
	
	fireball.position = self.position
	
	fireball.direction = self.position.direction_to(at)
	fireballs.add_child(fireball)
	
func throw_fireball_radius():
	for i in range(-3, 5, 1):
		var fireball = fireball_template.instantiate()
		
		fireball.position = self.position
		
		var angle = i * 0.75
		
		fireball.direction = self.position.from_angle(angle)
		fireballs.add_child(fireball)

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Bombs"):
		self.near_bomb = true
	
	if area.is_in_group("Knives"):
		self.hit()
	if area.is_in_group("Bombs") and self.near_bomb: # and area.exploded:
		self.hit()

func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("Bombs"):
		self.near_bomb = false


func _on_finished_game_timer_timeout() -> void:
	get_tree().reload_current_scene()

func _on_throw_at_player_timer_timeout() -> void:
	if HEARTS > 0:
		throw_fireball(player.position)

func _on_throw_radius_timer_timeout() -> void:
	if HEARTS > 0:
		throw_fireball_radius()
