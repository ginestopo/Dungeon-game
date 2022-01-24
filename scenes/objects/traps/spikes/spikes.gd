extends StaticBody2D

onready var anim_tree = $AnimationTree
onready var state_machine = $AnimationTree.get("parameters/playback")
var activated = false

func _ready():
	pass
	
func _process(delta):
	if($Timer.time_left < 0.01 and activated == true):
		state_machine.travel("desactivating")
		activated = false

func _on_damage_area_body_entered(body):
	state_machine.travel("activated")
	activated = true
	if $Timer.is_stopped():
		$Timer.start()
	
