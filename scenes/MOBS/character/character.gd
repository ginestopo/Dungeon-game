class_name Player , "res://0x72_DungeonTilesetII_v1.4/frames/knight_f_idle_anim_f0.png"
extends KinematicBody2D


export (int) var speed_walking = 100
var speed = speed_walking
export (int, 50) var speed_boost = 30;
var sprint_speed = speed_boost + speed_walking;

var velocity = Vector2()

var health = 100.0;
export (int,0,100) var damage_demon
export (float,0,100,0.1) var damage_cooldown_time = 1.0

onready var animated_sprite = $AnimatedSprite
onready var custom_animations = $AnimationPlayer
onready var damage_sound = $damage_sound

#traps variables
var in_trap = false
var damage_spikes = 35;


#signals
signal hit

#what object should not be visible outside field of view?? TO BE IMPLEMENTED
#export (Array) var types = [Demon, Coin]


# Called when the node enters the scene tree for the first time.
func _ready():
	$damage_cooldown.start()
	


func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("sprint"):
		speed = sprint_speed
	else:
		speed = speed_walking;

	
	velocity = velocity.normalized() * speed;
	
	if(velocity.x != 0):
		$AnimatedSprite.flip_h = velocity.x < 0

func _physics_process(delta):
	get_input()
	set_animation()
	collisions()
	velocity = move_and_slide(velocity)




func set_animation():
	if(velocity.length() != 0):
		animated_sprite.play("running")
	else:
		animated_sprite.play("idle")
		
		
func collisions():
	#detect collisions only if damage_cooldown allows
	if($damage_cooldown.time_left==0.0):
		#collision with enemies
		for i in get_slide_count():
			var collision = get_slide_collision(i)
			#print("I collided with ", collision.collider.name)
			
			#collided with enemy
	#		if(collision.collider.name == "demon"):
	#			custom_animations.play("damage_blinker")
	#			damage_sound.play()
			
			#another way to detect multiples enemies
			#note that every enemy instance has different name
			if("demon" in collision.collider.name):
				custom_animations.play("damage_blinker")
				damage_sound.play()
				emit_signal("hit")
				
				loose_health(damage_demon)
				
				$damage_cooldown.wait_time = damage_cooldown_time
				$damage_cooldown.start()
		
		if(in_trap == true):
			#damage because of spikes
			custom_animations.play("damage_blinker")
			damage_sound.play()
			emit_signal("hit")
			loose_health(damage_spikes)
			$damage_cooldown.wait_time = damage_cooldown_time
			$damage_cooldown.start()

	#		if(collision.collider is Enemy):
	#			custom_animations.play("damage_blinker")
	#			damage_sound.play()
	#			emit_signal("hit")
	#
	#			damage = 1.0
	#			loose_health(damage)
	#

func loose_health(damage_):
	health -= damage_
	health = clamp(health,0,100);
	
	
#
# FIELD OF VIEW TO DISPLAY ENEMIES
#

func _on_enemies_visible_body_entered(body):
	if body is KinematicBody2D:
		body.visible = true
#	for type in types:
#		if body is type:
#			body.visible = true

	


func _on_enemies_visible_body_exited(body):
#	for type in types:
#		if body is type:
#			body.visible = false
	if body is KinematicBody2D:
		body.visible = false


func _on_area2d_detector_area_entered(area):
	if("spikes" in area.get_parent().name):
		in_trap = true
		
	

func _on_area2d_detector_area_exited(area):
	in_trap = false
