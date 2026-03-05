extends Area2D

const SPEED = 400

const X_THRESHOLD = 960
const Y_THRESHOLD = 960

var direction = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += SPEED * direction * delta
	
	if position.x < 0 or position.x > X_THRESHOLD or position.y < 0 or position.y > Y_THRESHOLD:
		self.queue_free()
