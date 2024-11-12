class_name FlockHerder2DChild

var body: CharacterBody2D
var path: Path2D
var index: int = 0
var speed: float
var bounds_radius: float = 5.0
### Vector2 or null
var next_point


func _init(init: CharacterBody2D, init_speed: float, init_bounds_radius: float, init_path: Path2D) -> void:
	self.body = init
	self.path = init_path
	self.speed = init_speed
	self.bounds_radius = init_bounds_radius

func next() -> void:
	index += 1

func position() -> Vector2:
	return self.body.position

func direction() -> Vector2:
	return self.body.velocity.normalized()

### Returns true if the line segment defined by start and end intersects with the bounds of the child
func interceptsBounds(start: Vector2, end: Vector2) -> bool:
	# Get the direction vector of the line segment
	var direction_vector: Vector2 = (end - start).normalized()
	# Get the distance of the line segment
	var distance: float = start.distance_to(end)
	# Get the intercept point of the line segment
	var intercept_point: Vector2 = start + direction_vector * distance
	# Return true if the intercept point is within the bounds radius of the child
	return intercept_point.distance_to(self.position()) < self.bounds_radius

func move_to_point(point: Vector2, custom_speed) -> void:
	self.next_point = point
	var speed_to_use = self.speed if custom_speed == null else custom_speed
	self.body.velocity = (point - self.body.position).normalized() * speed_to_use
	self.body.move_and_slide()

