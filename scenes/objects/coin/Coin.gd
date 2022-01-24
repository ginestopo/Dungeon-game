class_name Coin , "res://0x72_DungeonTilesetII_v1.4/frames/coin_anim_f0.png"
extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var random = RandomNumberGenerator.new()


var initial_position = Vector2(0.0,0.0)
var initial_argument
var argument

# Called when the node enters the scene tree for the first time.
func _ready():
	initial_position = self.position
	random.randomize()
	initial_argument = random.randf_range(0.0, PI)
	argument = initial_argument


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	bounce_effect(delta)

func _on_Area2D_body_entered(body):
	if(body.name == "Player"):
		print("taken")
		$AnimationPlayer.play("taken")
	
	
func bounce_effect(delta):
	
	self.position.y = initial_position.y + 80*sin(argument)*delta
	
	if(argument>2*PI):
		argument = initial_argument
	else:
		argument += 0.1
		
		
func delete_node():
	queue_free()

	

