extends Area2D
class_name Sword1 , "res://0x72_DungeonTilesetII_v1.4/frames/weapon_regular_sword.png"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var picked_up : bool = false

export (int) var offset_x = 0
export (int) var offset_y = 0

onready var Player = get_node("/root/Main/").find_node("Player")


# Called when the node enters the scene tree for the first time.
func _ready():
	$CollisionShape2D.disabled = true; #controlled by animation player
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	if(picked_up):
		self.position = Vector2(Player.position.x + offset_x,Player.position.y + offset_y)
		
		if Input.is_action_just_pressed("ui_select"):
			$sword_animation.play("sword1_attack")
			
		if(Player.velocity.x != 0):
			if(Player.velocity.x < 0):
				self.scale.x = -1
			else:
				self.scale.x = 1



func _on_detector_body_entered(body):
	picked_up = true
	$Sprite.visible = false; #controlled by animation player
	$detector/CollisionShape2D.disabled = true #it is already picked up
