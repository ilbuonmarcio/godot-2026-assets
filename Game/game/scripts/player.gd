extends Area2D

const PLAYER_SPEED = 250

@onready var game_state = %GameState
@onready var knives = %Knives

var knife_template = preload("res://scenes/knife.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:	
	if Input.is_key_pressed(KEY_W):
		position.y -= PLAYER_SPEED * delta
	if Input.is_key_pressed(KEY_S):
		position.y += PLAYER_SPEED * delta
	if Input.is_key_pressed(KEY_A):
		position.x -= PLAYER_SPEED * delta
	if Input.is_key_pressed(KEY_D):
		position.x += PLAYER_SPEED * delta
		
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		throw_knife(game_state.mouse_coords)

func throw_knife(at: Vector2):
	var knife = knife_template.instantiate()
	
	knife.position = self.position
	
	knife.direction = self.position.direction_to(at)
	knives.add_child(knife)
