class_name FlockHerder2D extends Node2D

@export var end_paths: Array[Path2D] = []
@export var speed: float = 1.0
@export var is_running: bool = false
@export var tolerance = 1
@export var speed_variablity = 0.25
@export var child_bounds_radius: float = 5.0

var flock: Array[FlockHerder2DChild] = []
var is_paused: bool = false

func _ready():
	GameState.on_state_changed.connect(_on_game_state_changed)

	var points: Array[Vector2] = [];
	for path in self.end_paths:
		points.append(path.curve.get_point_position(0))
	
	var children = get_children()
	for child in children:
		if child is CharacterBody2D:
			var child_speed: float = randf_range(self.speed * (1 - self.speed_variablity), self.speed * (1 + self.speed_variablity))
			var closest_index = _find_closest_point(points, child.position)
			flock.append(FlockHerder2DChild.new(child, child_speed, self.child_bounds_radius, self.end_paths[closest_index]))

func _on_game_state_changed(state: Enums.State):
	if state == Enums.State.PAUSED:
		is_paused = true
	else:
		is_paused = false

func _find_closest_point(points: Array[Vector2], point: Vector2) -> int:
	var closest = 0
	var closest_distance: float = INF
	for i in range(points.size()):
		var distance: float = point.distance_to(points[i])
		if distance < closest_distance:
			closest_distance = distance
			closest = i
	return closest

func _physics_process(_delta: float) -> void:
	if not is_running: return
	if is_paused: return

	var children_to_remove: Array[FlockHerder2DChild] = []

	for character in self.flock:
		character.next_point = null

	var moved_characters: Array[FlockHerder2DChild] = []

	# Flock serted by distance to their next point
	var sorted_flock: Array[FlockHerder2DChild] = self.flock.duplicate()
	sorted_flock.sort_custom(
		func (a, b) -> bool:
			var aIndex = a.index
			var bIndex = b.index
			var aPath = a.path
			var bPath = b.path
			var aNextPoint = aPath.curve.get_point_position(aIndex)
			var bNextPoint = bPath.curve.get_point_position(bIndex)
			return aNextPoint.distance_to(a.position()) < bNextPoint.distance_to(b.position())
	)


	for character in sorted_flock:
		var index = character.index
		var path = character.path
		if index >= path.curve.get_point_count() - 1: 
			children_to_remove.append(character)
			continue

		var body = character.body
		var target_position: Vector2 = path.curve.get_point_position(index)
		var original_speed = character.speed
		while intercepts_other_child(moved_characters, character) && original_speed > 0:
			character.speed -= -.25

		character.move_to_point(target_position, character.speed)
		moved_characters.append(character)

		character.speed = original_speed

		if is_character_at_point(body, target_position):
			character.next();

	for child in children_to_remove:
		var index = flock.find(child)
		if index != -1:
			flock.remove_at(index)

func is_character_at_point(body: CharacterBody2D, point: Vector2) -> bool:
	var distance: Vector2 = abs(body.position - point)
	return distance.x < tolerance && distance.y < tolerance

func play() -> void:
	print_debug("PLAYING FLOCK HERDER")
	is_running = true

func intercepts_other_child(children: Array[FlockHerder2DChild], child: FlockHerder2DChild) -> bool:
	for other_child in children:
		if child.interceptsBounds(child.position(), other_child.position()):
			return true
	return false
