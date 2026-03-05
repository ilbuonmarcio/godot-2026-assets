extends Area2D

const PLAYER_SPEED = 275
var HEARTS = 3

@onready var game_state = %GameState
@onready var knives = %Knives
@onready var bombs = %Bombs
@onready var sprite2d_texture = $Sprite2D

const KNIFE_THROW_THRESHOLD = 0.5 # seconds
var knife_last_thrown_at = KNIFE_THROW_THRESHOLD

const BOMB_THROW_THRESHOLD = 3.0 # seconds
var bomb_last_thrown_at = BOMB_THROW_THRESHOLD

var knife_template = preload("res://scenes/knife.tscn")
var bomb_template = preload("res://scenes/bomb.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if HEARTS > 0:
		if Input.is_key_pressed(KEY_W):
			position.y -= PLAYER_SPEED * delta
		if Input.is_key_pressed(KEY_S):
			position.y += PLAYER_SPEED * delta
		if Input.is_key_pressed(KEY_A):
			position.x -= PLAYER_SPEED * delta
		if Input.is_key_pressed(KEY_D):
			position.x += PLAYER_SPEED * delta
			
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and knife_last_thrown_at >= KNIFE_THROW_THRESHOLD:
			throw_knife(game_state.mouse_coords)
			knife_last_thrown_at = 0
			
		if Input.is_key_pressed(KEY_Q) and bomb_last_thrown_at >= BOMB_THROW_THRESHOLD:
			throw_bomb(game_state.mouse_coords)
			bomb_last_thrown_at = 0
		
	knife_last_thrown_at += delta
	bomb_last_thrown_at += delta

func throw_knife(at: Vector2):
	var knife = knife_template.instantiate()
	
	knife.position = self.position
	
	knife.direction = self.position.direction_to(at)
	knives.add_child(knife)
	
func throw_bomb(at: Vector2):
	var bomb = bomb_template.instantiate()
	
	bomb.position = self.position
	
	bomb.direction = self.position.direction_to(at)
	bombs.add_child(bomb)
	
func hit():
	HEARTS -= 1
	# print("Ouch! Hearts left: ", HEARTS)
	
	if HEARTS == 0:
		sprite2d_texture.texture = load("res://images/grave.png")

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemies"):
		hit()
		area.vanish()
