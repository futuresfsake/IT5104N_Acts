extends Area2D

func _on_body_entered(body: Node2D) -> void:
	# Make sure your character node is actually named "Pink"
	if body.name == "Pink" or body.name == "Char": 
		get_tree().change_scene_to_file("res://Scenes/Level2.tscn")
