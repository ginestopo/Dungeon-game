extends StaticBody2D

var press_e_active = false
onready var press_e = $press_e
onready var text = $Message/text
var message_shown = false

export var message = ""


# Called when the node enters the scene tree for the first time.
func _ready():
	text.text = message
	
	#hide show_area
	$show_area.visible = false
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	press_e.visible = press_e_active
	$Message.visible = message_shown
	
	if press_e_active and Input.is_action_pressed("interact"):
		message_shown = true
		press_e_active = false
	
	if Input.is_action_pressed("ui_cancel"):
		message_shown = false



func _on_read_area_body_entered(body):
	if(body.name == "Player"):
		press_e_active = true;
	
	
func _on_read_area_body_exited(body):
	if(body.name == "Player"):
		press_e_active = false
		message_shown = false
		
