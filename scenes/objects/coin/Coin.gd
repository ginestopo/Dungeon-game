class_name Coin , "res://0x72_DungeonTilesetII_v1.4/frames/coin_anim_f0.png"
extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if(body.name == "Player"):
		$AnimationPlayer.play("taken")
	
func delete_node():
	queue_free()
	

