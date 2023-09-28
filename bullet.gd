extends Area2D

var speed = 250

func start(pos):
	position = pos

func _process(delta):
	position.y -= speed * delta

func _on_area_entered(area):
	if area.is_in_group("enemies"):
		queue_free()
		area.explode()
	#elif area.is_in_group("villains"):
		#queue_free()
		#area.death()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
