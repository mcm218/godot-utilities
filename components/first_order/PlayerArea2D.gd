class_name PlayerArea2D extends Area2D

signal on_player_body_entered(player: CharacterBody2D)
signal on_player_body_exited(player: CharacterBody2D)


func _ready():
	body_entered.connect(_on_player_body_entered)
	body_exited.connect(_on_player_body_exited)

func _on_player_body_entered(potential: Node2D):
	print_debug("entity entered")
	if potential.is_in_group("player"):
		print_debug(_find_character_node(potential))
		print_debug("entity player")
		on_player_body_entered.emit(potential)
	return


func _on_player_body_exited(potential: Node2D):
	print_debug("entity exited")
	if potential.is_in_group("player"):
		print_debug(_find_character_node(potential))
		print_debug("entity exited")
		on_player_body_exited.emit(potential)
	return


func _find_character_node(node: Node2D) -> CharacterBody2D:
	if node is CharacterBody2D:
		return node

	var character_node: Array[Node] = node.find_children("", "CharacterBody2D", true)
	if character_node.size() > 0: return character_node[0]
	
	var parent_node: Node;
	while parent_node:
		if parent_node is CharacterBody2D:
			return parent_node
		
		parent_node = parent_node.get_parent()

	return null
