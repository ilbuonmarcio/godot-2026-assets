extends Node

@onready var background = %Background
@onready var player = %Player
@onready var game_over_screen = %GameOverScreen
@onready var game_over_timer = %GameOverTimer
@onready var hearts_label = %HeartsLabel
@onready var score_label = %ScoreLabel

var enemy_template = preload("res://scenes/enemy.tscn")

var score = 0
var game_over = false

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
	
	hearts_label.text = "Hearts: " + str(player.HEARTS)
	score_label.text = "Score: " + str(score)
	
	# Check if game over
	if player.HEARTS <= 0 and not game_over:
		game_over_screen.visible = true
		game_over_timer.start()
		game_over = true

func _on_timer_timeout() -> void:
	var random_x = randf() * 960
	var random_y = randf() * 960
	
	if random_x >= 960 / 2:
		random_x += 960 / 2
	if random_x <= 960 / 2:
		random_x -= 960 / 2
	if random_y >= 960 / 2:
		random_y += 960 / 2
	if random_y <= 960 / 2:
		random_y -= 960 / 2
	
	var enemy = enemy_template.instantiate()
	enemy.position = Vector2(random_x, random_y)
	add_child(enemy)
	enemy.set_game_state(self)
	enemy.set_player(player)
	# print("Enemy spawned")

func score_point():
	score += 1
	print("Current score: {0}".format([score]))
	
func _on_game_over_timer_timeout() -> void:
	get_tree().reload_current_scene()
	
	
	
