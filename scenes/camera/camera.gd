class_name camera
extends Camera2D

var camera_resolution_x = ProjectSettings.get_setting("display/window/size/width")
var camera_resolution_y = ProjectSettings.get_setting("display/window/size/height")

onready var player = get_node("/root/Main/").find_node("Player")


var shake_amount = 2.0
var shake : bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_new_camera_position(get_player_grid_position())
	
	if(shake and $shake_time.time_left > 0.0):
		self.set_offset(Vector2( \
		rand_range(-1.0, 1.0) * shake_amount, \
		rand_range(-1.0, 1.0) * shake_amount  \
		))
	else:
		shake = false

	
func get_player_grid_position():
	var grid_position = Vector2(\
	floor(player.get_global_position().x/camera_resolution_x) \
	,floor(player.get_global_position().y/camera_resolution_y))
	
	return grid_position
	
func _new_camera_position(grid_position):
#	self.offset.x = camera_resolution_x * grid_position.x
#	self.offset.y = camera_resolution_y * grid_position.y
	self.position.x = 180 + camera_resolution_x * grid_position.x
	self.position.y = 180 + camera_resolution_y * grid_position.y
	


func _on_Player_hit():
	_shake(0.4)

func _shake(shake_time : float):
	$shake_time.wait_time = shake_time
	$shake_time.start()
	
	shake = true
	

	
	
	
	
