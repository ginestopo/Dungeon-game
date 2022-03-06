extends KinematicBody2D
class_name ShyGuy , "res://0x72_DungeonTilesetII_v1.4/frames/skelet_idle_anim_f0.png"


onready var state_machine = $Animation/AnimationTree.get("parameters/playback")

var rng = RandomNumberGenerator.new()
var velocity = Vector2(0,0)
var speed = 50
var not_started_moving = true #moving time not started
var not_started_idle = true


func _ready():
	rng.randomize()
	$timers/timer_idle.wait_time = rng.randf_range(1,3)
	$timers/timer_idle.start()


func _process(delta):
	if !not_started_idle:
		print("timer idle left:", $timers/timer_idle.time_left)
	else:
		print("timer moving left:", $timers/timer_moving.time_left)
		
	if $timers/timer_idle.time_left == 0:
		if not_started_moving:
			state_machine.travel("run")
			not_started_moving = false
			not_started_idle = true
			velocity = Vector2(rng.randi_range(-1,1),rng.randi_range(-1,1))
			$timers/timer_moving.wait_time = rng.randi_range(1,3)
			$timers/timer_moving.start()
			
			if(velocity.x < 0):
				self.scale.x = -1
			else:
				self.scale.x = 1
			
		
		if $timers/timer_moving.time_left == 0:
			velocity = Vector2(0,0)
			if not_started_idle:
				state_machine.travel("idle")
				$timers/timer_idle.wait_time = rng.randi_range(1,5)
				$timers/timer_idle.start()
				not_started_idle = false
				not_started_moving = true
			
			
	velocity = move_and_slide(velocity.normalized()*speed)
