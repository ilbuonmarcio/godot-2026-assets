extends Area2D

var SPEED = 400
const MIN_SPEED_BEFORE_EXPLOSION = 50
var exploded = false

@onready var sprite_2d = $Sprite2D
@onready var speed_timer = $SpeedTimer
@onready var delete_timer = $DeleteTimer

var direction = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if SPEED >= MIN_SPEED_BEFORE_EXPLOSION:
		position += SPEED * direction * delta
	else:
		if not exploded:
			# Attiviamo la variable exploded
			exploded = true
			
			# Cambiamo la texture e lo scaliamo
			sprite_2d.texture = load("res://images/explosion.png")
			sprite_2d.scale *= 2
			
			# Dopo 1 secondo dall'esplosione, rimuoviamo la bomba
			delete_timer.start()

func _on_speed_timer_timeout() -> void:
	SPEED = SPEED / 2

func _on_delete_timer_timeout() -> void:
	self.queue_free()
