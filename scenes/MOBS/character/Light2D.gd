extends Light2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const LIGHT_SCALE = 0.38
var rng = RandomNumberGenerator.new()
var lambda = 0
var reach_scale = 0
var transisition_smoothness = Vector2(0.008,0.008)


# Called when the node enters the scene tree for the first time.
func _ready():
	lambda = random_scale()
	reach_scale = Vector2(LIGHT_SCALE,LIGHT_SCALE)*lambda

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if(self.scale.x > reach_scale.x):
		self.scale -= transisition_smoothness

	elif(self.scale.x < reach_scale.x):
		self.scale += transisition_smoothness
		
	if(abs(self.scale.x-reach_scale.x)<(transisition_smoothness.x*10)):
		lambda = random_scale()
		reach_scale = Vector2(LIGHT_SCALE,LIGHT_SCALE)*lambda
			
	
func random_scale():
	var random
	rng.randomize()
	random = rng.randf_range(0.85,1)
	return random

