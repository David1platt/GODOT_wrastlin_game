extends MarginContainer

onready var number_label = $HBoxContainer/Bars/LifeBar/Count/Background/Number
onready var bar = $HBoxContainer/Bars/LifeBar/Gauge
onready var tween = $Tween

var animated_health = 0

func _ready():
	print(game_manager.human_player)
	#var player_max_health = player.max_health
	#bar.max_value = player_max_health
	#update_health(player_max_health)
	tween.start()
	
func on_health_set(max_health):
	print(max_health)
	bar.max_value = max_health
	update_health(max_health);
	
func update_health(new_value):
	tween.interpolate_property(self, "animated_health", animated_health, new_value, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	if not tween.is_active():
		tween.start()
	
				
func on_health_changed(health):
	update_health(health)
	print(health)
	
func _process(delta):
	var rounded_val = round(animated_health)
	number_label.text = str(rounded_val)
	bar.value = rounded_val
