extends CanvasLayer

@onready var container = $HBoxContainer

func remove_heart():
	var hearts = container.get_children()
	if hearts.size() > 0:
		var heart_to_remove = hearts[-1]
		heart_to_remove.queue_free()
		
		if hearts.size() == 1:
			call_deferred("_game_over")

func _game_over():
	get_tree().reload_current_scene()
