class_name SumGroupDistance extends Node2D

@export var children: Array[Node2D] = []
# Source to use for summing distance
@export var source: Node2D

func add(node: Node2D):
	var existing = children.find(node)
	if existing == -1:
		children.push_back(node)
	else:
		push_error("Invalid add call made, not already in SumGroupDistance")

func remove(node: Node2D):
	var existing = children.find(node)
	if existing == -1:
		push_error("Invalid remove call made, node not in SumGroupDistance")
	children.remove_at(existing)