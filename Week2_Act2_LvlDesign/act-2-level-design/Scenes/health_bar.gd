extends CanvasLayer # Changed from Control to CanvasLayer

@onready var container = $HBoxContainer

func remove_heart():
	var hearts = container.get_children()
	if hearts.size() > 0:
		# Deletes the last heart in the row
		var heart_to_remove = hearts[-1]
		heart_to_remove.queue_free()
		
		# Check if that was the last heart (1 because the one above isn't deleted yet)
		if hearts.size() == 1:
			call_deferred("_game_over")

func _game_over():
	# Restarts the level if you run out of hearts
	get_tree().reload_current_scene()
