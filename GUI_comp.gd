extends MarginContainer

onready var number_label = $HBoxContainer/Bars/LifeBar/Count/Background/Number
onready var bar = $HBoxContainer/Bars/LifeBar/Gauge
onready var tween = $Tween

var animated_health = 0

func _ready():
	var player_max_health = $"../Opponent".max_health
	bar.max_value = player_max_health
	update_health(player_max_health)
	#tween.start()
	
func update_health(new_value):
	tween.interpolate_property(self, "animated_health", animated_health, new_value, 0.6, Tween.TRANS_LINEAR, Tween.EASE_IN)
	if not tween.is_active():
		tween.start()
	
		
func on_health_changed(health):
	update_health(health)
	print(health)
	
func _process(delta):
	var rounded_val = round(animated_health)
	number_label.text = str(rounded_val)
	bar.value = rounded_val