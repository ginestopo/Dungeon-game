class_name Demon , "res://0x72_DungeonTilesetII_v1.4/frames/big_demon_idle_anim_f1.png" #for collisions
extends KinematicBody2D


export var speed = 200;
var direction = Vector2()
onready var sprite = $AnimatedSprite;

var rng = RandomNumberGenerator.new();
onready var my_random_number = null;

#onready var player = get_parent().get_parent().get_parent().find_node("Player")
onready var player = get_node("/root/Main/").find_node("Player")

#can the enemy watch the player?
var player_on_sight = false

var health = 100


# Called when the node enters the scene tree for the first time.
func _ready():
	direction = Vector2(0,0);
	$health_bar.visible = false
	self.visible = false
	$CollisionShape2D.disabled = false



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (player_on_sight and health>0):
		direction = player.get_global_position() - self.get_global_position()
		if(direction.x < 0):
			sprite.flip_h = true
		else:
			sprite.flip_h = false
	else:
		direction = Vector2(0,0)


	direction = move_and_slide(direction.normalized()*speed)
#	direction = move_and_slide(Vector2(0,0))

	animation()

	
	
func animation():
	if(direction.length() != 0):
		sprite.play("run");
	else:
		sprite.play("idle")
		


func _on_area_de_vision_body_entered(body):
	if(body.name == "Player"): #it detects tilesets too...
		player_on_sight = true;
		$AnimationPlayer.play("exclamation")
		$notices.play()


func _on_area_de_vision_body_exited(body):
	if(body.name == "Player"):	#it detects tilesets too...
		player_on_sight = false;
		

func _on_hitbox_area_entered(area):
	if(player_on_sight):
		$"exclamation mark".visible = false
	if(health>0):
		if area is Sword1: 
			$damaged.play()
			print("hit by sword1, health:", health)
			$AnimationPlayer.play("damaged")
			health -= 30
			$health_bar/ProgressBar.value = health
			
			if(health < 100): $health_bar.visible = true
			
			if(health <= 0):
				print("dying")
				$AnimationPlayer.play("dying")


func destroy_node():
	print("destroyed")
	queue_free()
	


func _on_VisibilityEnabler2D_viewport_exited(viewport):
	print("exited")
	
func _disable_collision() -> void:
	$CollisionShape2D.one_way_collision = true
