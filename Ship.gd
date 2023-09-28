extends Area2D

var speed = 150  # pix/s
var cooldown = 0.25
var timeout = 5
var can_shoot = true
@export var bullet_scene: PackedScene

@onready var screensize = get_viewport_rect().size

func _ready():
	start()

func start():
	position = Vector2(screensize.x / 2,
						screensize.y - 64)
	$GunCooldown.wait_time = cooldown
	$Timeout.wait_time = timeout

func _process(delta):
	if Input.is_action_pressed("shoot"):
		shoot()
	var input = Input.get_vector("left", "right", "up", "down")
	if input.x > 0:
		$Sprite2D.frame = 2
	elif input.x < 0:
		$Sprite2D.frame = 0
	else:
		$Sprite2D.frame = 1
	position += input * speed * delta
	position = position.clamp(Vector2(8, 8), 
				screensize - Vector2(8, 8))

func shoot():
	if not can_shoot:
		return
	can_shoot = false
	$GunCooldown.start()
	var new_bullet = bullet_scene.instantiate()
	get_tree().root.add_child(new_bullet)
	new_bullet.start(position + Vector2(0, -12))

func _on_gun_cooldown_timeout():
	can_shoot = true

func _on_area_entered(area):
	if area.is_in_group("villains"):
		queue_free()
		area.death()
	elif area.is_in_group("enemies"):
		can_shoot = false
		$Timeout.start()
		

func _on_timeout_timeout():
	can_shoot = true
