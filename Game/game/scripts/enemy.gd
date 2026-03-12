extends Area2D

const ENEMY_SPEED = 220

var game_state = null
var player = null
var near_bomb = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func set_game_state(g):
	game_state = g

func set_player(p):
	player = p
	
func vanish():
	self.queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:	
	self.position += self.position.direction_to(player.position) * ENEMY_SPEED * delta

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Bombs"):
		self.near_bomb = true
	
	if area.is_in_group("Knives"):
		self.vanish()
		# print("Enemy dead!")
		game_state.score_point()
	if area.is_in_group("Bombs") and self.near_bomb: # and area.exploded:
		self.vanish()
		# print("Enemy dead!")
		game_state.score_point()

func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("Bombs"):
		self.near_bomb = false
