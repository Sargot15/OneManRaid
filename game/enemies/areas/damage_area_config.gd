class_name DamageAreaConfig extends Resource

@export var damage : float = 25

@export var pemanent_alive : bool
@export var min_time_alive : float
@export var max_time_alive : float

@export_group("Position", "pos_")
@export var pos_relative_to_boss : bool = false
@export var pos_random_x_left_range : float 
@export var pos_random_x_right_range : float 
@export var pos_random_y_top_range : float 
@export var pos_random_y_bottom_range : float 

@export_group("Shape")
enum AreaShape {CIRCLE, CIRCLE_INCOMPLETE, CIRCLE_INVERTED}
@export var area_shape : AreaShape

@export_subgroup("Circle shape", "circle_")
@export var circle_radius : float

@export_subgroup("Circle incomplete shape", "circle_incomplete_")
@export var circle_incomplete_radius : float
## The percentage amount of the circle what would be open: Example: 0.5 means the circle would be drawn at half; 0.75 means 1/4 of the circle would be drawn and 3/4 woule not.
@export_range(0, 1) var circle_incomplete_percentage_open : float

@export_subgroup("Circle inverted", "circle_inverted_")
@export var circle_inverted_radius : float
